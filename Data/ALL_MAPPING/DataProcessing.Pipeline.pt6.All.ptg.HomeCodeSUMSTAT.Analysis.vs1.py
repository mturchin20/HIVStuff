#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
file2 = None
hash1 = {}

#File1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/TruePheno/Pheno1/Exonic.Nonsynonymous/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs1.TruePheno.Pheno1.Exonic.Nonsynonymous.output.noNAs.Routput.rnk
#File2 Ex: /home/michaelt/Data/GSEA/c2.all.v4.0.symbols.gmt

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

	hash1[line1[0]] = line1[1] 

file1.close()

#KEGG_GLYCOLYSIS_GLUCONEOGENESIS http://www.broadinstitute.org/gsea/msigdb/cards/KEGG_GLYCOLYSIS_GLUCONEOGENESIS ACSS2   GCK     PGK2    PGK1    PDHB    PDHA1   PDHA2  PGM2     TPI1    ACSS1   FBP1    ADH1B   HK2     ADH1C   HK1     HK3     ADH4    PGAM2   ADH5    PGAM1   ADH1A   ALDOC   ALDH7A1 LDHAL6B PKLR    LDHAL6A ENO1    PKM2   PFKP     BPGM    PCK2    PCK1    ALDH1B1 ALDH2   ALDH3A1 AKR1A1  FBP2    PFKM    PFKL    LDHC    GAPDH   ENO3    ENO2    PGAM4   ADH7    ADH6    LDHB    ALDH1A3 ALDH3B1ALDH3B2  ALDH9A1 ALDH3A2 GALM    ALDOA   DLD     DLAT    ALDOB   G6PC2   LDHA    G6PC    PGM1    GPI
#KEGG_CITRATE_CYCLE_TCA_CYCLE    http://www.broadinstitute.org/gsea/msigdb/cards/KEGG_CITRATE_CYCLE_TCA_CYCLE    IDH3B   DLST    PCK2    CS      PDHB    PCK1    PDHA1  LOC642502        PDHA2   LOC283398       FH      SDHD    OGDH    SDHB    IDH3A   SDHC    IDH2    IDH1    ACO1    ACLY    MDH2    DLD     MDH1    DLAT    OGDHL   PC     SDHA     SUCLG1  SUCLA2  SUCLG2  IDH3G   ACO2
#KEGG_PENTOSE_PHOSPHATE_PATHWAY  http://www.broadinstitute.org/gsea/msigdb/cards/KEGG_PENTOSE_PHOSPHATE_PATHWAY  RPE     RPIA    PGM2    PGLS    PRPS2   FBP2    PFKM   PFKL     TALDO1  TKT     FBP1    TKTL2   PGD     RBKS    ALDOA   ALDOC   ALDOB   H6PD    LOC729020       PRPS1L1 PRPS1   DERA    G6PD    PGM1    TKTL1   PFKP    GPI

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

for line2 in file2:
	line2 = line2.rstrip().split()	

	NumGenesIncluded = 0
	ActualGenesIncluded = []
	GenesNotIncluded = []
	SUMSTAT = 0

	for i in range(2,len(line2)):
		if line2[i] in hash1:
			SUMSTAT += float(hash1[line2[i]])
			NumGenesIncluded += 1
			ActualGenesIncluded.append(line2[i])
		else:
			GenesNotIncluded.append(line2[i])

#	print(str(line2[0]) + "\t" + str(len(line2)-2) + "\t" + str(NumGenesIncluded) + "\t" + ",".join(map(str, ActualGenesIncluded)) + "\t" + ",".join(map(str, GenesNotIncluded)) + "\t" + str(SUMSTAT))
	print(str(line2[0]) + "," + str(len(line2)-2) + "," + str(NumGenesIncluded) + "," + "|".join(map(str, ActualGenesIncluded)) + "," + "|".join(map(str, GenesNotIncluded)) + "," + str(SUMSTAT))

file2.close()

def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

