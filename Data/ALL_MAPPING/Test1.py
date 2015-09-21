#!/usr/bin/python

import sys
import re

hash1 = {}

print tuple(range(1,10))

hash1[tuple(range(1,10))] = 1

print hash1
#print hash1[tuple([1,2,3,4,5,6,7,8,9,10])]
print hash1[tuple(range(1,10))]

for val1 in tuple(range(1,10)):
	hash1[val1] = 1
#	val1Full = "".join(["nana", " ", str(val1)])
	val1Full = "nana " + str(val1)
	hash1[val1Full] = 1

print hash1
print hash1[2]

string1 = "292M1I182M1D459M1I14M1I10M58S"
string1array = re.findall('[^A-Z]*', string1)
print re.findall('[^A-Z]*', string1)
print re.findall('[0-9]*', string1)
val2a = 0
for val2b in string1array:
#	if isinstance (val2b, (str)):
	if val2b:
		val2a += int(val2b)
print string1array
print val2a

print val2a+120

if 2+3 in hash1:
	print 2+3, hash1

