#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None

#File1 Ex: DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output

#Argument handling and parsing
#Parsing arguments
parser = ArgumentParser(add_help=False)

#Required arguments
required = parser.add_argument_group('required arguments:')
required.add_argument("--file1", dest="file1", help="location of file1", required=True, metavar="FILE1")

#Optional arguments
optional = parser.add_argument_group('optional arguments:')
optional.add_argument("-h", "--help", help="show this help message and exit", action="help")

args = parser.parse_args()

#print(args.file1)

#Main script

if args.file1 == "-":
	file1 = sys.stdin
elif re.search('gz$', args.file1):
	file1 = gzip.open(args.file1, 'rb')	
else:
	file1 = open(args.file1, 'r')

#20446,20446,6,POOL27-06RL,Black non-Hispanic,35.2,0,0,0,1,0,0,0,0,3.42

for line1 in file1:
	line1 = line1.rstrip().split(',')	
	
	FID="_".join(line1[3].split('-'))

	POOLnum="-9"
	POOLnumSearch = re.search('POOL([a-zA-Z0-9]+).*', line1[3])
	if POOLnumSearch:
		POOLnum=POOLnumSearch.group(1)
	MIDnum=line1[2]

#      2 American Indian or Alaskan Native
#            2 Asian or Pacific Islander
#	          1 Black Hispanic
#		       35 Black non-Hispanic
#		             1 Other
#			          37 White Hispanic
#				      674 White non-Hispanic

	race=None
	if line1[4] == "White non-Hispanic":
		race="1"
	elif line1[4] == "White Hispanic":
		race="2"
	elif line1[4] == "Black non-Hispanic":
		race="3"
	elif line1[4] == "Black Hispanic":
		race="4"
	elif line1[4] == "Asian or Pacific Islander":
		race="5"
	elif line1[4] == "American Indian or Alaskan Native":
		race="5"
	elif line1[4] == "Other":
		race="7"
	else:
		sys.stderr.write("FID/IID " + FID + ": column 5, race, does not match any expectations (" + line1[4] + ")\n")

	print FID + "\t" + FID + "\t" + POOLnum + "\t" + MIDnum + "\t" + race


file1.close()

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

