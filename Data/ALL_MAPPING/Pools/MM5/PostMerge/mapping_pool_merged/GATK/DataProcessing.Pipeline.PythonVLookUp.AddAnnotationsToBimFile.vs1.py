#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
hash1 = {}

#File1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.txt.gz
#File2 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim

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
	line1 = line1.rstrip().split(",")	

	if line1[0] == "X":
		line1[0] = "23"

	ChrBP1 = line1[0] + "_" + line1[1]

	hash1[ChrBP1] = line1

file1.close()

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

for line2 in file2:
	line2 = line2.rstrip().split()

	ChrBP2 = line2[0] + "_" + line2[3]

	if ChrBP2 in hash1:

#		sys.stderr.write("here!\n")

		SNVClass = hash1[ChrBP2][19].split()
		SNVClassUse = "_".join(SNVClass)

		line2[4] = hash1[ChrBP2][len(hash1[ChrBP2])-2]
		line2[5] = hash1[ChrBP2][len(hash1[ChrBP2])-1]

		line2.extend([hash1[ChrBP2][17], hash1[ChrBP2][18], SNVClassUse, hash1[ChrBP2][25], hash1[ChrBP2][27], hash1[ChrBP2][29], hash1[ChrBP2][31]])
		print ",".join(line2)
	
	else:
		sys.stderr.write("\t".join(line2[0:4]) + "\n")
#		val1=0

file2.close()

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

