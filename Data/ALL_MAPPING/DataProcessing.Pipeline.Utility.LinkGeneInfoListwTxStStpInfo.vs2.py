#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
file2 = None
file3 = None
hash1 = {}
hash2 = {}

#File1 Ex: /home/michaelt/Data/UCSC/UCSC_hg19_GeneInformation_wSymbols.vs2.gz
#File2 Ex: /home/michaelt/Data/Hugo/HGNC_GeneInformation_wUCSCIDs.txt
#File3 Ex: /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/liquid_array.csv

#Argument handling and parsing
#Parsing arguments
parser = ArgumentParser(add_help=False)

#Required arguments
required = parser.add_argument_group('required arguments:')
required.add_argument("--file1", dest="file1", help="location of file1", required=True, metavar="FILE1")
required.add_argument("--file2", dest="file2", help="location of file2", required=True, metavar="FILE2")
required.add_argument("--file3", dest="file3", help="location of file3", required=True, metavar="FILE3")

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

	if line1[0] in hash1:
		sys.stderr.write("Error1a -- ")
	else:
		hash1[line1[0]] = [line1[1], line1[3], line1[4], line1[len(line1)-1]]

file1.close()

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

for line2 in file2:
	line2 = line2.rstrip().split()	
	
	hash2[line2[0]] = line2[len(line2)-1]

file2.close()

if args.file3 == "-":
	file3 = sys.stdin
elif re.search('gz$', args.file3):
	file3 = gzip.open(args.file3, 'rb')	
else:
	file3 = open(args.file3, 'r')

for line3 in file3:
	line3 = line3.rstrip().split(",")	
	
	hugoID = line3[2].replace("\"","")
	
	if hugoID in hash2:
		if hash2[hugoID] in hash1:
#			line3.append(map(str, hash1[hash2[hugoID]]))
#			",".join(map(str, line3.append(",".join(map(str, hash1[hash2[hugoID]])))))
#			print ",".join(map(str, line3.extend(hash1[hash2[hugeID]])))
			print ",".join(map(str, line3 + hash1[hash2[hugoID]]))
		else:
#			print ",".join(map(str, line3.extend(["NA2"] * len(hash1[hash2[hugoID]]))))
			print ",".join(map(str, line3 + ["NA2"] * 4))
#			sys.stderr.write("Error 
	else:
#		print ",".join(map(str, line3.extend(["NA1"] * len(hash1[hash2[hugoID]]))))
#		sys.stderr.write(",".join(line3) + "\n")
		print ",".join(map(str, line3 + ["NA1"] * 4))

file3.close()

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

