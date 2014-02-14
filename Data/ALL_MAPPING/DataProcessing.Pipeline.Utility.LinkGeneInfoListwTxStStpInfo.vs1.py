#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
file2 = None
hash1 = {}

#File1 Ex: /home/michaelt/Data/UCSC/UCSC_hg19_GeneInformation_wSymbols.txt
#File2 Ex: /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/liquid_array.csv

#Argument handling and parsing
#Parsing arguments
parser = ArgumentParser(add_help=False)

#Required arguments
required = parser.add_argument_group('required arguments:')
required.add_argument("--file1", dest="file1", help="location of file1", required=True, metavar="FILE1")
required.add_argument("--file2", dest="file2", help="location of file2", required=True, metavar="FILE2")

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

for line1 in file1:
	line1 = line1.rstrip().split()	

	if line1[len(line1)-1] in hash1:
		if (line1[3] < hash1[line1[len(line1)-1]][1]):
			hash1[line1[len(line1)-1]][1] = line1[3]
		if (line1[4] > hash1[line1[len(line1)-1]][2]):
			hash1[line1[len(line1)-1]][2] = line1[4]
	else:
		hash1[line1[len(line1)-1]] = [line1[1], line1[3], line1[4]]
file1.close()

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

for line2 in file2:
	line2 = line2.rstrip().split(",")	
	
	geneIDnoQuote=line2[0].replace("\"","")

	if geneIDnoQuote in hash1:
		line2.append(",".join(map(str, hash1[geneIDnoQuote])))
		print ",".join(map(str, line2))
	else:
		line2.append(["NA", "NA","NA"])
		print ",".join(map(str, line2))

file2.close()


def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

