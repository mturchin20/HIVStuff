#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
hash1 = {}

#File1 Ex:

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
	
IndvIDs1 = {}

for line1 in file1:
	line1 = line1.rstrip().split()	

	if re.search('^#CHROM', line1[0]):
		for i in range(10, len(line1)):
			IndvID = line1[i].split(",")[1]
			IndvIDs1[i] = str(IndvID)
	else:
		PrintLine1 = []
		ChrBP1 = str(line1[0]) + "_" + str(line1[1])
		PrintLine1.extend([ChrBP1])
		
		IndvLine1 = []
		for j in range(10, len(line1)):
			indvQuals = line1[j].split(":")
			indvGenotypes = indvQuals[0].split("/")

			if indvGenotypes[0] == "1" or indvGenotypes[1] == "1":
				IndvLine1.extend([IndvIDs1[j]])

		PrintLine1.extend([",".join(IndvLine1)])
		print "\t".join(PrintLine1)

file1.close()

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

