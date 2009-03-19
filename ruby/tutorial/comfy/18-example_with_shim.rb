# Helper method from ActiveSupport. 
class Module
  def delegate(*methods)
    options = methods.pop
    unless options.is_a?(Hash) && to = options[:to]
      raise ArgumentError, "Delegation needs a target. Supply an options hash with a :to key as the last argument (e.g. delegate :hello, :to => :greeter)."
    end

    if options[:prefix] == true && options[:to].to_s =~ /^[^a-z_]/
      raise ArgumentError, "Can only automatically set the delegation prefix when delegating to a method."
    end

    prefix = options[:prefix] && "#{options[:prefix] == true ? to : options[:prefix]}_"

    methods.each do |method|
      module_eval(<<-EOS, "(__DELEGATION__)", 1)
        def #{prefix}#{method}(*args, &block)
          #{to}.__send__(#{method.inspect}, *args, &block)
        end
      EOS
    end
  end
end

# Helper method from ActiveSupport.
module HashPatches
  
  # Return a new hash with all keys converted to strings.
  def stringify_keys
    inject({}) do |options, (key, value)|
      options[key.to_s] = value
      options
    end
  end

  # Destructively convert all keys to strings.
  def stringify_keys!
    keys.each do |key|
      self[key.to_s] = delete key
    end
    self
  end
  
end

class Hash
  include HashPatches
end

module Tropo
  
  class TropoEvent
  
    attr_reader :name, :value, :recording_uri
    def initialize(name, value=nil, recording_uri=nil)
      @name, @value, @recording_uri = name, value, recording_uri
    end
  
  end

  class CallbackDefinitionContainer
  
    VALID_EVENT_NAMES = [:choice, :bad_choice, :timeout, :error, :hangup, :record, :silence_timeout]
  
    class << self    
      def validate_event_name(name)
        VALID_EVENT_NAMES.include? name
      end
    end
  
    def initialize
      @callbacks = {}
      yield self if block_given?
    end
  
    def on(name, &callback)
      @callbacks[name] ||= []
      @callbacks[name] << callback
    end
  
    VALID_EVENT_NAMES.each do |event_name|
      define_method "#{event_name}_callbacks" do
        @callbacks[event_name] || []
      end
    end

    def trigger_event_for(event_name, *args)
      # Pass in the argument to the block if arg is not nil
      event = TropoEvent.new(event_name, *args)
      callbacks = @callbacks[event_name].to_a + @callbacks[:event].to_a
      callbacks.each { |callback| callback.call event }
    end
  
  end

  class TropoCall
  
    DEFAULT_RECORD_OPTIONS = {
      'repeat'  => 1,
      'record'  => true,
      'beep'    => true,
      'maxTime' => 30,
      'timeout' => 30,
      'silenceTimeout' => 3
    }.freeze
  
    DEFAULT_TRANSFER_OPTIONS = {
      "answerOnMedia" => false,
      "timeout"       => 30_000,
      "method"        => "bridged",
      "playrepeat"    => 1
    }.freeze
  
    DEFAULT_PROMPT_OPTIONS = {
      "grammar"          => "",
      "bargein"          => true,
      "choiceConfidence" => "0.3",
      "choiceMode"       => "any",
      "timeout"          => 30_000,
      "repeat"           => 0,
      "ttsOrUrl"         => ""
    }.freeze
    
    DEFAULT_CALL_OPTIONS = {
      "callerId" => "sip:Tropo@10.6.69.201",
      "timeout"  => 30_000,
      "answerOnMedia" => false
    }.freeze
  
    def initialize(call)
      @call = call
    end
    
    delegate :log, :wait, :called_id, :caller_id, :caller_name, :called_name, 
             :state, :active?, :redirect, :reject, :hangup,
             :to => :@call

    def answer(timeout=6_000)
      @call.answer timeout
    end

    def call(who, options=DEFAULT_CALL_OPTIONS)
      options = options.equal?(DEFAULT_CALL_OPTIONS) ? options.dup : DEFAULT_CALL_OPTIONS.merge(options.stringify_keys)
      options["timeout"] &&= format_time options["timeout"]
      
      callbacks = CallbackDefinitionContainer.new
      yield callbacks if block_given?
      
      new_call = $callFactory.call(*options.values_at("callerId", "who", "answerOnMedia", "timeout"))
      
      callbacks.trigger_event_for :answer, new_call
      
      new_call
    rescue => error
      case error.message
        when /Outbound call is timeout/
          callbacks.trigger_event_for :timeout
        when /Outbound call can not complete/
          callbacks.trigger_event_for :callfailure
        else
          log error.inspect
          callbacks.trigger_event_for :error, error.message
          raise error
      end
    end
    
    def hangup
      @call.hangup
    end
    
    def log(message=nil)
      if $currentCall != nil && $currentCall.isActive
        $currentCall.log "Script Log==>" + "#" * 100
        $currentCall.log message.inspect
        $currentCall.log "Script Log==>" + "#" * 100
      else
        $appInstance.log "Script Log==>" + "#" * 100
        $appInstance.log message.inspect
        $appInstance.log "Script Log==>" + "#" * 100
      end
    end
    
    def record(spoken_text, options=DEFAULT_RECORD_OPTIONS)
      options = options.equal?(DEFAULT_RECORD_OPTIONS) ? options.dup : DEFAULT_RECORD_OPTIONS.merge(options.stringify_keys)
      options["record"] = true # Just to make sure
      prompt spoken_text, options
    end
    
    def redirect(destination)
      @call.redirect destination
    end
    
    def reject
      @call.reject
    end
    
    ##
    # Note: I changed how the formerlly-named "onRecord" callback works: the callback(s) will receive a record event
    # regardless of whether a grammar was given. Before the onRecord callback would get the same event as onChoice.
    #
    def prompt(spoken_text, options=DEFAULT_PROMPT_OPTIONS)
      options = options.equal?(DEFAULT_PROMPT_OPTIONS) ? options.dup : DEFAULT_PROMPT_OPTIONS.merge(options.stringify_keys)
      options["ttsOrUrl"]  = spoken_text if spoken_text
      options["timeout"] &&= format_time options["timeout"]
      options["maxTime"] &&= format_time options["maxTime"]
      options["repeat"]  &&= [1, options["repeat"].to_i].max
      
      ##
      # If a block is given to transfer, a CallbackDefinitionContainer will be yielded on which callbacks can be defined.
      #
      callback_registrar = CallbackDefinitionContainer.new
      yield callback_registrar if block_given?

      grammar = options["choices"]
      event = nil
      
      options["repeat"].times do
        begin
          if options["record"]
            result = @call.promptWithRecord(
                options["ttsOrUrl"],
                grammar.to_s,
                *options.values_at(*%w[timeout record beep maxTime silenceTimeout])
            )
            event = TropoEvent.new("record", result.get('value'), result.get('recordURL'))
            callback_registrar.trigger_event_for :choice, result.get("value"), result.get("record") if grammar
            callback_registrar.trigger_event_for :record, result.get("record") # This intentionally deviates from the spec at the moment by not passing in a second argument and by using the name :record! We need to make this consistent.
            return event
          else
            result = @call.prompt(options["ttsOrUrl"], options["bargein"], grammar, options["choiceConfidence"], options["choiceMode"], options["timeout"])
            event = TropoEvent.new("choice", result.get('value'))
            callback_registrar.trigger_event_for :choice, result.get("value"), result.get("record") if grammar
            return event
          end
        rescue => error
          case error.message
            when /No_?Speech/i
              event = TropoEvent.new("timeout", nil)
              callback_registrar.trigger_event_for :timeout
            when /NO_MATCH/i
              event = TropoEvent.new("bad_choice", nil)
              callback_registrar.trigger_event_for :bad_choice
            when /silenceTimeout/i
              event = TropoEvent.new("silence_timeout", nil)
              callback_registrar.trigger_event_for :silence_timeout
            when /MrcpDisconnectedException/
              event = TropoEvent.new("hangup", nil)
              callback_registrar.trigger_event_for :hangup
              return
            else
              event = TropoEvent.new("error", error.message)
              callback_registrar.trigger_event_for :error, error.message
              raise error
          end
        end
      end
      return event
    rescue => e
      log e.message
    end
    
    ##
    # Converts a Time object to a Fixnum (integer) representing milliseconds.
    #
    def format_time(time)
      time = time.to_f * 1_000
      [0, time.to_i].max
    end
    
    alias ask prompt
    alias say prompt
  
    def transfer(to, options={})
      options = DEFAULT_TRANSFER_OPTIONS.merge options
    
      # If a block is given to transfer, a CallbackDefinitionContainer will be yielded on which callbacks can be defined.
      callback_registrar = CallbackDefinitionContainer.new
      yield callback_registrar if block_given?
      
      log options.values_at(*%w[callerId answerOnMedia timeout playvalue playrepeat choices]).inspect
      native_call = @call.transfer to.to_s, *options.values_at(*%w[callerId answerOnMedia timeout playvalue playrepeat choices])
      tropo_call  = TropoCall.new(native_call)
      event       = TropoEvent.new("transfer", tropo_call)
    rescue Exception => e
      case e.message
        when /Outbound call is timeout/i       then callback_registrar.trigger_event_for :timeout
        when /Outbound call can not complete/i then callback_registrar.trigger_event_for :callfailure
        when /Outbound call cancelled/i        then callback_registrar.trigger_event_for :choice
        else
          log '===========>' + e.inspect + '<=========== ' + e.backtrace * "\n"
          callback_registrar.trigger_event_for :error
      end
    end
  
  end
end

############
#Example starts here
############

call = Tropo::TropoCall.new($incomingCall)
call.answer

prompt  = 'Hi. For sales, just say sales or press 1. For support, say support or press 2.'
choices = 'sales( 1, sales), support( 2, support)'

call.ask prompt, :choices => choices, :repeat => 3, :timeout => 10 do |link|

  link.on :choice do |event|
    case event.value
    when 'sales'
      call.say 'Ok, let me transfer you to sales.'
      call.transfer '14129272358'
    when 'support'
      call.say 'Sure, let me get support.  Please hold.'
      call.transfer '14129272341'
    else
      call.say 'An error has occurred, one moment please.'
      call.transfer '14129272358'
    end
  end
  
  link.on :bad_choice do |event|
    call.say 'I am sorry, I did not understand what you said.'
  end
  
  link.on :timeout do |event|
    call.say 'I am sorry. I did not hear anything.'
  end

end

call.hangup