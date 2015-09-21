#!/usr/bin/python

import sys
import re
import gzip
import random
import operator
from argparse import ArgumentParser
from operator import itemgetter, attrgetter

file1 = None
file2 = None
hash1 = {}
hash2 = {}
totalDifferences = []

#File1 Ex: /home/michaelt/Data/UCSC/UCSC_hg19_GeneInformation_wSymbols.vs2.gz
#File2 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.Exonic.txt.gz 

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
	line1 = line1.rstrip().split()	
	
	if re.search('^\d+$', line1[7]): 
		line1[8] = line1[8].split(",")
		line1[9] = line1[9].split(",")
		for l in range(0, len(line1[8])-1):
			line1[8][l] = int(line1[8][l])
			line1[9][l] = int(line1[9][l])

	if line1[len(line1)-1] in hash1:
		hash1[line1[len(line1)-1]].append(line1)
	else:
		hash1[line1[len(line1)-1]] = [line1]

file1.close()

hash1Temp = {}

count1=0

for GeneEntries in hash1:

	hash1[GeneEntries].sort(key=operator.itemgetter(7), reverse=True)

	TopExonCount = hash1[GeneEntries][0][7]
	transcriptsWTopExonCount = []

	for Transcript in hash1[GeneEntries]:
		if Transcript[7] == TopExonCount:
			transcriptsWTopExonCount.append(Transcript)

	randVal1 = random.randint(0,len(transcriptsWTopExonCount)-1)
	hash1Temp[GeneEntries] = transcriptsWTopExonCount[randVal1]

#	if len(transcriptsWTopExonCount) > 2 and count1 < 2:
#		sys.stderr.write(str(randVal1) + "\t" + str(transcriptsWTopExonCount[randVal1]) + "\n")
#		count1 += 1

hash1 = hash1Temp
hash1Temp = {}

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

for line2 in file2:
	line2 = line2.rstrip().split(",")	

	if line2[27] == "nonsynonymous SNV" or line2[27] == "stopgain" or line2[27] == "stoploss":
#		if line2[35] == "D" or line2[35] == "P":
		if line2[35] == "D":
			line2[42] = int(line2[42])

			if line2[26] in hash2:
				hash2[line2[26]].append(line2)
			else:
				hash2[line2[26]] = [line2]

					
file2.close()

for GeneID1 in hash2:
	if len(hash2[GeneID1]) > 1:
		if GeneID1 in hash1:
			Differences = [GeneID1]
#			sys.stderr.write("Test1a:\t" + str(hash2[GeneID1][0][42]) + "\t" + str(hash2[GeneID1][1][42])  + "\n")
			hash2[GeneID1].sort(key=operator.itemgetter(42))
#			sys.stderr.write("Test1b:\t" + str(hash2[GeneID1][0][42]) + "\t" + str(hash2[GeneID1][1][42])  + "\n")
			for i in range(0, len(hash2[GeneID1])): #Gong down rows of variants for the current gene
				LessThanFlag1 = 0
				for j in range(1, len(hash1[GeneID1][8])): #Going across start/ends of exons to correct basepair position of variant if need be
					#Three situations per position -- the variant is less than the end of the previous exon, so you're done. The variant is in between the previous exon and current exon, so extend the end of the previous exon to include the variant (which will affect all downstream variants but should not affect upstream variants already analyzed). And the variant is greater than the start of the current exon, so subtract the difference between the beginning of the current exon and end of the last exon to remove the length of the intron. This process begins at loop index 1, not 0, because the first 'previous exon' to be analyzed should be the first one. And this process ends with the index on the last exon because if the variant is greater than the beginning of the last exon, you correct for the intron one last time and then there will be nothing else to do, so the LessThanFlag1 can still be 0 and you will just end the loop
					#hash1[GeneID1][8] is the list of exon beginnings and hash1[GeneID1][9] is the list of exon endings 
					#i is the current variant and j is the current exon
					if LessThanFlag1 == 0:
						#If you are less than the end of the previous exon
						if (hash2[GeneID1][i][42] < hash1[GeneID1][9][j-1]): 
							LessThanFlag1 = 1
#							sys.stderr.write("Happening1\t" + GeneID1 + "\t" + str(hash2[GeneID1][i][42]) + "\t" + str(hash1[GeneID1][9][j-1]) + "\n")
						#If you are greater than the previous exon's end and less than the current exon's beginning, e.g. intronic, extend the end of the previous exon to now include the current variant
						elif ((hash2[GeneID1][i][42] > hash1[GeneID1][9][j-1]) and (hash2[GeneID1][i][42] < hash1[GeneID1][8][j])):
#							sys.stderr.write(GeneID1 + "\tHappening2a\t" + str(hash1[GeneID1][9][j-1]) + "\t" + str(hash2[GeneID1][i][42]) + "\t" + str(hash1[GeneID1][8][j]) + "\n")
							hash1[GeneID1][9][j-1] = hash2[GeneID1][i][42]
#							sys.stderr.write(GeneID1 + "\tHappening2b\t" + str(hash1[GeneID1][9][j-1]) + "\t" + str(hash2[GeneID1][i][42]) + "\t" + str(hash1[GeneID1][8][j]) + "\n")
						#If you are greater than the current exon's beginning, subtract the difference in length between previous exon's end and current exon's beginning
						elif (hash2[GeneID1][i][42] > hash1[GeneID1][8][j]):
#							sys.stderr.write(GeneID1 + "\tHappening3a\t" + str(i) + "," + str(j) + "\t" + str(hash2[GeneID1][i][42]) + "\t" + str(hash1[GeneID1][8][j]) + "\t" + str(hash1[GeneID1][9][j-1]) + "\t" + str(hash1[GeneID1][8][j] - hash1[GeneID1][9][j-1]) + "\n")
							hash2[GeneID1][i][42] -= int(hash1[GeneID1][8][j]) - int(hash1[GeneID1][9][j-1])
#							sys.stderr.write(GeneID1 + "\tHappening3b\t" + str(i) + "," + str(j) + "\t" + str(hash2[GeneID1][i][42]) + "\t" + str(hash1[GeneID1][8][j]) + "\t" + str(hash1[GeneID1][9][j-1]) + "\t" + str(hash1[GeneID1][8][j] - hash1[GeneID1][9][j-1]) + "\n")
						else:
							Val1=0
				if (i > 0):
					Differences.append(str(hash2[GeneID1][i][42] - hash2[GeneID1][i-1][42]))
			totalDifferences.append(Differences)

for k in range(0, len(totalDifferences)):
	print totalDifferences[k][0] + "\t" + ",".join(totalDifferences[k][1:len(totalDifferences)])

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

