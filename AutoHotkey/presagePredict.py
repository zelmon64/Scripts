
import sys, os
import getopt
sys.path.append('C:/Program Files (x86)/presage/lib/site-packages')
# sys.path.append(os.path.dirname(__file__))


config = None
suggestions = None

def print_usage():
	print """
Usage: %s [OPTION]...
  -c, --context CONTEXT  get prediction for string CONTEXT
"""

def parse_cmd_line_args():
	global context
	context = ""
	short_options = "c:"
	long_options  = ["context="]
	try:
		opts, args = getopt.getopt(sys.argv[1:], short_options, long_options)
	except getopt.GetoptError, err:
		print str(err)
		sys.exit(1)
	for opt, arg in opts:
		if opt in ('-c', '--context'):
			context = arg
	# print_usage()

def unicodetoascii(text):

    uni2ascii = {
            ord('\xe2\x80\x99'.decode('utf-8')): ord("'"),
            ord('\xe2\x80\x9c'.decode('utf-8')): ord('"'),
            ord('\xe2\x80\x9d'.decode('utf-8')): ord('"'),
            ord('\xe2\x80\x9e'.decode('utf-8')): ord('"'),
            ord('\xe2\x80\x9f'.decode('utf-8')): ord('"'),
            ord('\xc3\xa9'.decode('utf-8')): ord('e'),
            ord('\xe2\x80\x9c'.decode('utf-8')): ord('"'),
            ord('\xe2\x80\x93'.decode('utf-8')): ord('-'),
            ord('\xe2\x80\x92'.decode('utf-8')): ord('-'),
            ord('\xe2\x80\x94'.decode('utf-8')): ord('-'),
            ord('\xe2\x80\x94'.decode('utf-8')): ord('-'),
            ord('\xe2\x80\x98'.decode('utf-8')): ord("'"),
            ord('\xe2\x80\x9b'.decode('utf-8')): ord("'"),

            ord('\xe2\x80\x90'.decode('utf-8')): ord('-'),
            ord('\xe2\x80\x91'.decode('utf-8')): ord('-'),

            ord('\xe2\x80\xb2'.decode('utf-8')): ord("'"),
            ord('\xe2\x80\xb3'.decode('utf-8')): ord("'"),
            ord('\xe2\x80\xb4'.decode('utf-8')): ord("'"),
            ord('\xe2\x80\xb5'.decode('utf-8')): ord("'"),
            ord('\xe2\x80\xb6'.decode('utf-8')): ord("'"),
            ord('\xe2\x80\xb7'.decode('utf-8')): ord("'"),

            ord('\xe2\x81\xba'.decode('utf-8')): ord("+"),
            ord('\xe2\x81\xbb'.decode('utf-8')): ord("-"),
            ord('\xe2\x81\xbc'.decode('utf-8')): ord("="),
            ord('\xe2\x81\xbd'.decode('utf-8')): ord("("),
            ord('\xe2\x81\xbe'.decode('utf-8')): ord(")"),

                            }
    return text.decode('utf-8').translate(uni2ascii).encode('ascii')

def main():
        try:
	        import presage
        except ImportError, e:
                print '''
Error: failed to import module presage.

Check that presage python binding is properly installed (if
installed in a non-standard location, please set PYTHONPATH
accordingly).

Check that presage library is properly installed (if installed in a
non-standard location, please set LD_LIBRARY_PATH (PATH, LIBPATH)
accordingly).
'''
		print e
                sys.exit(1)
	try:
		# Define and create PresageCallback object
		class DemoCallback(presage.PresageCallback):
			def __init__(self):
				presage.PresageCallback.__init__(self)
				self.buffer = ''
			def get_past_stream(self):
				return self.buffer
			def get_future_stream(self):
				return ''
		# Presage owns callback, so we create it and disown it
		callback = DemoCallback().__disown__()
		# Create Presage object
		prsg = presage.Presage(callback)
		callback.buffer = context.replace("'","\xe2\x80\x99")
		listsuggestions = "("
		for i,suggestion in enumerate(prsg.predict()):
			listsuggestions += "'" + suggestion + "', "
		print unicodetoascii(listsuggestions[:-2]+")")
		#print prsg.predict()
		# Destroy Presage object
		del prsg
	except presage.PresageException,ex:
		print ex.what()
		sys.exit(1)


if __name__ == '__main__':
	parse_cmd_line_args()
	main()
