#!/bin/python

import re

val1="asddadgz"

print val1

print re.search('^gz', val1)

if re.search('^gz', val1):
	print "yaya"


val2 = "asd,asdasd,asdada,asdad"
val2 = val2.split(",")
print val2[0]
print val2[1]

val2 = "asdsa,asdasd,asdada,asdad"
val2 = val2.split(",")[0].split("d")
print val2

val3 = "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PreMerge/mapping_SOLID/POOL10S-07RL"
val3 = val3.split("/")
print val3

val4 = "hcah nana lava"

pattern1 = re.compile('.*(nana).*')
#results1 = pattern1.search(val4)
results1 = re.search('.*(nana).*', val4)
if results1:
#	print "nana"	
	print results1.group(1)
