# --------------------------------------------
# This demonstrates retrieving a remote URL (in this case a text file)
# Created by Dan York
# See http://www.tropo.com for more info
# --------------------------------------------

# NOTE: This retrieves a text file that is only one line with a string in
# it and was created to show retrieving a text file.  This could obviously
# be enhanced.

import urllib
number= urllib.urlopen("http://blog-files.voxeo.com/media/test.txt").read()

answer()
say("Welcome to Tropo. Your magic number is %s. Goodbye." % number)
hangup() 
