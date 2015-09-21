#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
file2 = None
hash1 = {}

#File1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs2.20140322_POP_genomics_sample.status_list_12-10-13.output
#File2 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/Analyses/SpecificGeneVCFs/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3Data.justWhite.QCed.DropIBD.wAnnovarForQC.AllGenesPerVar.VDAC3.Exonic.Nonsyn.vcf.gz

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

	hash1["_".join(map(str, line1[3].split("-")))] = str(line1[0])

file1.close()

IndvList1 = {}

if args.file2 == "-":
	file2a = sys.stdin
elif re.search('gz$', args.file2):
	file2a = gzip.open(args.file2, 'rb')	
else:
	file2a = open(args.file2, 'r')

for line2a in file2a:
	line2a = line2a.rstrip().split()	
	
	if re.search('^#CHROM', line2a[0]):
		PH1=1	
	elif re.search('^#', line2a[0]):
		PH2=1
	else:
		for i in range(10, len(line2a)):
			indvQuals = line2a[i].split(":")
			indvGenotypes = indvQuals[0].split("/")

			if indvGenotypes[0] == "1" or indvGenotypes[1] == "1":
				IndvList1[i] = 1

file2a.close()


if args.file2 == "-":
	file2b = sys.stdin
elif re.search('gz$', args.file2):
	file2b = gzip.open(args.file2, 'rb')	
else:
	file2b = open(args.file2, 'r')

for line2b in file2b:
	line2b = line2b.rstrip().split()	

	if re.search('^#CHROM', line2b[0]):
		PrintLine = line2b[0:10]
		PrintLine[9] = "FORMAT"
		PrintLine[8] = "ANNOVAR"
		for j in range(10, len(line2b)):
			if j in IndvList1:
				if str(line2b[j]) in hash1:
					PoolAndIndvID = str(line2b[j]) + "," + str(hash1[line2b[j]])
					PrintLine.extend([PoolAndIndvID])
				else:
					sys.stderr.write("Error1a -- POOL##_##RL not found in hash1 (" + str(line2b[j]) + ")\n")
					continue
		print "\t".join(PrintLine)
	elif re.search('^#', line2b[0]):
		PH3=1
	else:
		ChrBP2b = str(line2b[0]) + "_" + str(line2b[1])
		
#		PrintLine = []
#		PrintLine.extend([ChrBP2b])
		PrintLine = line2b[0:10]

		for k in range(10, len(line2b)):
			if k in IndvList1:
				PrintLine.extend([line2b[k]])

		print "\t".join(PrintLine)	

file2b.close()

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

