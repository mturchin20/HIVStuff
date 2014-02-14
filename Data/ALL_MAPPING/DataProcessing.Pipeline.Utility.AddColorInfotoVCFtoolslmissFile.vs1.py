#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
file2 = None
hash1 = {}

#File1 Ex: /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/OID41305_HG19_Match5_probes/OID41305_HG19_Match5_probe_coverage.formatted.bed
#File2 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss

#Argument handling and parsing
#Parsing arguments
parser = ArgumentParser(add_help=False)

#Required arguments
required = parser.add_argument_group('required arguments:')
required.add_argument("--file1", dest="file1", help="location of file1", required=True, metavar="FILE1")
required.add_argument("--file2", dest="file2", help="location of file2", required=True, metavar="FILE2")

#Optional arguments
optional = parser.add_argument_group('optional arguments:')
optional.add_argument("-w", "--window", dest="window", help="optional window-size to surround array reads", metavar="WINDOW")
optional.add_argument("-h", "--help", help="show this help message and exit", action="help")

args = parser.parse_args()

#print(args.file1)

#Main script

if not args.window:
	args.window = 0

sys.stderr.write(str(args.window) + "\n")

if args.file1 == "-":
	file1 = sys.stdin
elif re.search('gz$', args.file1):
	file1 = gzip.open(args.file1, 'rb')	
else:
	file1 = open(args.file1, 'r')

for line1 in file1:
	line1 = line1.rstrip().split()	

	try:
		if line1[0] in hash1:
			for val1 in tuple(range(int(line1[1])-int(args.window), int(line1[2])+int(args.window))):
				if val1 not in hash1[line1[0]]:
					hash1[line1[0]][val1] = 1
		else:
			tempHsh1 = {}
			for val1 in tuple(range(int(line1[1])-int(args.window), int(line1[2])+int(args.window))):
				tempHsh1[val1] = 1
			hash1[line1[0]] = tempHsh1
	except ValueError:
		sys.stderr.write("line:\t" + str(line1) + "\t does not contain integers where expected\n")

file1.close()

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

for line2 in file2:
	line2 = line2.rstrip().split()	
	
	if line2[0] in hash1:
		if int(line2[1]) in hash1[line2[0]]:
			line2.append("RED")
		else:
			line2.append("BLACK")
	else:
		sys.stderr.write("Error1a -- Chromosome " + line2[0] + " not found in hash1...\n")
		line2.append("PH1")

	print "\t".join(line2)

file2.close()

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

