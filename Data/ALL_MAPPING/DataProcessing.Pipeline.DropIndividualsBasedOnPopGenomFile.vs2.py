#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
file2 = None
hash1 = {}

#File1 Ex: /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/20130930_POP_genomics_sample_information_2.edited.noMeta.dropIndvs.csv
#File2 Ex: DataOrganization.CreatebamMergeList.vs1.20130928_145300.output

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
	line1 = line1.rstrip().split(',')	

	if line1[1]:
		poolEntry = None
		for val1 in line1:
			search1 = re.search('.*ool\s+([a-zA-Z0-9]+).*', val1)	
			if search1:
				poolEntry = search1.group(1)
				if len(poolEntry) == 1:
					poolEntry = "0" + str(poolEntry)
		poolMID = line1[2]
		if len(poolMID) == 1:
			poolMID = "0" + str(poolMID)
		poolID = "POOL" + str(poolEntry) + "-" + str(poolMID) + "RL"

#		print poolID

		hash1[poolID] = line1

file1.close()

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

for line2 in file2:
	line2 = line2.rstrip().split(';')
	line2a = line2[0].split('|')[0].split('/')[9]

	search2 = re.search('(POOL[a-zA-Z0-9]+).*(\d{2,5}RL)', line2a)

	if search2:
		poolID2 = search2.group(1) + "-" + search2.group(2)

		if poolID2 in hash1:
			print ";".join(line2)
#			placeHolder="PH"
		else:
#			print "Error -- " + poolID2 + " -- " + str(line2)
			sys.stderr.write("Error -- " + poolID2 + " -- " + str(line2) + "\n")
			placeHolder="PH"

file2.close()

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

