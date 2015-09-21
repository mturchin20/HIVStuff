#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None

#File1 Ex: DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output

#Argument handling and parsing
#Parsing arguments
parser = ArgumentParser(add_help=False)

#Required arguments
required = parser.add_argument_group('required arguments:')
required.add_argument("--file1", dest="file1", help="location of file1", required=True, metavar="FILE1")

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

#ID  ID  RMID#  POOLRMID#  Ancestry  posage  hesn    lesn    lesc    othersc vrapid  rapid   vslow   slow    timetoART
#20446,20446,6,POOL27-06RL,Black non-Hispanic,35.2,0,0,0,1,0,0,0,0,3.42

for line1 in file1:
	line1 = line1.rstrip().split(',')	

#	print line1

	FID="_".join(line1[3].split('-'))

	Pheno1=None
	Pheno2=None
	Pheno3=None
	Pheno4=None

	#Pheno1 -- Seronegative (1) vs Seropositive (2)
	if (float(line1[5]) > 0):
		Pheno1 = "2"
	elif ((line1[6] == "1") or (line1[7] == "1")): 
		Pheno1 = "1"
	else:
		sys.stderr.write("Error1a -- Unable to assign a value of 1 or 2 to Pheno1 (" + "\t".join(map(str, line1)) + ")\n")
		Pheno1 = "-8"
	
	#Pheno2 -- Highly-exposed Seronegative (1) vs Seropositive (2)
	if (float(line1[5]) > 0):
		Pheno2 = "2"
	elif (line1[6] == "1"): 
		Pheno2 = "1"
	elif (line1[7] == "1"):
		Pheno2 = "-9"
	else:
		sys.stderr.write("Error1b -- Unable to assign a value of 1 or 2 to Pheno2 (" + "\t".join(map(str, line1)) + ")\n")
		Pheno2 = "-8"
	
	#Pheno3 -- Rapid/VeryRapid Progressor (1) vs Slow/VerySlow Progressor (2)
	if ((line1[10] == "1") or (line1[11] == "1")): 
		Pheno3 = "1"
	elif ((line1[12] == "1") or (line1[13] == "1")):
		Pheno3 = "2"
	else:
		Pheno3 = "-9"
	
	#Pheno4 -- VeryRapid Progressor (1) vs. VerySlow Progressor (2)
	if (line1[10] == "1"): 
		Pheno4 = "1"
	elif (line1[12] == "1"):
		Pheno4 = "2"
	else:
		Pheno4 = "-9"

#	print FID + "\t" + FID + "\t" + str(Pheno1) + "\t" + str(Pheno2) + "\t" + str(Pheno3) + "\t" + str(Pheno4)
	print FID + "\t" + FID + "\t" + Pheno1 + "\t" + Pheno2 + "\t" + Pheno3 + "\t" + Pheno4


file1.close()

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

