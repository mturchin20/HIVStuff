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

#File1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.top25
#File2 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.vcf.gz 
#File3 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.FreqInfo.AnnovarAnnotation.vs5.txt.gz

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

	for i in range(1, len(line1)):
		ChrBP1 = line1[i].split('_')[0]
		hash1[ChrBP1] = 1

file1.close()

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

for line2 in file2:
	line2 = line2.rstrip().split()	

	if len(line2) > 2:
		ChrBP2 = str(line2[0]) + ":" + str(line2[1])
	
		if ChrBP2 in hash1:
			hash2[ChrBP2] = 1

file2.close()

if args.file3 == "-":
	file3 = sys.stdin
elif re.search('gz$', args.file3):
	file3 = gzip.open(args.file3, 'rb')	
else:
	file3 = open(args.file3, 'r')

for line3 in file3:
	line3 = line3.rstrip().split(',')	
	
	BP = line3[1].split('_')[0]
	ChrBP3 = str(line3[0]) + ":" + BP

	if ChrBP3 in hash2:
		print ",".join(line3)


file3.close()

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

