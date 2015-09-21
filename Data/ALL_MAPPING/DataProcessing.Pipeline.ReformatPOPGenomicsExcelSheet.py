#!/usr/bin/python

import sys
import re
from argparse import ArgumentParser

file1 = None
file2 = None
hash1 = {}

#File1 Ex: /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/OID41305_HG19_Match5_probes/OID41305_HG19_Match5_probe_coverage.bed

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
else:
	file1 = open(args.file1, 'r')
#"""
for line1 in file1:
	line1 = line1.rstrip().split()	

#	chr6    29523287        29524227
	try: 
		for val1 in tuple(range(int(line1[1]), int(line1[2]))):
			fullVal1 = re.findall('chr[0-9]*', line1[0])[0] + "-" + str(val1)
#			fullVal1 = line1[0] +  "-" + str(val1)
			hash1[fullVal1] = 1
#			print "yeah1"
#			print fullVal1
	except ValueError:
		sys.stderr.write("line:\t" + str(line1) + "\t does not contain integers where expected\n")

file1.close()
#"""
#print "yeah2"

if args.file2 == "-":
	file2 = sys.stdin
else:
	file2 = open(args.file2, 'r')

for line2 in file2:
	line2 = line2.rstrip().split()	

#	print line2

	check1=0
#	check2=0
	readLength1=0
	for cigarVal1 in re.findall('[0-9]*', line2[5]):
		if cigarVal1:
			readLength1 += int(cigarVal1)
	
	for val2 in tuple(range(int(line2[3]), int(line2[3])+readLength1)):
		if "chr" + line2[2] + "-" + str(val2) in hash1:
			check1=1


#	print "chr"+ line2[2] + "-" + str(line2[3])

#	if "chr"+ line2[2] + "-" + str(line2[3]) in hash1:
#		check1=1
#	if "chr" + line2[2] + "-" + str(int(line2[3])+readLength1) in hash1:
#		check2=1

#	print int(line2[3]), "\t", int(line2[3])+readLength1, "\t", readLength1, "\t", check1, "\t", check2
	print int(line2[3]), "\t", int(line2[3])+readLength1, "\t", readLength1, "\t", check1


#	if check1 == 1 or check2 == 1:
#	if check1 == 1:
#		print line2
#		pass
#	else:
#		print line2
	


file2.close()

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

