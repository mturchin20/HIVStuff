#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
file2 = None
#args.findClosest=0
chrGeneBPpositions = {}
chrGeneStartEnd = {}

#File1 Ex: /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/liquid_array.wChrTrxStartStop.vs3.csv
#File2 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr12.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz 

#Argument handling and parsing
#Parsing arguments
parser = ArgumentParser(add_help=False)

#Required arguments
required = parser.add_argument_group('required arguments:')
required.add_argument("--file1", dest="file1", help="location of file1", required=True, metavar="FILE1")
required.add_argument("--file2", dest="file2", help="location of file2", required=True, metavar="FILE2")

#Optional arguments
optional = parser.add_argument_group('optional arguments:')
optional.add_argument("--findClosest", dest="findClosest", help="whether to search for closest gene when variant not already within a transcript; 1 is true, default is 0", metavar="CLOSEST")
optional.add_argument("-h", "--help", help="show this help message and exit", action="help")

args = parser.parse_args()
if not args.findClosest:
	args.findClosest = 0

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

	chrFull=re.search('chr(\w+)', line1[len(line1)-4])
	chr = None

	if chrFull:
		chr=chrFull.group(1)
		if chr in chrGeneBPpositions:
			for bp1 in range(int(line1[len(line1)-3]), int(line1[len(line1)-2]), 1):
				if bp1 in chrGeneBPpositions[chr]:
#					sys.stderr.write(chr + "," + str(bp1) + ":"  + "\t".join(map(str, chrGeneBPpositions[chr][bp1])) + "\n")
#					print chrGeneBPpositions[chr][bp1]
#					sys.stderr.write(str(type(chrGeneBPpositions[chr][bp1])))
					chrGeneBPpositions[chr][bp1].extend([line1[len(line1)-1]])
#					sys.stderr.write(chr + "," + str(bp1) + ":"  + "\t".join(map(str, chrGeneBPpositions[chr][bp1])) + "\n")
				else:
#					sys.stderr.write(line1[len(line1)-1])	
					chrGeneBPpositions[chr][bp1] = [line1[len(line1)-1]]
		else:
			subHash1 = {}
			for bp1 in range(int(line1[len(line1)-3]), int(line1[len(line1)-2]), 1):
				subHash1[bp1] = [line1[len(line1)-1]]
			chrGeneBPpositions[chr] = subHash1
			
		if args.findClosest == "1":	
			if chr in chrGeneStartEnd:
				if int(line1[len(line1)-3]) in chrGeneStartEnd[chr]:
					chrGeneStartEnd[chr][int(line1[len(line1)-3])].extend([line1[len(line1)-1]])
				else:
					chrGeneStartEnd[chr][int(line1[len(line1)-3])] = [line1[len(line1)-1]]
				
				if int(line1[len(line1)-2]) in chrGeneStartEnd[chr]:
					chrGeneStartEnd[chr][int(line1[len(line1)-2])].extend([line1[len(line1)-1]])
				else:
					chrGeneStartEnd[chr][int(line1[len(line1)-2])] = [line1[len(line1)-1]]

			else:
				subHash1 = {}
				subHash1[int(line1[len(line1)-3])] = [line1[len(line1)-1]]
				subHash1[int(line1[len(line1)-2])] = [line1[len(line1)-1]]
				chrGeneStartEnd[chr] = subHash1

	else:
		sys.stderr.write("Error1a -- " + str(line1[0]) + " did not produce a \"chr(\\w+)\" matchable string (line1: " + ",".join(map(str, line1[len(line1)-4:len(line1)-1])) + ")\n")

file1.close()

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

for line2 in file2:
	line2 = line2.rstrip().split()	

	if line2[0] in chrGeneBPpositions:
		if int(line2[1]) in chrGeneBPpositions[line2[0]]:
			print "\t".join(line2[0:11]) + "\t" + ",".join(chrGeneBPpositions[line2[0]][int(line2[1])])
		else:
			if args.findClosest == "0":
				print "\t".join(line2[0:11]) + "\tNA3"
			elif args.findClosest == "1":
				if line2[0] in chrGeneStartEnd:
					closestGeneDist = None
					closestGeneInfo = None
					for bpPos in chrGeneStartEnd[line2[0]]:
						if closestGeneDist:
							bpDifference = int(line2[1]) - bpPos
							if abs(bpDifference) < closestGeneDist:
								closestGeneDist = abs(bpDifference)
								closestGeneInfo = [closestGeneDist, bpDifference, chrGeneStartEnd[line2[0]][bpPos]]		
						else:
							bpDifference = int(line2[1]) - bpPos
							closestGeneDist = abs(bpDifference)
							closestGeneInfo = [closestGeneDist, bpDifference, chrGeneStartEnd[line2[0]][bpPos]]
					print "\t".join(line2[0:11]) + "\tNA3_" + ";".join(map(str, closestGeneInfo[2])) + "(" + str(closestGeneInfo[1]) + ")"
				else:
					print "\t".join(line2[0:11]) + "\tNA3_Error2b"
					sys.stderr.write("Error2b -- " + ",".join(map(str, line2[0:3])) + "does not have a chromosome found in chrGeneStartEnd (line1: " + str(line2[0]) + ")\n")
			else:
				sys.stderr.write("Error3a -- args.findClosest was neither 0 or 1 (args.findClosest: " + str(args.findClosest) + ")\n")
	else:
		sys.stderr.write("Error2a -- " + ",".join(map(str, line2[0:3])) + "does not have a chromosome found in chrGeneBPpositions (line1: " + str(line2[0]) + ")\n")

file2.close()

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

