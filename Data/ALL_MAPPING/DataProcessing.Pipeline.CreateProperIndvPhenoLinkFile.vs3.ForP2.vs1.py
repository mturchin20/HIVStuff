#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
file2 = None
hash1 = {}
hash2 = {}

#File1 Ex: /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/20130930_POP_genomics_sample_information_2.edited.noMeta.dropIndvs.csv
#File2 Ex: /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/Sample_status_list_9-16-13_CT.edited.noMeta.csv

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


	if line1[0]:
#		print line1
		poolEntry = None
		for val1 in line1:
			search1 = re.search('.*ool\s+([a-zA-Z0-9]+).*', val1)	
			if search1:
				poolEntry = search1.group(1)
				if len(poolEntry) == 1:
					poolEntry = "0" + str(poolEntry)
		poolMID = line1[1]
		if len(poolMID) == 1:
			poolMID = "0" + str(poolMID)
		poolID = "POOL_P2_" + str(poolEntry) + "_" + str(poolMID) + "RL"

#		print poolID

		line1Use = [line1[1], line1[2], poolID]

		if line1[0] in hash1:
			hash1[line1[0]].append(line1Use)
		else:
			hash1[line1[0]] = [line1Use]
	else:
		sys.stderr.write(",".join(line1) + "\n")
#		print line1
	

file1.close()

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

for line2 in file2:
	line2 = line2.rstrip().split(',')
#"""
#	if line2[0] in hash1:
#		hash1line = hash1[line2[0]]
#
#		line2Use = [line2[0], ",".join(hash1line), ",".join(line2[8:19])]
#
#		print ",".join(line2Use)
#	else:
#		print ",".join(line2)
#		val4="val5"
#"""
	hash2[line2[0]] = line2

file2.close()

for line1EntryMain in hash1:
#	print "nana1"
	for line1Entry in hash1[line1EntryMain]:
		if line1EntryMain in hash2:
			line2Use = [hash2[line1EntryMain][0], ",".join(line1Entry), ",".join(hash2[line1EntryMain][9:20])]
#			print ",".join(hash1[line1Entry])
#			print line2Use
			print ",".join(line2Use)
			val4="val5"
		else:
#			print ",".join(line1Entry)
			sys.stderr.write(",".join(line1Entry) + "\n")
			val4="val5"

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

