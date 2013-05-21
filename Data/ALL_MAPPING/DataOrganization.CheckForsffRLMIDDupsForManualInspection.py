#!/bin/python

import sys

sffRLMIDs = {}

stdin1 = sys.stdin

for line1 in stdin1:
	line1 = line1.rstrip().split()	
#	line1 = line1.split().rstrip()	
	
#	print line1

	if line1[1] in sffRLMIDs:
		sffRLMIDs[line1[1]].append(line1[0])
	else:
		sffRLMIDs[line1[1]] = [line1[0]]

for RLMID in sffRLMIDs.keys():
	print RLMID, sffRLMIDs[RLMID], len(sffRLMIDs[RLMID])

