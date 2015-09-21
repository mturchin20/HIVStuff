#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
file2 = None
IDarray = None
hash1 = {}

#File1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs2.20140322_POP_genomics_sample.status_list_12-10-13.output
#File2 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.vcf.gz
#IDs Ex: 10222,340122 (csv)

#Argument handling and parsing
#Parsing arguments
parser = ArgumentParser(add_help=False)

#Required arguments
required = parser.add_argument_group('required arguments:')
required.add_argument("--file1", dest="file1", help="location of file1", required=True, metavar="FILE1")
required.add_argument("--file2", dest="file2", help="location of file2", required=True, metavar="FILE2")
required.add_argument("--IDs", dest="IDlist", help="list of patient ID#s", required=True, metavar="IDS")

#Optional arguments
optional = parser.add_argument_group('optional arguments:')
optional.add_argument("-h", "--help", help="show this help message and exit", action="help")

args = parser.parse_args()

#print(args.file1)

#Main script

if args.IDlist != "All":
	IDarray = args.IDlist.split(",")

#sys.stderr.write(args.IDlist + "\n")
#sys.stderr.write(",".join(map(str, IDarray)) + "\n")

if args.file1 == "-":
	file1 = sys.stdin
elif re.search('gz$', args.file1):
	file1 = gzip.open(args.file1, 'rb')	
else:
	file1 = open(args.file1, 'r')

for line1 in file1:
	line1 = line1.rstrip().split(",")	

#	sys.stderr.write(line1[0] + "\n")

	if args.IDlist != "All":
		if line1[0] in IDarray:
			hash1["_".join(line1[3].split("-"))] = line1[0]	
#			sys.stderr.write("nana1\n")
	else:
		hash1["_".join(line1[3].split("-"))] = line1[0]

file1.close()

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

columnList = range(0,9) #Collecting column numbers that match indvID#s/poolID#s from above
postVCFHeader = 0 #Check for whether the script has gone past the header portion of the input .vcf file

for line2 in file2:
	line2 = line2.rstrip().split()	

	if postVCFHeader == 0:
		if re.search('^#CHROM', line2[0]):
			counter1 = 0
			for vcfEntry in line2:
				if vcfEntry in hash1:
					columnList.append(counter1)
					line2[counter1] = hash1[vcfEntry]
					sys.stderr.write("nana2\n")
				else:
					sys.stderr.write("Error1a -- vcfEntry " + str(vcfEntry) + " not found in hash1\n")
				counter1 += 1
			postVCFHeader = 1
			print("\t".join(line2[i] for i in columnList))
#			sys.stderr.write(",".join(map(str, columnList)) + "\n")
		else:
			print("\t".join(line2))
	else:

		print("\t".join(line2[i] for i in columnList))


file2.close()

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

