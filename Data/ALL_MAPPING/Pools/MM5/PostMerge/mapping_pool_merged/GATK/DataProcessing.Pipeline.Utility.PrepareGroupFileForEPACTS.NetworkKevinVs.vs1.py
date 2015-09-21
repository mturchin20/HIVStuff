#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
file2 = None
hash1 = {}
hash2 = {}

#File1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.SetIDFile.Exonic
#File2 Ex: /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/Complexes_from_Array_1.txt

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

#1,1:1151620,0,1151620,A,G,downstream,SDF4,,,,,
#1,rs77271083,0,1151679,A,G,downstream,SDF4,,,,,
#1,1:1151722,0,1151722,C,A,downstream,SDF4,,,,,
#1,rs78479912,0,1151917,A,G,downstream,SDF4,,,,,
#1,1:1151930,0,1151930,A,C,downstream,SDF4,,,,,

for line1 in file1:
	line1 = line1.rstrip().split(",")	

	if line1[0] == "23":
		line1[0] = "X"

	ChrBP1 = line1[0] + ":" + line1[3] + "_" + line1[4] + "/" + line1[5]

	if line1[7] in hash1:
		hash1[line1[7]].append(ChrBP1)
	else:
		hash1[line1[7]] = [line1[7], ChrBP1]


file1.close()

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

for line2 in file2:
	line2 = line2.rstrip().split()	
	
	if line2[2] in hash1:
		if "Group" + str(line2[0]) in hash2:
			hash2["Group" + str(line2[0])].extend(hash1[line2[2]][1:len(hash1[line2[2]])])
		else:
			hash2["Group" + str(line2[0])] = hash1[line2[2]][1:len(hash1[line2[2]])]
	else:
		sys.stderr.write("Error1a -- Gene " + str(line2[2]) + " not found in hash1\n")

file2.close()

for entry1 in hash2:
		print entry1 + "\t" + "\t".join(hash2[entry1])

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

