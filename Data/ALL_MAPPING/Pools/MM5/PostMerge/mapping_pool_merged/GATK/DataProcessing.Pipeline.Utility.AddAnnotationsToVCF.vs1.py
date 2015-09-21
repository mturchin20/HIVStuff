#!/usr/bin/python

import sys
import re
import gzip
import copy
from argparse import ArgumentParser

file1 = None
file2 = None
hash1 = {}

#File1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.FreqInfo.AnnovarAnnotation.vs5.txt.gz
#File2 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/ForPeople/ForKevinO/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.20140925KevinIndvRequest.vcf
#AC Ex: 5

#Argument handling and parsing
#Parsing arguments
parser = ArgumentParser(add_help=False)

#Required arguments
required = parser.add_argument_group('required arguments:')
required.add_argument("--file1", dest="file1", help="location of file1", required=True, metavar="FILE1")
required.add_argument("--file2", dest="file2", help="location of file2", required=True, metavar="FILE2")

#Optional arguments
optional = parser.add_argument_group('optional arguments:')
optional.add_argument("--AC", dest="AC", help="allele count threshold",  metavar="AFCNT")
optional.add_argument("-h", "--help", help="show this help message and exit", action="help")

args = parser.parse_args()

#print(args.file1)

#Main script

#1,101361178_1,rs17123491,C,T,C,28999.60,VQSRTrancheSNP90.00to99.00,AA=C;AC=271;AF=0.151;AN=1800;BaseQRankSum=2.357;DB;DP=7830;Dels=0.00;FS=3.139;HRun=2;HaplotypeScore=0.8826;InbreedingCoeff=-0.0153;MLEAC=272;MLEAF=0.151;MQ=59.99;MQ0=0;MQRankSum=0.804;POSITIVE_TRAIN_SITE;QD=13.35;ReadPosRankSum=-0.959;VQSLOD=3.59;culprit=DP,0.153846,0.156522,0.154696,0.151659,0.155172,0.181818,0.108696,0.179487,236,108,56,128,18,32,5,14,upstream,EXTL2,,,rs17123491,,,,,,,,,,,,,1,101361178,101361178,C,T

if args.file1 == "-":
	file1 = sys.stdin
elif re.search('gz$', args.file1):
	file1 = gzip.open(args.file1, 'rb')	
else:
	file1 = open(args.file1, 'r')

for line1 in file1:
	line1 = line1.rstrip().split(",")	

	bp1 = line1[1].split("_")[0]
	ChrBP1 = str(line1[0]) + "_" + str(bp1) 

	if ChrBP1 in hash1:
		hash1[ChrBP1].append(line1)
	else:
		hash1[ChrBP1] = [line1]

file1.close()

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

for line2 in file2:
	line2 = line2.rstrip().split()	

	if re.search('^#', line2[0]):
		if re.search('^#CHROM', line2[0]):
			line2.insert(8, "ANNOT")
		print "\t".join(line2)
	else:
		ChrBP2 = str(line2[0]) + "_" + str(line2[1])
	
		if ChrBP2 in hash1:
			for SNPinfo in hash1[ChrBP2]:
				SNPinfoVCF = SNPinfo[7].split(";")

				if len(SNPinfo[27].split()) > 1:
					SNPinfo[27] = "_".join(SNPinfo[27].split())

				SNPinfoAdd = ";".join(SNPinfo[25:28])
		
				if args.AC:
#					sys.stderr.write(str(SNPinfo[17]) + "\n")
					if int(SNPinfo[17]) <= int(args.AC):	
						line2temp = copy.copy(line2)
						line2temp.insert(8, SNPinfoAdd)
						genoPresent = 0
#X       77126531        .       G       A       240.16  VQSRTrancheSNP99.00to99.90      AA=G;AC=2;AF=1.144e-03;AN=1748;BaseQRankSum=4.720;DP=3887;Dels=0.00;FS=2.779;HRun=0;HaplotypeScore=0.7646;InbreedingCoeff=-0.0315;MLEAC=1;MLEAF=5.721e-04;MQ=60.00;MQ0=0;MQRankSum=-0.687;QD=26.68;ReadPosRankSum=0.766;VQSLOD=0.856;culprit=DP GT:AD:DP:GQ:PL  intronic;MAGT1; 0/0:4,0:4:12:0,12,127   0/0:4,0:4:12:0,12,133   0/0:4,0:4:12:0,12,117   0/0:2,0:2:6:0,6,64      0/0:2,0:2:6:0,6,65      0/0:2,0:2:6:0,6,60      0/0:5,0:5:15:0,15,167   0/0:1,0:1:3:0,3,34      ./.     0/0:4,0:4:12:0,12,124   0/0:3,0:3:9:0,9,91      0/0:4,0:4:12:0,12,137
						for i in range(10,len(line2temp)):
#							sys.stderr.write(str(line2temp[i]) + "\n")
							if not re.search('\.', line2temp[i].split("/")[0]):
#								sys.stderr.write("nana3\n")
								indvInfo = line2temp[i].split(":")
								genoInfo = indvInfo[0].split("/")
#								sys.stderr.write("\t".join(map(str, genoInfo)) + "\n")
								if int(genoInfo[0]) == 1:
									genoPresent = 1
								if int(genoInfo[1]) == 1:
									genoPresent = 1
#								sys.stderr.write(str(genoPresent) + "\n")
						if genoPresent == 1:
							print "\t".join(line2temp)
				else:
					line2temp = copy.copy(line2)
					line2temp.insert(9, SNPinfoAdd)
					print "\t".join(line2temp)

file2.close()

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

