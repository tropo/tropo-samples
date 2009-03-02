require 'net/http'
require 'rexml/document'

#Extend the Array class with a to_h method
class Array
  def to_h
    Hash[*self]
  end
end

#Extend rexml/document to create a Ruby hash from xml
class REXML::Document

  def record(xpath)
    self.root.elements.each(xpath + '/*'){}.inject([]) do |r,node|
      r << node.name.to_s << node.text.to_s
    end.to_h
  end

  def records(xpath)
    self.root.elements.each(xpath){}.map do |row|
      row.elements.each{}.inject([]) do |r,node|
        r << node.name.to_s << node.text.to_s
      end.to_h
    end
  end

end

#Fetch the stations from the BART API
def fetch_bart_stations
  bart_url = 'http://bart.gov/dev/eta/bart_eta.xml'

  xml_data = Net::HTTP.get_response(URI.parse(bart_url)).body
  xml_doc = REXML::Document.new(xml_data)

  stations = xml_doc.records('station')
  stations.each_with_index do |station, index|
    etas = xml_doc.records("//station[#{index}]/eta")
    stations[index].merge!({ "eta" => etas })
  end
  
  return stations
end

#Fetch the stations from the BART API
def fetch_bart_stations
  bart_url = 'http://bart.gov/dev/eta/bart_eta.xml'

  xml_data = Net::HTTP.get_response(URI.parse(bart_url)).body
  xml_doc = REXML::Document.new(xml_data)

  stations = xml_doc.records('station')
  stations.each_with_index do |station, index|
    etas = xml_doc.records("//station[#{index + 1}]/eta")
    stations[index].merge!({ "eta" => etas })
  end
  
  return stations
end

#Build the choice menu from the returned BART API details
def build_choices(stations)
  choices = String.new
  stations.each do |station|
    choices = choices + "#{station['abbr']}('" + station['name'].gsub('St.','Street').gsub('/',"', '").gsub('24th', 'Twenty fourth').gsub('19th', 'Nineteenth').gsub('16th', 'Sixteenth').gsub('12th', 'Twelfth') + "'),"
  end  
  return choices
end

#Parse the times returned to drop the 'min' and return an Array
def parse_bart_times(estimates)
  times = Array.new
  estimates = estimates.split(',')
  estimates.each do |estimate|
    times << estimate.gsub(' min', '')
  end
  return times
end

stations = fetch_bart_stations

options = { :choices     => build_choices(stations),
            :repeat      => 3,
            :onBadChoice => lambda { say 'I am sorry, I did not understand what you said.' },
            :onTimeout   => lambda { say 'I did not hear anything.' },
            :onChoice    => lambda { |choice|
                                      estimated_arrivals = String.new
                                      stations.each do |station|
                                        if station["abbr"] == choice.value
                                          estimated_arrivals = "The train from #{station["name"]}"
                                          station["eta"].each do |eta|
                                            estimated_arrivals = estimated_arrivals + " will arrive at #{eta['destination']}"
                                            times = parse_bart_times(eta['estimate'])
                                            times.each_with_index do |time, index|
                                              if times.length - 1 == index && times.length > 0
                                                estimated_arrivals = estimated_arrivals + " and in #{time} minutes."
                                              else
                                                estimated_arrivals = estimated_arrivals + " in #{time} minutes,"
                                              end
                                            end
                                          end
                                        end
                                      end
                                      log '====>' + estimated_arrivals.gsub('St.', 'Street').gsub('/', ' ') + '<===='
                                      say estimated_arrivals.gsub('St.', 'Street').gsub('/', ' ')
                                    } 
           }

answer

say 'Welcome to the bay area rapid transit station estimated arrival service.'
  
ask 'Please speak the name of the station that you would like estimated arrivals for.', options

say 'Thank you, goodbye.'

hangup