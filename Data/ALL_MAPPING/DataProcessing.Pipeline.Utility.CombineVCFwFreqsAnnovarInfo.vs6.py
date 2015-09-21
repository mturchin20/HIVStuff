#!/usr/bin/python

import sys
import re
import gzip
import itertools
import copy
from argparse import ArgumentParser

file1 = None
file2 = None
file3 = None
hash1 = {}
FlipAlleles = 0 #Flag for if I need to flip the reference allele to be the derived allele down the road and whether I have to change any of the annotation information for this reason

#File1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz
#File2 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.AllPhenos.frq.gz
#File3 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.AnnovarFormat.genome_summary.csv

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

	if not re.search('^#', line1[0]):
		ChrBP1 = "_".join([str(line1[0]), str(line1[1]), "1"])
		if ChrBP1 not in hash1:
			hash1[ChrBP1] = line1[0:8]
			hash1[ChrBP1][1] = "_".join([str(line1[1]), "1"])
		else:
			sys.stderr.out("Error1a -- ChrBP1 found more than once in hash1 (" + ChrBp1 + ")\n")

file1.close()

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

tempHash1 = {}

for line2 in file2:
	line2 = line2.rstrip().split()	
		
	ChrBP2 = "_".join([str(line2[0]), str(line2[1]), "1"])

	if ChrBP2 in hash1:

		tempHash1[ChrBP2] = hash1[ChrBP2]

		AncA = None
		AAFlag1 = 0
		VariantInfoFull = tempHash1[ChrBP2][7].split(';')
		for VariantInfo in VariantInfoFull:
			if re.search('AA=', VariantInfo):
				AncA=VariantInfo.split("=")[1]
		if AncA != None:
			tempHash1[ChrBP2].insert(5, AncA)
			if not re.search("A|G|C|T", AncA.upper()):
				sys.stderr.write("Error2b -- Ancestral Allele no A, G, T or C for position " + ChrBP2 + " (" + ",".join(map(str, tempHash1[ChrBP2])) + ")\n")
				AAFlag1 = 1
#				del tempHash1[ChrBP2]
			else:
#				tempHash1[ChrBP2].insert(5, AncA)
				DerA = None
				if tempHash1[ChrBP2][3] == AncA.upper():
					DerA = tempHash1[ChrBP2][4]
				elif tempHash1[ChrBP2][4] == AncA.upper():
					DerA = tempHash1[ChrBP2][3]
					FlipAlleles = 1
				else:
					sys.stderr.write("Error2c -- Neither reference or other allele are the ancestral allele for position " + ChrBP2 + " (" + ",".join(map(str, tempHash1[ChrBP2])) + ")\n")
					AAFlag1 = 1
#					del tempHash1[ChrBP2]
#					continue

		else:
			sys.stderr.write("Error2a -- No Ancestral Allele information for position " + ChrBP2 + " (" + ",".join(map(str, tempHash1[ChrBP2])) + ")\n")
			AAFlag1 = 1
			tempHash1[ChrBP2].insert(5, "-9")
#			del tempHash1[ChrBP2]
				
		line2Use = []
				
		for i in range(2,len(line2)):
			if AAFlag1 == 0:
				if re.search(DerA, line2[i]):
					line2Use.append(line2[i].split(":")[1])
			elif AAFlag1 == 1:
				if re.search(tempHash1[ChrBP2][3], line2[i]):
					line2Use.append("-9")
			else:
				sys.stderr.write("Error2c -- AAFlag1 is neither 0 or 1 for position " + ChrBP2 + " (" + str(AAFlag1) + "\t" + ",".join(map(str, tempHash1[ChrBP2])) + ")\n")

		tempHash1[ChrBP2].extend(line2Use)

file2.close()

hash1 = tempHash1
tempHash1 = {}

if args.file3 == "-":
	file3 = sys.stdin
elif re.search('gz$', args.file3):
	file3 = gzip.open(args.file3, 'rb')	
else:
	file3 = open(args.file3, 'r')

for line3 in file3:
	line3 = line3.rstrip().split(",")
	multiTranscript=0
	multiTranscriptsArray=[line3[1]]

	ChrBP3 = str(line3[len(line3)-6]) + "_" + str(line3[len(line3)-5]) + "_1"

	if ChrBP3 in hash1:

#		20140410 Note: Legacy portion -- unsure why I originally included these if statements
#		if re.search('\(NM_', line3[1]):
#			line3[1] = line3[1].split("(")[0]
#		if re.search(';', line3[1]):
#			line3[1] = line3[1].split(";")[0]

		tempHash1[ChrBP3] = hash1[ChrBP3]
		SynnonSynLocation=2
		tempOrigHashEntry = tempHash1[ChrBP3]

		if not re.search('^$|stoploss SNV|stopgain SNV|unknown|synonymous SNV|nonsynonymous SNV', line3[2]):
#			sys.stderr.write("Happening!\n")
			foundEndofGeneAnnot=0
			multiTranscript=1			
			multiTranscriptsArray.extend([line3[2]])
			i=3
			while foundEndofGeneAnnot != 1:
				if not re.search('^$|stoploss SNV|stopgain SNV|unknown|synonymous SNV|nonsynonymous SNV', line3[i]):
					sys.stderr.write("Happening2!\n")
					multiTranscriptsArray.extend([line3[i]])
					i += 1
				else:
#					sys.stderr.write("Happening3!\n")
					SynnonSynLocation = i
					foundEndofGeneAnnot = 1

#		if re.search('^\"splicing\"$', line3[0]) and re.search('\(NM_', line3[1]):
		if (re.search('^\"splicing\"$', line3[0]) and re.search('\(NM_', line3[1])) or (re.search('ncRNA_splicing', line3[0]) and re.search('\(NR_', line3[1])):
			line3[1] = multiTranscriptsArray[0].split("(")[0]
			multiTranscriptsArray[0] = "(" + multiTranscriptsArray[0].split("(")[1]
			line3[SynnonSynLocation+1] = ";".join(multiTranscriptsArray)
			multiTranscript = 0
#			sys.stderr.write("Happening4\n")
#			if re.search('exonic;splicing', line3[0]):
#				sys.stderr.write("Happening4b\n")
		elif re.search('UTR5;UTR3', line3[0]): 			#This may not be happening properly?
			for UTRentry in line3[1].split(";"):
				multiTranscriptsArray.extend([UTRentry])
#			sys.stderr.write("Happening5\n")
		elif re.search('exonic;splicing', line3[0]):
			sys.stderr.write("Happening6\n")
			line3[1] = line3[1].split(";")[0]
		else:
			PH="PH"

		if multiTranscript == 0:
			tempHash1[ChrBP3].extend(list(itertools.chain.from_iterable([[line3[0], line3[1], line3[SynnonSynLocation], line3[SynnonSynLocation+1]], line3[len(line3)-19:len(line3)+1]])))
		else:
			for j in range(0,len(multiTranscriptsArray)):
				ChrBP3new = str(line3[len(line3)-6]) + "_" + str(line3[len(line3)-5]) + "_" + str(j+1)
				tempHash1[ChrBP3new] = copy.copy(tempOrigHashEntry)
				tempHash1[ChrBP3new].extend(list(itertools.chain.from_iterable([[line3[0], multiTranscriptsArray[j], line3[SynnonSynLocation], line3[SynnonSynLocation+1]], line3[len(line3)-19:len(line3)+1]])))
				tempHash1[ChrBP3new][1]= str(line3[len(line3)-5]) + "_" + str(j+1)

file3.close()

hash1 = tempHash1
tempHash1 = {}

for entry1 in hash1:
	print ",".join(hash1[entry1])


def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

