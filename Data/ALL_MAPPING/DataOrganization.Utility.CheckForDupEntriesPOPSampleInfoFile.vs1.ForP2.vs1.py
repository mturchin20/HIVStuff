#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
hash1 = {}

#File1 Ex: /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/20131202_POP_genomics_sample_information_Solid_and_MM5.noMeta.noStar.csv

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

for line1 in file1:
	line1 = line1.rstrip().split(',')	

	if line1[0] in hash1:
		hash1[line1[0]].extend([line1])
	else:
		hash1[line1[0]] = [line1] 

file1.close()

for entry1 in hash1:
#	print str(len(hash1[entry1]))
	if len(hash1[entry1]) > 1:
#		for dup1 in hash1[entry1]:
#			print ",".join(dup1)
		print ":".join(map(str, hash1[entry1]))

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

