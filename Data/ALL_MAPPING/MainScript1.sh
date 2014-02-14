#!/bin/sh

#sffFile contains a list of every sequencing read/run and the breakdown/separation of each original .sff file into each MID tag
#ALL_MAPPING is where each individual is mapped back to the appropriate MID tag/.sff file combination from sffFile directory 

#Create appropriate main directories in ALL_MAPPING and then appropriate subdirectories in each main directory (main directory i.e. Pools/mapping_pool_1-46/, and subdirecory i.e. POOL14-01RL/). Then creating appropriate directories for each .sff file original location in sffFile/,  

20130823 - Going through past runs of code and figuring out what was done initially; collecting this information here as the first entry in this MainScript1/readme file for documentation (tends to be what I use instead of the LABDIRECTORY notebook thing I had previously tried to setup/use)

ls -lrt /home/pg/ALL_MAPPING/. | awk '{ print $9 } ' > home_pg_ALL_MAPPING_dirList.20130513.txt

bash CollectLSInfoPerDir.sh

bash DataOrganization.CollectOrigSFFFileInformation.sh

cat ../sffFiles/home_pg_ALL_MAPPING_ALL_Pools_sff_OrigLocations.Unedited.20130513.txt | sort | uniq > ../sffFiles/home_pg_ALL_MAPPING_ALL_Pools_sff_OrigLocations.Unedited.20130513.SortUniq.txt

#bash ../sffFiles/BreakUpsffFiles.sh
bash ../sffFiles/MakeDir.sh

bash DataOrganization.CombinePoolNameswsffFileIDs.sh

#Edit DataOrganization.CombinePoolNameswsffFileIDs.Thu_May_16_14:48:16_CDT_2013.output -- commenting out lines that are incorrect with '#'

bash DataOrganization.ConnectPoolsffFileswithIndvMIDRLsffFiles.sh DataOrganization.CombinePoolNameswsffFileIDs.Thu_May_16_14:48:16_CDT_2013.Edited.output

bash DataOrganization.CollectAllIndvMIDRLsffFiles.sh

bash ../sffFiles/Process_sffFile.BreakUpMIDs.Launcher.vs1.sh

bash DataProcessing.Pipeline.pt1.ConvrtsffFilestoFastq.Launcher.vs1.sh DataOrganization.CollectAllIndvMIDRLsffFiles.Thu_May_16_14:54:21_CDT_2013.RedundantDirectoriesRemoved.output

bash DataProcessing.Pipeline.pt2.ProcessQCedfastqFiles.Launcher.vs1.sh DataOrganization.CollectAllIndvMIDRLsffFiles.Thu_May_16_14:54:21_CDT_2013.RedundantDirectoriesRemoved.output 0


2nd run with pools mapping_pool_91-97 and mapping_pool_98-105, as well as edits + updating code
~~~~~~~~~~~

ls -lrt /home/pg/ALL_MAPPING/. | awk '{ print $9 } ' > home_pg_ALL_MAPPING_dirList.20130827.txt

cat home_pg_ALL_MAPPING_dirList.20130827.txt > home_pg_ALL_MAPPING_dirList.20130827.NotCreatedYet.txt
#Then manually edited to remove directories already used/processed before -- kept mapping_pool_91-97 and mapping_pool_98-105

bash DataOrganization.CollectLSInfoPerDir.vs2.sh home_pg_ALL_MAPPING_dirList.20130827.NotCreatedYet.txt #Creates subdirectory folder-list per directory

bash DataOrganization.MakeDir.vs2.sh home_pg_ALL_MAPPING_dirList.20130827.NotCreatedYet.txt #Creates the rest of the sub-subdirectories, etc. in ALL_MAPPING

bash DataOrganization.CollectOrigSFFFileInformation.vs2.sh home_pg_ALL_MAPPING_dirList.20130827.NotCreatedYet.txt #Creates home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.${date1}.txt file

cat ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130828_123042.txt | sort | uniq > ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130828_123042.SortUniq.txt

#Edit -- Directory location for sff file H37BKPH01 was changed from /data/454/raw/2013/R_2013_02_08_11_30_15_FLX08100638_Administrator_CS_KK_PG_MM5_Pool_91-2/D_2013_02_09_15_00_17_node1_altSignalProcessing/sff/H37BKPH01.sff to /data/454/raw/2013/R_2013_02_08_11_30_15_FLX08100638_Administrator_CS_KK_PG_MM5_Pool_91-2/D_2013_02_12_10_29_52_node2_signalProcessing/sff/H37BKPH01.sff (and *02.sff)
(bash DataOrganization.CorrectPool91Script.vs1.sh)
#Edit -- Change made in DataOrganization.CombinePoolNameswsffFileIDs.vs2.20130828_124947.Edited.output as well too 

#bash ../sffFiles/BreakUpsffFiles.vs2.sh ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130828_123042.SortUniq.txt
bash ../sffFiles/DataOrganization.MakeDir.vs2.sh ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130828_123042.SortUniq.Edited.txt

bash DataOrganization.CombinePoolNameswsffFileIDs.vs2.sh home_pg_ALL_MAPPING_dirList.20130827.NotCreatedYet.txt ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130828_123042.SortUniq.Edited.txt #Creates file such as DataOrganization.CombinePoolNameswsffFileIDs.vs2.${date1}.output

bash DataOrganization.ConnectPoolsffFileswithIndvMIDRLsffFiles.vs2.sh home_pg_ALL_MAPPING_dirList.20130827.NotCreatedYet.txt DataOrganization.CombinePoolNameswsffFileIDs.vs2.20130828_124947.Edited.output 

bash DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.sh home_pg_ALL_MAPPING_dirList.20130827.NotCreatedYet.txt #Creates DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.${date1}.output file 

bash ../sffFiles/DataProcessing.BreakUpMIDs.Launcher.vs2.sh ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130828_123042.SortUniq.Edited.txt

bash DataProcessing.Pipeline.pt1.ConvrtsffFilestoFastq.Launcher.vs2.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130828_141053.output

#cat DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130828_141053.output | grep -E 'H37BKPH|H4KITRJ|H4PUW3D' > DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130828_141053.Leftover.output

bash DataProcessing.Pipeline.pt2.ProcessQCedfastqFiles.Launcher.vs2.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130828_141053.output

#cp -p home_pg_ALL_MAPPING_dirList.20130827.txt home_pg_ALL_MAPPING_dirList.WorkingMainList.txt
#cat DataOrganization.CombinePoolNameswsffFileIDs.Thu_May_16_14\:48\:16_CDT_2013.Edited.output DataOrganization.CombinePoolNameswsffFileIDs.vs2.20130828_124947.output > DataOrganization.CombinePoolNameswsffFileIDs.vs2.WorkingMainFile.output #Combining all sections. Trying to use 'WorkingMainFile' as means to keep all parts together
#cat DataOrganization.CollectAllIndvMIDRLsffFiles.Thu_May_16_14\:54\:21_CDT_2013.RedundantDirectoriesRemoved.JustFirstTwoCols.output DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130828_141053.output > DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.output
#cp -p DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.output DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output 
#Made DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output  file by changing all earlier directories for mapping_pools.... to include the /Pools/... directory via the following command in vi .,$ s/ING\/mapping_pool/ING\/Pools\/mapping_pool/g 

#At this point catching any .fastq files or other downstream processed files that were lost or not properly processed in order for them to be resubmitted
bash DataProcessing.Pipeline.CheckForErroneousFiles.vs1.sh home_pg_ALL_MAPPING_dirList.WorkingMainList.txt DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output fastq #Create DataProcessing.Pipeline.CheckForErroneousFiles.vs1.DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.Redo.${SearchTerm1}.${date1}.output file

bash DataProcessing.Pipeline.pt1.ConvrtsffFilestoFastq.Launcher.vs2.sh DataProcessing.Pipeline.CheckForErroneousFiles.vs1.DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.Redo.fastq.20130830_165929.output

bash DataProcessing.Pipeline.pt2.ProcessQCedfastqFiles.Launcher.vs2.sh DataProcessing.Pipeline.CheckForErroneousFiles.vs1.DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.Redo.fastq.20130830_165929.output


3rd run with mapping_pool_106-124
~~~~~~~~~~~

ls -lrt /home/pg/ALL_MAPPING/. | awk '{ print $9 } ' > home_pg_ALL_MAPPING_dirList.20130831.txt

cat home_pg_ALL_MAPPING_dirList.20130831.txt > home_pg_ALL_MAPPING_dirList.20130831.NotCreatedYet.txt
#Then manually edited to remove directories already used/processed before -- kept mapping_pool_106-124

bash DataOrganization.CollectLSInfoPerDir.vs2.sh home_pg_ALL_MAPPING_dirList.20130831.NotCreatedYet.txt #Creates subdirectory folder-list per directory

bash DataOrganization.MakeDir.vs2.sh home_pg_ALL_MAPPING_dirList.20130831.NotCreatedYet.txt #Creates the rest of the sub-subdirectories, etc. in ALL_MAPPING

bash DataOrganization.CollectOrigSFFFileInformation.vs2.sh home_pg_ALL_MAPPING_dirList.20130831.NotCreatedYet.txt #Creates home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.${date1}.txt file

cat ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130831_103251.txt | sort | uniq > ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130831_103251.SortUniq.txt

bash ../sffFiles/DataOrganization.MakeDir.vs2.sh ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130831_103251.SortUniq.txt

bash DataOrganization.CombinePoolNameswsffFileIDs.vs2.sh home_pg_ALL_MAPPING_dirList.20130831.NotCreatedYet.txt ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130831_103251.SortUniq.txt #Creates file such as DataOrganization.CombinePoolNameswsffFileIDs.vs2.${date1}.output

bash DataOrganization.ConnectPoolsffFileswithIndvMIDRLsffFiles.vs2.sh home_pg_ALL_MAPPING_dirList.20130831.NotCreatedYet.txt DataOrganization.CombinePoolNameswsffFileIDs.vs2.20130831_103251.output 

bash DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.sh home_pg_ALL_MAPPING_dirList.20130831.NotCreatedYet.txt #Creates DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.${date1}.output file 

bash ../sffFiles/DataProcessing.BreakUpMIDs.Launcher.vs2.sh ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130831_103251.SortUniq.txt

bash DataProcessing.Pipeline.pt1.ConvrtsffFilestoFastq.Launcher.vs2.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130831_103352.output

bash DataProcessing.Pipeline.pt2.ProcessQCedfastqFiles.Launcher.vs2.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130831_103352.output

cat ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130831_103251.SortUniq.txt | grep H85C36T01 > ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130831_103251.SortUniq.Leftover.txt #Then ran ../sffFiles/DataProcessing.BreakUpMIDs.Launcher.vs2.sh

cat DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130831_103352.output | grep H85C36T01 > DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130831_103352.Leftover.output #Then ran DataProcessing.Pipeline.pt1.ConvrtsffFilestoFastq.Launcher.vs2.sh and DataProcessing.Pipeline.pt2.ProcessQCedfastqFiles.Launcher.vs2.sh

#Also H9H1D9W01

#cat DataOrganization.CombinePoolNameswsffFileIDs.Thu_May_16_14\:48\:16_CDT_2013.Edited.output DataOrganization.CombinePoolNameswsffFileIDs.vs2.20130828_124947.output DataOrganization.CombinePoolNameswsffFileIDs.vs2.20130831_103251.output > DataOrganization.CombinePoolNameswsffFileIDs.vs2.WorkingMainFile.output
#cat DataOrganization.CollectAllIndvMIDRLsffFiles.Thu_May_16_14\:54\:21_CDT_2013.RedundantDirectoriesRemoved.JustFirstTwoCols.output DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130828_141053.output DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130831_103352.output > DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.output
#cp -p DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.output DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output 

bash DataProcessing.Pipeline.CheckForErroneousFiles.vs2.sh home_pg_ALL_MAPPING_dirList.WorkingMainList.txt DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output fastq

bash DataProcessing.Pipeline.pt1.ConvrtsffFilestoFastq.Launcher.vs2.sh DataProcessing.Pipeline.CheckForErroneousFiles.vs1.DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.Redo.fastq.20130831_235915.output

bash DataProcessing.Pipeline.pt2.ProcessQCedfastqFiles.Launcher.vs2.sh DataProcessing.Pipeline.CheckForErroneousFiles.vs1.DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.Redo.fastq.20130831_235915.output

cat home_pg_ALL_MAPPING_ALL_Pools_sff_OrigLocations.Unedited.20130513.SortUniq.txt home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130828_123042.SortUniq.Edited.txt home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130831_103251.SortUniq.txt > home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.WorkingMainList.SortUniq.txt

bash ../sffFiles/DataProcessing.BreakUpMIDs.Launcher.vs2.sh ../sffFiles/DataProcessing.Pipeline.CheckForErroneousFiles.vs1.DataProcessing.BreakUpMIDs.vs1.WorkingMainFile.Edited.Redo.fastq.20130831_235915.output


20130903 -- Created the PreMerge and PostMerge Pools/separation in the folder hierarchy; began continued development of pt3/the merging/dupl/BQSR steps in the pipeline
~~~~~~~~~~~
PreMerge

bash DataProcessing.RemoveaCertainFile.vs1.sh home_pg_ALL_MAPPING_dirList.WorkingMainList.txt PreMerge #Cleaned up old .preGATK* and *sam.gz files so can more easily locate folders where the pt2 code did not run properly (e.g. a lack of these files existing versus trying to find files with the proper timestamp signature)

bash DataProcessing.Pipeline.pt2.ProcessQCedfastqFiles.Launcher.vs2.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output #Redoing everything

#Note -- at this point changed original .pt3 of the pipeline scripts to .pt4 and made the 'merge file' portion of the original .pt3 into a stand alone .pt3

bash DataOrganization.AddOrRemoveRGInformation.Launcher.vs1.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output #Run of DataProcessing.Pipeline.pt2.ProcessQCedfastqFiles.Launcher.vs2.sh included an error for the @RG information so used an extra script to correct every files. This is not intended to be normally used in the pipeline and the DataProcessing.Pipeline.pt2.ProcessQCedfastqFiles.vs2.sh script has been corrected

bash DataOrganization.CreatebamMergeList.vs1.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output #Creates file DataOrganization.CreatebamMergeList.vs1.${date1}.output

bash DataProcessing.Pipeline.pt3.MergeallSampleBamFiles.Launcher.vs1.sh DataOrganization.CreatebamMergeList.vs1.20130909_231450.output

bash DataProcessing.Pipeline.pt4.ProcessSampleLvlbamFiles.Launcher.vs1.sh DataOrganization.CreatebamMergeList.vs1.20130909_231450.output

#Possibly was going to drop reads that did not map to expected probes but delaying this decisions since some issues came out. Will come back to figure out if this is proper after putting the rest of the pipeline together
#samtools view POOL106_01RL.preGATK.samplesMerged.rmdup.BQSR.calmd.bam | python ../../../../DataProcessing.Pipeline.DropOffTargetReads.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/OID41305_HG19_Match5_probes/OID41305_HG19_Match5_probe_coverage.bed --file2 - | vi -
#R --vanilla --slave --args < ../../../../DataProcessing.Pipeline.DropOffTargetReads.plot.R /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/OID41305_HG19_Match5_probes/OID41305_HG19_Match5_probe_coverage.chr4.bed POOL106_01RL.preGATK.samplesMerged.rmdup.BQSR.calmd.chr4.formattted POOL106_01RL.preGATK.samplesMerged.rmdup.BQSR.calmd.chr4.OverlapPlot.jpeg
#R --vanilla --slave --args < ../../../../DataProcessing.Pipeline.DropOffTargetReads.plot.R /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/OID41305_HG19_Match5_probes/OID41305_HG19_Match5_probe_coverage.chr4.bed 454Contigs.chr4.formatted 454Contigs.chr4.OverlapPlot.jpeg
#
#20131029 edited
#R --vanilla --slave --args < ../../../../DataProcessing.Pipeline.DropOffTargetReads.plot.R /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.chr4.bed POOL106_01RL.preGATK.samplesMerged.rmdup.BQSR.calmd.chr4.formattted POOL106_01RL.preGATK.samplesMerged.rmdup.BQSR.calmd.chr4.OverlapPlot.120326_HG19_SW_MM5_EZ.jpeg

#Created pt5 to be run on a single interactive node, but running ReduceReads and creating a raw .vcf file for the entire, merged .bam file at once was too long. Created support scripts to break up merged .bam file into separate chromosome .bam files so that raw .vcfs could be made and ReduceReads could be run
#bash DataProcessing.Pipeline.pt5.MergebamFilesVariantCall.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged DataOrganization.CreatebamMergeList.vs1.20130916_105823.output

bash DataProcessing.Pipeline.pt5a.SplitBamIntoChromosomes.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.preGATK.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt5b.CreateVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.preGATK.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt5c.RunReduceReadsPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.preGATK.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged


20130923 - 4th run with mapping_pool_SOLID
~~~~~~~~~~~

#Manually created directories in ALL_MAPPING Pools subfolders following the excel spreadsheet POP_genomics_sample_information_2 and used 'touch' to create expected .sff files using ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130925_103251.SortUniq.txt created below to determine who got what .sff file

ls -lrt /data/454/raw/2011/*PG*/*/sff/. | grep sff | grep -E 'raw|H' | perl -sane 'if ($F[0] =~ m/raw/) { $tempVal1 = $F[0]; } else { if ($tempVal1 =~ m/(.*)(\.\:)/) { print $1, $F[8], "\n"; } }' > ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130925_103251.SortUniq.txt 

#Manually added in SOLID pools from 2012 directory

bash ../sffFiles/DataOrganization.MakeDir.vs2.sh ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130925_103251.SortUniq.txt

bash DataOrganization.CombinePoolNameswsffFileIDs.vs2.sh home_pg_ALL_MAPPING_dirList.20130831.NotCreatedYet.txt ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130925_103251.SortUniq.txt #Creates file such as DataOrganization.CombinePoolNameswsffFileIDs.vs2.${date1}.output

#Had to clean up file DataOrganization.CombinePoolNameswsffFileIDs.vs2.20130925_150954.output manually

bash DataOrganization.ConnectPoolsffFileswithIndvMIDRLsffFiles.vs2.sh home_pg_ALL_MAPPING_dirList.20130831.NotCreatedYet.txt DataOrganization.CombinePoolNameswsffFileIDs.vs2.20130925_150954.output

bash DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.sh home_pg_ALL_MAPPING_dirList.20130831.NotCreatedYet.txt #Creates DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.${date1}.output file

cp -p DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130925_152507.output DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130925_152507.Edited.output

#Manually removed some erroneous entries from DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130925_152507.Edited.output 

bash ../sffFiles/DataProcessing.BreakUpMIDs.Launcher.vs2.sh ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130925_103251.SortUniq.txt

bash DataProcessing.Pipeline.pt1.ConvrtsffFilestoFastq.Launcher.vs2.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130925_152507.Edited.output

#NOTE: At this point rerunning everything with QC pipeline components

DataProcessing.Pipeline.pt2.ProcessQCedfastqFiles.Launcher.vs2.sh

bash DataProcessing.Pipeline.pt1.ConvrtsffFilestoFastq.Launcher.vs2.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130925_152507.Edited.output

#DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output did not include mapping_SOLID runs yet at this point. Updated the file afterwards (since there were different needs for this pt1 script in particular for each group of folder/files that would not matter with later downstream pts).
bash DataProcessing.Pipeline.pt1.ConvrtsffFilestoFastq.Launcher.vs2.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output

cat DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130925_152507.Edited.output > asdadad

mv asdadad DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output 

bash DataProcessing.Pipeline.CheckForPresenceOfCertainFile.vs2.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output PreMerge QCed.preGATK.QCed.bam

bash DataProcessing.Pipeline.pt2.ProcessQCedfastqFiles.Launcher.vs2.sh DataProcessing.Pipeline.CheckForPresenceOfCertainFile.vs2.QCed.preGATK.QCed.bam.20130928_134627.output

bash DataOrganization.CreatebamMergeList.vs1.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output #Creates file DataOrganization.CreatebamMergeList.vs1.${date1}.output

#Manually merged POOL39_2-... with POOL39-... lines

bash DataProcessing.Pipeline.pt3.MergeallSampleBamFiles.Launcher.vs1.sh DataOrganization.CreatebamMergeList.vs1.20130928_145300.output

bash DataProcessing.Pipeline.pt4.ProcessSampleLvlbamFiles.Launcher.vs1.sh DataOrganization.CreatebamMergeList.vs1.20130928_145300.output

#Manually curated 20130930_POP_genomics_sample_information_2.edited.csv to look for duplicate entries and remove those that had less coverage
#Ran below code to cut down DataOrganization.CreatebamMergeList.vs1.20130928_145300.output to only include those individuals being used (and not those either missing IDs, exist as duplicates, etc.). For the moment deciding not to merge individuals who were run twice on MM5 (maybe bias with extra coverage on just a few individuals?) or run on SOLID and MM5. Also generally opted to use MM5 over SOLID unless coverage in SOLID was much better than MM5 (which was generally not the case). A few individuals were run twice on MM5, versus on SOLID and MM5
#cat /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/20130930_POP_genomics_sample_information_2.edited.noMeta.dropIndvs.csv | grep ool | sort | wc -- to help check expected total number of entries to be kept when using DataProcessing.Pipeline.DropIndividualsBasedOnPopGenomFile.vs2.py with 20130930_POP_genomics_sample_information_2.edited.noMeta.dropIndvs.csv

python DataProcessing.Pipeline.DropIndividualsBasedOnPopGenomFile.vs2.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/20130930_POP_genomics_sample_information_2.edited.noMeta.dropIndvs.csv --file2 DataOrganization.CreatebamMergeList.vs1.20130928_145300.output > DataOrganization.CreatebamMergeList.vs1.20130928_145300.dropIndvs.output

#bash DataProcessing.Pipeline.pt5.MergebamFilesVariantCall.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged DataOrganization.CreatebamMergeList.vs1.20130928_145300.dropIndvs.output

bash DataProcessing.Pipeline.pt6a.SplitBamIntoChromosomes.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt6b.CreateVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt6c.RunReduceReadsPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

python DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/20130930_POP_genomics_sample_information_2.edited.noMeta.dropIndvs.csv --file2 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/Sample_status_list_9-16-13_CT.edited.noMeta.csv > DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output
echo "macsid macsid MID# POOLID-MID# race posage hesn lesn lesc othersc vrapid rapid vslow slow timetoART timeaids" > DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output.header 
#20131004 Note -- four individuals not present in Sample_status_list file, 41478,10,POOL43-10RL
#20040,7,POOL18S-07RL
#30550,11,POOL101-11RL
#20770,3,POOL2S-03RL
#Unsure why at current point, will consult with Kevin/Sudhir after first run through of downstream analysis is done. Also, with these four individuals, total count is 756, not 757. Kevin suggested should have 757 individuals in total, so possibly missing someone? Unless POOL39 is being double counted by their count as well
#20131004 Note -- POOL57 MID10 has folder name ...-010RL for whatever reason originally, probably typo. Just fyi to be aware.

#20131004 Note -- at this point changed naming schematics to go from pt6a, pt6b, pt6c, etc... to go to pt6.All.pta, pt6.Samtools.pta, pt6.GATK.pta, etc... to delineate the different branching paths of the analysis steps for each analysis/variant-calling tool being used, with steps/code being used by all branches given the pt6.All.pt.... designation

python DataProcessing.Pipeline.CreatePhenotypeFile.vs1.py --file1 DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno

python DataProcessing.Pipeline.CreateCovariateFile.vs1.py --file1 DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar 

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar | awk '{ if ($5 == "1") { print $1, "\t", $2 } } ' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDIIDs

bash DataProcessing.Pipeline.pt6.All.ptb.ConvertVCFtoPEDPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools 

bash DataProcessing.Pipeline.pt6.All.ptc.CollapsePedFilesIntoSingleFile.vs2.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools

bash DataProcessing.Pipeline.pt6.All.ptd.PLINKlogisticRegression.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools

(20131012 -- time pt check)

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt --extract AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.bim.SNPsonly.snpIDs --r2 --ld-window-r2 0.8 --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r8 &

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt --extract AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.bim.SNPsonly.snpIDs --r2 --ld-window-r2 0 --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0 &

python ../../../../DataProcessing.Pipeline.pruneLDbased.py --file1 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld --r2 .1 > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld.r2clump10.txt &

python ../../../../DataProcessing.Pipeline.pruneLDbased.py --file1 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld --r2 .8 > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld.r2clump80.txt &

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld.r2clump10.txt | awk '{ print $1 }' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld.r2clump10.txt.snpList

perl /home/michaelt/Scripts/Perl/ListSubset.pl --file1 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld.r2clump10.txt.snpList --subset 250000 --output AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld.r2clump10.txt.snpList.250k

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt --extract AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld.r2clump10.txt.snpList.250k --make-bed --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k --recode --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.ped | perl -lane '$F[5] = "1"; print join("\t", @F);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.ped

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.ped | perl -lane 'print join("\t", @F[0..5]);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.pedind

ln -s AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.bim AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.pedsnp

/home/michaelt/Software/EIG5.0.1/bin/smartpca -p AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.parfile
#Note -- ran this on spudhead b/c smartpca was working already there but wasn't on olivia/miranda yet. Will ask Aleksandar to install eigenstrat if possible at some point

python ../../../../DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.py --file1 ../../../../DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output --file2 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.Results.pca > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.Results.pca.altrd.race
#scp'ing the necessary files back and forth from work computer and spudhead

/home/michaelt/Software/EIG5.0.1/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.Results.pca.altrd.race -c 1:2 -p American_Indian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic:White_non-Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.Results.pca.altrd.race.xtxt

#/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.Results.pca.altrd.race -c 1:2 -p American_Indian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic:White_non-Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.Results.pca.altrd.race.xtxt

20131013
~~~~~~~~~~~
#At this point noticed names were off in that POOL01S, POOL02S, etc... were not included, just POOL01, POOL02, etc...so had duplicates, i.e. SOLID array names not captured properly in the .bam files and all subsequent processes. Reran SOLID arrays and then merge/post-merge scripts

cat DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output | grep SOLID > DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output.SOLID

bash DataProcessing.Pipeline.pt2.ProcessQCedfastqFiles.Launcher.vs2.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output.SOLID

cat DataOrganization.CreatebamMergeList.vs1.20130928_145300.dropIndvs.output | grep SOLID > DataOrganization.CreatebamMergeList.vs1.20130928_145300.dropIndvs.output.SOLID

bash DataProcessing.Pipeline.pt3.MergeallSampleBamFiles.Launcher.vs1.sh DataOrganization.CreatebamMergeList.vs1.20130928_145300.dropIndvs.output.SOLID

bash DataProcessing.Pipeline.pt4.ProcessSampleLvlbamFiles.Launcher.vs1.sh DataOrganization.CreatebamMergeList.vs1.20130928_145300.dropIndvs.output.SOLID

#bash DataProcessing.Pipeline.pt5.MergebamFilesVariantCall.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged DataOrganization.CreatebamMergeList.vs1.20130928_145300.dropIndvs.output

bash DataProcessing.Pipeline.pt6.All.pta.SplitBamIntoChromosomes.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt6.Samtools.pta.CreateVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt6.GATK.pta.RunReduceReadsPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt6.All.ptb.ConvertVCFtoPEDPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/Samtools AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools

bash DataProcessing.Pipeline.pt6.All.ptc.CollapsePedFilesIntoSingleFile.vs2.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/Samtools AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/Samtools/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.bim | perl -lane 'if (($F[4] =~ m/^[AGTC]$/) && ($F[5] =~ m/^[AGTC]$/)) { print join("\t", @F);}' > Pools/PostMerge/mapping_pool_merged/Samtools/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.bim.SNPsonly

cat Pools/PostMerge/mapping_pool_merged/Samtools/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.bim.SNPsonly | awk '{ print $2 }' > Pools/PostMerge/mapping_pool_merged/Samtools/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.bim.SNPsonly.snpIDs

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt --extract AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.bim.SNPsonly.snpIDs --r2 --ld-window-r2 0.8 --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r8 &

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt --extract AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.bim.SNPsonly.snpIDs --r2 --ld-window-r2 0 --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0 &

python ../../../../DataProcessing.Pipeline.pruneLDbased.py --file1 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld --r2 .1 > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld.r2clump10.txt &

python ../../../../DataProcessing.Pipeline.pruneLDbased.py --file1 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld --r2 .8 > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld.r2clump80.txt &

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld.r2clump10.txt | awk '{ print $1 }' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld.r2clump10.txt.snpList

perl /home/michaelt/Scripts/Perl/ListSubset.pl --file1 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld.r2clump10.txt.snpList --subset 250000 --output AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld.r2clump10.txt.snpList.250k

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt --extract AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.SNPsonly.r0.ld.r2clump10.txt.snpList.250k --make-bed --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k --recode --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.ped | perl -lane '$F[5] = "1"; print join("\t", @F);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.ped

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.ped | perl -lane 'print join("\t", @F[0..5]);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.pedind

ln -s AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.bim AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.pedsnp

/home/michaelt/Software/EIG5.0.1/bin/smartpca -p AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.parfile
#Note -- ran this on spudhead b/c smartpca was working already there but wasn't on olivia/miranda yet. Will ask Aleksandar to install eigenstrat if possible at some point

python ../../../../DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.py --file1 ../../../../DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output --file2 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.Results.pca > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.Results.pca.altrd.race

python ../../../../DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.py --file1 ../../../../DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output --file2 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.noOutlierRmvl.Results.pca > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race

/home/michaelt/Software/EIG5.0.1/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.Results.pca.altrd.race -c 1:2 -p American_Indian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic:White_non-Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.250k.phenoColEdit.Results.pca.altrd.race.xtxt


bash DataProcessing.Pipeline.pt6.All.ptd.PLINKlogisticRegression.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools

bash DataProcessing.Pipeline.pt6.GATK.ptb.CreateVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged 

bash ../../../../DataProcessing.Pipeline.pt6.GATK.ptc.MergeVCFsAcrossChromosomes.vs1.sh

bash DataProcessing.Pipeline.pt6.GATK.ptd.RecalAndApplyVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

vcftools --gzvcf AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz --plink --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP

plink --file AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --make-bed --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP

bash DataProcessing.Pipeline.pt6.All.ptd.PLINKlogisticRegression.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --maf .01 --make-bed --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01

perl /home/michaelt/Scripts/Perl/ListSubset.pl --file1 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.bim --subset 250000 --output AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.bim

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.bim | awk '{ print $2 }' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.bim.onlySNPids

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01 --extract AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.bim.onlySNPids --make-bed --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k --recode --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.ped | perl -lane '$F[5] = "1"; print join("\t", @F);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.ped

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.ped | perl -lane 'print join("\t", @F[0..5]);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.pedind 

ln -s AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.bim AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.pedsnp

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --maf .01 --geno .95 --make-bed --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95 --recode --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.ped | perl -lane '$F[5] = "1"; print join("\t", @F);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.ped

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.ped | perl -lane 'print join("\t", @F[0..5]);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.pedind

ln -s AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.bim AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.pedsnp

/home/michaelt/Software/EIG5.0.1/bin/smartpca -p AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.parfile

python ../../../../DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.py --file1 ../../../../DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output --file2 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.Results.pca > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.Results.pca.altrd.race

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.Results.pca.altrd.race -c 1:2 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.Results.pca.altrd.race.plot.1vs2.xtxt

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.Results.pca.altrd.race -c 3:4 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.Results.pca.altrd.race.plot.3vs4.xtxt

python ../../../../DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.py --file1 ../../../../DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output --file2 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.Results.pca > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.Results.pca.altrd.race

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.Results.pca.altrd.race -c 1:2 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.Results.pca.altrd.race.plot.1vs2.xtxt

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.Results.pca.altrd.race -c 3:4 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.Results.pca.altrd.race.plot.3vs4.xtxt

python ../../../../../DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.py --file1 ../../../../../DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output --file2 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.noOutlierRmvl.Results.pca > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race

python ../../../../../DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.py --file1 ../../../../../DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output --file2 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.noOutlierRmvl.Results.pca > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race -c 1:2 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race.plot.1vs2.xtxt

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race -c 3:4 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race.plot.3vs4.xtxt

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race -c 1:2 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race.plot.1vs2.xtxt

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race -c 3:4 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race.plot.3vs4.xtxt


plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt --maf .01 --geno .95 --make-bed --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.bim | perl -lane 'if (($F[4] =~ m/^[AGTC]$/) && ($F[5] =~ m/^[AGTC]$/)) { print join("\t", @F);}' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.bim.SNPsonly

perl /home/michaelt/Scripts/Perl/ListSubset.pl --file1 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.bim.SNPsonly --subset 250000 --output AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.250k.bim.SNPsonly

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.250k.bim.SNPsonly | awk '{ print $2 }' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.250k.bim.SNPsonly.onlySNPids

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95 --extract AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.250k.bim.SNPsonly.onlySNPids --make-bed --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k --recode --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.ped | perl -lane '$F[5] = "1"; print join("\t", @F);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.ped

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.ped | perl -lane 'print join("\t", @F[0..5]);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.pedind

ln -s AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.bim AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.pedsnp

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/smartpca -p AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.250k.parfile

python ../../../../DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.py --file1 ../../../../DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output --file2 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.Results.pca > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.Results.pca.altrd.race

python ../../../../DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.py --file1 ../../../../DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output --file2 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.noOutlierRmvl.Results.pca > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.Results.pca.altrd.race -c 1:2 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.Results.pca.altrd.race.plot.1vs2.xtxt

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.Results.pca.altrd.race -c 3:4 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.Results.pca.altrd.race.plot.3vs4.xtxt

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race -c 1:2 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race.plot.1vs2.xtxt

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race -c 3:4 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools.ChrAll.C50.flt.maf01.geno95.SNPsonly.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race.plot.3vs4.xtxt


python DataProcessing.Pipeline.AddPCComponentsToCovarFile.py --file1 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/Eigenstrat/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.Results.pca --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.5PCs.covar
#Edit code in between runs
python DataProcessing.Pipeline.AddPCComponentsToCovarFile.py --file1 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/Eigenstrat/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.Results.pca --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.5PCs.covar | awk '{ print $1, "\t", $2 } ' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.5PCs.covar.FIDIIDs

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.5PCs.covar | awk '{ if ($5 == "1") { print $1, "\t", $2 } } ' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.5PCs.covar.WhiteOnly.FIDIIDs

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar | awk '{ print $1, "\t", $2 } ' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar | awk '{ if ($5 == "1") { print $1, "\t", $2 } } ' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.WhiteOnly.FIDIIDs

bash DataProcessing.Pipeline.pt6.All.ptd.PLINKlogisticRegression.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP
#Edit code in between runs
bash DataProcessing.Pipeline.pt6.All.ptd.PLINKlogisticRegression.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.5PCs.covar --covar-number 1,2,4,5,6,7,8 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.5PCs.covar.WhiteOnly.FIDIIDs --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.WhitesOnly.Pheno1.5PCsmaf01geno95.Assoc 

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.5PCs.covar --covar-number 1,2,4,5,6,7,8 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.5PCs.covar.WhiteOnly.FIDIIDs --maf .01 --geno .95 --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.WhitesOnly.Pheno1.5PCsmaf01geno95.Assoc 

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2,4,5,6,7,8,9,10,11,12,13 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.WhiteOnly.FIDIIDs --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.WhitesOnly.Pheno1.10PCsmaf01geno95.Assoc 

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2,4,5,6,7,8,9,10,11,12,13 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.WhiteOnly.FIDIIDs --maf .01 --geno .95 --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.WhitesOnly.Pheno1.10PCsmaf01geno95.Assoc 

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.Assoc

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2,4,5,6,7,8 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.5PCsmaf01geno05.Assoc

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2,4,5,6,7,8,9,10,11,12,13 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.10PCsmaf01geno05.Assoc

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.WhitesOnly.Pheno1.5PCsmaf01geno95.Assoc.assoc.logistic Pheno1_Logistic_Whites_5PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.WhitesOnly.Pheno1.5PCsmaf01geno95.Assoc.assoc.logistic.QQplot.jpeg & 

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.WhitesOnly.Pheno1.5PCsmaf01geno95.Assoc.assoc.logistic Pheno1_Logistic_Whites_maf01geno95_5PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.WhitesOnly.Pheno1.5PCsmaf01geno95.Assoc.assoc.logistic.QQplot.jpeg &

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.WhitesOnly.Pheno1.10PCsmaf01geno95.Assoc.assoc.logistic Pheno1_Logistic_Whites_10PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.WhitesOnly.Pheno1.10PCsmaf01geno95.Assoc.assoc.logistic.QQplot.jpeg &

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.WhitesOnly.Pheno1.10PCsmaf01geno95.Assoc.assoc.logistic Pheno1_Logistic_Whites_maf01geno95_10PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.WhitesOnly.Pheno1.10PCsmaf01geno95.Assoc.assoc.logistic.QQplot.jpeg &

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.Assoc.assoc.logistic Pheno1_Logistic AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.Assoc.assoc.logistic.QQplot.jpeg &

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.5PCsmaf01geno05.Assoc.assoc.logistic Pheno1_Logistic_5PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.5PCsmaf01geno05.Assoc.assoc.logistic.QQPlot.jpeg &

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.10PCsmaf01geno05.Assoc.assoc.logistic Pheno1_Logistic_10PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.10PCsmaf01geno05.Assoc.assoc.logistic.QQPlot.jpeg &

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2,4,5,6,7,8 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs --maf .01 --geno .95 --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.Pheno1.5PCsmaf01geno05.Assoc

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2,4,5,6,7,8,9,10,11,12,13 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs --maf .01 --geno .95 --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.Pheno1.10PCsmaf01geno05.Assoc

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.Pheno1.5PCsmaf01geno05.Assoc.assoc.logistic Pheno1_Logistic_maf01geno95_5PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.Pheno1.5PCsmaf01geno05.Assoc.assoc.logistic.QQplot.jpeg & 

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.Pheno1.10PCsmaf01geno05.Assoc.assoc.logistic Pheno1_Logistic_maf01geno95_10PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.Pheno1.10PCsmaf01geno05.Assoc.assoc.logistic.QQplot.jpeg & 

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.NoCovar.Assoc

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.justPOOLcovar.Assoc

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 2 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.justMIDcovar.Assoc

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 4,5,6,7,8 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.noPOOLMIDcovar.5PCsmaf01geno05.Assoc

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.NoCovar.Assoc.assoc.logistic Pheno1_Logistic_noCovar AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.NoCovar.Assoc.assoc.logistic.QQplot.jpeg &

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.justPOOLcovar.Assoc.assoc.logistic Pheno1_Logistic_POOLCovar AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.justPOOLcovar.Assoc.assoc.logistic.QQplot.jpeg &

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.justMIDcovar.Assoc.assoc.logistic Pheno1_Logistic_MIDCovar AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.justMIDcovar.Assoc.assoc.logistic.QQplot.jpeg &

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.noPOOLMIDcovar.5PCsmaf01geno05.Assoc.assoc.logistic Pheno1_Logistic_noPOOLMID_5PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.noPOOLMIDcovar.5PCsmaf01geno05.Assoc.assoc.logistic.QQplot.jpeg &

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 2 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2,4,5,6,7,8 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno2.5PCsmaf01geno05.Assoc

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno2.5PCsmaf01geno05.Assoc.assoc.logistic Pheno2_Logistic_5PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno2.5PCsmaf01geno05.Assoc.assoc.logistic.QQplot.jpeg &  

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 2 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno2.Assoc

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 2 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2,4,5,6,7,8 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.WhiteOnly.FIDIIDs --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.WhitesOnly.Pheno2.5PCsmaf01geno05.Assoc

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 2 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2,4,5,6,7,8 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs --maf .01 --geno .95 --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.Pheno2.5PCsmaf01geno05.Assoc

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno2.Assoc.assoc.logistic Pheno2_Logistic AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno2.Assoc.assoc.logistic.QQplot.jpeg &

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.WhitesOnly.Pheno2.5PCsmaf01geno05.Assoc.assoc.logistic Pheno2_Logistic_WhitesOnly_5PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.WhitesOnly.Pheno2.5PCsmaf01geno05.Assoc.assoc.logistic.QQplot.jpeg &

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.Pheno2.5PCsmaf01geno05.Assoc.assoc.logistic Pheno2_Logistic_maf01geno95_5PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.Pheno2.5PCsmaf01geno05.Assoc.assoc.logistic.QQplot.jpeg &

zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz | grep PASS | gzip > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.body.gz

zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.gz | wc
1272767 968575687 5440128566

zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz | awk '{ if ($1 == "12" ) { print $0 } } ' | gzip > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr12.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz

perl /home/michaelt/Scripts/Perl/ListSubset.pl --file1 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr12.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz --subset 10000 --output AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr12.GATK.ReduceReads.UG.VQSR.SNP.vcf.ran10000

zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz | head -n 123 | gzip > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.header.gz

zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.header.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.body.gz | gzip > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.gz

rm AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.body.gz 

vcftools --gzvcf AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.gz --plink --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS

plink --file AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS --make-bed --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS

perl /home/michaelt/Scripts/Perl/ListSubset.pl --file1 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.bim --subset 250000 --output AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.bim.250k

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.bim.250k | awk '{ print $2 }' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.bim.250k.snpIDs

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS --extract AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.bim.250k.snpIDs --make-bed --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k --recode --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.ped | perl -lane '$F[5] = "1"; print join("\t", @F);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.ped

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.ped | perl -lane 'print join("\t", @F[0..5]);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.pedind

ln -s AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.bim AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.pedsnp

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/smartpca -p AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.parfile

python ../../../../DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.py --file1 ../../../../DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output --file2 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.Results.pca > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.Results.pca.altrd.race

python ../../../../DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.py --file1 ../../../../DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20130930_POP_genomics_sample.status_list_9-16-13.output --file2 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.noOutlierRmvl.Results.pca > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.Results.pca.altrd.race -c 1:2 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.Results.pca.altrd.race.plot.1vs2.xtxt

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.Results.pca.altrd.race -c 3:4 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.Results.pca.altrd.race.plot.3vs4.xtxt

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race -c 1:2 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race.plot.1vs2.xtxt

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race -c 3:4 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Black_Hispanic:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.phenoColEdit.noOutlierRmvl.Results.pca.altrd.race.plot.3vs4.xtxt

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 3 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2,4,5,6,7,8 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno3.5PCsmaf01geno05.Assoc

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno3.5PCsmaf01geno05.Assoc.assoc.logistic Pheno3_Logistic_5PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno3.5PCsmaf01geno05.Assoc.assoc.logistic.QQplot.jpeg &  

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 3 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno3.Assoc

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 3 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2,4,5,6,7,8 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.WhiteOnly.FIDIIDs --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.WhitesOnly.Pheno3.5PCsmaf01geno05.Assoc

plink --bfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 3 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar --covar-number 1,2,4,5,6,7,8 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.10PCs.covar.FIDIIDs --maf .01 --geno .95 --logistic --allow-no-sex --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.Pheno3.5PCsmaf01geno05.Assoc

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno3.Assoc.assoc.logistic Pheno3_Logistic AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno3.Assoc.assoc.logistic.QQplot.jpeg &

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.WhitesOnly.Pheno3.5PCsmaf01geno05.Assoc.assoc.logistic Pheno3_Logistic_WhitesOnly_5PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.WhitesOnly.Pheno3.5PCsmaf01geno05.Assoc.assoc.logistic.QQplot.jpeg &

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.Pheno3.5PCsmaf01geno05.Assoc.assoc.logistic Pheno3_Logistic_maf01geno95_5PCsmaf01geno95 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.Pheno3.5PCsmaf01geno05.Assoc.assoc.logistic.QQplot.jpeg &


PASS run

python DataProcessing.Pipeline.AddPCComponentsToCovarFile.py --file1 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/Eigenstrat/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.Results.pca --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.PASS.maf01.geno95.phenoColEdit.5PCs.covar
#Edit code in between runs
python DataProcessing.Pipeline.AddPCComponentsToCovarFile.py --file1 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/Eigenstrat/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.maf01.geno95.phenoColEdit.Results.pca --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.GATK.ReduceReads.UG.VQSR.SNP.PASS.maf01.geno95.phenoColEdit.10PCs.covar


Annovar (timepoint chk: 20131029)
perl /home/michaelt/Software/annovar/annotate_variation.pl --geneanno  /home/michaelt/Software/annovar/ -buildver hg19 #annotation: 1        861283          861283          G       C
perl /mnt/lustre/home/mturchin20/Software/annovar/annotate_variation.pl --geneanno hg19_Variants4ESP6515.AnnovarFormat.txt /mnt/lustre/home/mturchin20/Software/annovar/humandb/ -buildver hg19
perl /mnt/lustre/home/mturchin20/Software/annovar/summarize_annovar.pl hg19_Variants4ESP6515.AnnovarFormat.txt /mnt/lustre/home/mturchin20/Software/annovar/humandb/ -buildver hg19

python DataPrcoessing.Pipeline.Utility.LinkGeneInfoListwTxStStpInfo.vs1.py --file1 /home/michaelt/Data/UCSC/UCSC_hg19_GeneInformation_wSymbols.vs2.gz --file2 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/liquid_array.csv > /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/liquid_array.wChrTrxStartStop.vs2.csv
#This script used the geneID symbol to compare the two datasets. Decided this was not adequate and used the UCSC ID and HugoID in the second version of the code below

python DataPrcoessing.Pipeline.Utility.LinkGeneInfoListwTxStStpInfo.vs2.py --file1 /home/michaelt/Data/UCSC/UCSC_hg19_GeneInformation_wSymbols.vs2.gz --file2 /home/michaelt/Data/Hugo/HGNC_GeneInformation_wUCSCIDs.txt --file3 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/liquid_array.csv > /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/liquid_array.wChrTrxStartStop.vs3.csv

python DataProcessing.Pipeline.pt6.All.pte.annotateVariantsManuallyGeneID.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/liquid_array.wChrTrxStartStop.vs3.csv --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr12.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz | gzip > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr12.GATK.ReduceReads.UG.VQSR.SNP.vcf.selfAnnotation.gz

python DataProcessing.Pipeline.pt6.All.pte.annotateVariantsManuallyGeneID.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/liquid_array.wChrTrxStartStop.vs3.csv --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz | gzip > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.selfAnnotation.gz

python DataProcessing.Pipeline.pt6.All.pte.annotateVariantsManuallyGeneID.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/liquid_array.wChrTrxStartStop.vs3.csv --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr12.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz --findClosest 1 | gzip > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Chr12.GATK.ReduceReads.UG.VQSR.SNP.vcf.selfAnnotation.gz

python DataProcessing.Pipeline.pt6.All.pte.annotateVariantsManuallyGeneID.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/liquid_array.wChrTrxStartStop.vs3.csv --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz --findClosest 1 | gzip > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.selfAnnotation.gz

zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz | awk '{ print $1, "\t", $2, "\t", $2, "\t", $4, "\t", $5 }' | grep -v ^# > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.AnnovarFormat

#perl /home/michaelt/Software/annovar/annotate_variation.pl --downdb refGene /home/michaelt/Software/annovar -build hg19
#PWD: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK

perl /home/michaelt/Software/annovar/annotate_variation.pl --geneanno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.AnnovarFormat /home/michaelt/Software/annovar/ -buildver hg19 

perl /home/michaelt/Software/annovar/summarize_annovar.pl /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.AnnovarFormat /home/michaelt/Software/annovar/ --ver1000g 1000g2012apr --verdbsnp 129 --veresp 6500 --buildver hg19 --remove

#perl /home/michaelt/Software/annovar/annotate_variation.pl -filter -dbtype ljb2_all -buildver hg19 -outfile /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.AnnovarFormat.ljb2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.AnnovarFormat /home/michaelt/Software/annovar/ -otherinfo




20131111 - 5th run fine-tuning QC setup from beginning of fastq file processing, so redoing everything from the start; still all SOLID and MM5 individuals
~~~~~~~~~~~

mv DataPrcoessing.Pipeline.Utility.LinkGeneInfoListwTxStStpInfo.vs2.py DataProcessing.Pipeline.Utility.LinkGeneInfoListwTxStStpInfo.vs2.py
mv DataPrcoessing.Pipeline.Utility.LinkGeneInfoListwTxStStpInfo.vs1.py DataProcessing.Pipeline.Utility.LinkGeneInfoListwTxStStpInfo.vs1.py

bash DataPrcoessing.Pipeline.Utility.GetFastqPreQCStats.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output

bash DataProcessing.Pipeline.Utility.RemoveaCertainFile.vs2.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output #To remove QCed.fastq.gz and associated stats files for new run through

bash DataProcessing.Pipeline.pt1.ConvrtsffFilestoFastq.Launcher.vs2.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output

mv DataPrcoessing.Pipeline.Utility.GetFastqPreQCStats.sh DataPrcoessing.Pipeline.Utility.GetFastqPreQCStats.vs1.sh

cp -p DataPrcoessing.Pipeline.Utility.GetFastqPreQCStats.vs1.sh DataPrcoessing.Pipeline.Utility.GetFastqQCStats.vs1.sh

bash DataPrcoessing.Pipeline.Utility.GetFastqQCStats.vs1.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output

#Notes: original sff location of /home/pg/michaelt/Data/ALL_MAPPING/Pools/PreMerge/mapping_pool_1-46/POOL20-12RL/. has 4 MIDs with good quality -- maybe the MID shouldn't be 12? Nah, there are 7 MIDs for POOL20 so it's unlikely to just be a MID12 thin
#Redo sff of /home/pg/michaelt/Data/ALL_MAPPING/Pools/PreMerge/mapping_pool_69-77/POOL75-09RL/ HX05RSL01.RL9.sff and HX05RSL02.RL9.sff

bash DataProcessing.Pipeline.pt2.ProcessQCedfastqFiles.Launcher.vs2.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output

cp -p DataProcessing.Pipeline.CheckForPresenceOfCertainFile.vs2.sh DataProcessing.Pipeline.CheckForPresenceOfCertainFile.vs3.sh
 
mv DataProcessing.Pipeline.CheckForPresenceOfCertainFile.vs3.sh DataProcessing.Pipeline.Utility.CheckForPresenceOfCertainFile.vs3.sh

bash DataProcessing.Pipeline.Utility.CheckForPresenceOfCertainFile.vs3.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output #searching for $baseFile1.QCed.preGATK.QCed.bam

mv DataOrganization.Utility.CreatebamMergeList.vs1.sh DataOrganization.Utility.CreatebamMergeList.vs1.sh

cp -p DataOrganization.Utility.CreatebamMergeList.vs1.sh DataOrganization.Utility.CreatebamMergeList.vs2.sh

bash DataOrganization.Utility.CreatebamMergeList.vs2.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output #Double-checking that this file was made appropriately and that all lines of the original file were used to create the eventual output. Just crossing t's and dotting i's here
#Note do the dropped individual thing to the output file from this run when I get back -- can delete this line later when I've done what I've asked in it, e.g. edit the output file to drop the individuals like was done earlier in this list/history of code

bash DataProcessing.Pipeline.Utility.RemoveaCertainFile.vs2.sh DataOrganization.CreatebamMergeList.vs1.20130928_145300.output 

python DataProcessing.Pipeline.DropIndividualsBasedOnPopGenomFile.vs2.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/20130930_POP_genomics_sample_information_2.edited.noMeta.dropIndvs.csv --file2 DataOrganization.CreatebamMergeList.vs1.20131114_193315.output > DataOrganization.CreatebamMergeList.vs1.20131114_193315.dropIndvs.output

bash DataProcessing.Pipeline.pt3.MergeallSampleBamFiles.Launcher.vs1.sh DataOrganization.CreatebamMergeList.vs1.20131114_193315.dropIndvs.output

bash DataOrganization.Utility.pt3.CheckOrigDirectoriesForFilesMissed.vs1.sh DataOrganization.CreatebamMergeList.vs1.20131114_193315.dropIndvs.output 
#Checking to see, given the directories specified in DataOrganization.CreatebamMergeList.vs1.20131114_193315.dropIndvs.output and grepping all the sff files from them, are those sff files present in the single line being used to merge that particular individual's total bam file. E.g. seeing if files present in the directories are properly in the 'CreatebamMergeList' line representing that/those directories for that individual

bash DataOrganization.Utility.pt3.CheckMergedBamsForContainingProperFiles.vs1.sh DataOrganization.CreatebamMergeList.vs1.20131114_193315.dropIndvs.output
#Checking to see whether the merged bam files contain all the files we expect it to given the source line of files to combine from DataOrganization.CreatebamMergeList.vs1.20131114_193315.dropIndvs.output

cp -p DataProcessing.Pipeline.pt4.ProcessSampleLvlbamFiles.vs1.sh DataProcessing.Pipeline.pt4.ProcessSampleLvlbamFiles.vs2.sh

bash DataProcessing.Pipeline.pt4.ProcessSampleLvlbamFiles.Launcher.vs1.sh DataOrganization.CreatebamMergeList.vs1.20131114_193315.dropIndvs.output

bash DataPrcoessing.Pipeline.Utility.GetperRegionpostQCStats.vs1.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output

cat 

bash DataPrcoessing.Pipeline.Utility.GetperFullBampostQCStats.vs1.sh DataOrganization.CreatebamMergeList.vs1.20131114_193315.dropIndvs.output

cat DataOrganization.CreatebamMergeList.vs1.20131114_193315.dropIndvs.output | perl -lane 'my @vals = split(/;/, $F[0]); if ($vals[0] !~ m/(POOL[a-zA-Z0-9]+-\d\dRL)/) { print join("\t", @F) ; } ' > DataOrganization.CreatebamMergeList.vs1.20131114_193315.dropIndvs.output.Missing
#Realized had POOL[a-zA-Z0-9]+_\d\dRL statement in DataProcessing.Pipeline.pt4.ProcessSampleLvlbamFiles.vs2.sh instead of POOL[a-zA-Z0-9]+.*\d\dRL so stats file not properly formatted and needed to redo them

bash DataProcessing.Pipeline.pt4.ProcessSampleLvlbamFiles.Launcher.vs1.sh DataOrganization.CreatebamMergeList.vs1.20131114_193315.dropIndvs.output.Missing

cat DataPrcoessing.Pipeline.Utility.GetperFullBampostQCStats.vs1.output | perl -lane 'my @array1; push(@array1, $F[1]); foreach my $entry (@F) { if ($entry !~m/[a-zA-Z]/) { push (@array1, $entry); } } print join(",", @array1);' > DataPrcoessing.Pipeline.Utility.GetperFullBampostQCStats.vs1.output.reformatted


#bash DataProcessing.Pipeline.pt5.MergebamFilesVariantCall.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged DataOrganization.CreatebamMergeList.vs1.20131114_193315.dropIndvs.output

bash DataProcessing.Pipeline.pt6.All.pta.SplitBamIntoChromosomes.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt6.Samtools.pta.CreateVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt6.GATK.pta.RunReduceReadsPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt6.All.ptb.ConvertVCFtoPEDPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/Samtools AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools

bash DataProcessing.Pipeline.pt6.All.ptc.CollapsePedFilesIntoSingleFile.vs2.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/Samtools AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.Samtools


#Do reformatting of other statsoutput from earlier in the pipeline (the per-region/run stat file vs per-individual stat file that's already been done) and figure out how or what to graph visually via histograms and such, what's most important to look at
#Think through individual information file using to make sure it's all right and such


bash DataProcessing.Pipeline.pt6.GATK.ptb.CreateVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash ../../../../DataProcessing.Pipeline.pt6.GATK.ptc.MergeVCFsAcrossChromosomes.vs1.sh

bash DataProcessing.Pipeline.pt6.GATK.ptd.RecalAndApplyVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

vcftools --gzvcf AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz --plink --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP

plink --file AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP --make-bed --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP

#Decided on a change to how I incorporated individuals with multiple runs across Pools. Originally I was just keeping one pool and removing the other from the total dataset (demarcated using carrots, hence the 'noCarrot' version of files to preserve the original markings but remove them for downstream use), but have now decided to not manually choose which pool to use but to collect and use them all for every individual that has multiple pool runs. /home/pg/michaelt/Data/ALL_MAPPING/DataOrganization.Utility.CheckForDupEntriesPOPSampleInfoFile.vs1.py identifies individuals with multiple pools and creates a list of each pool for that individual. DataProcessing.Pipeline.Utility.CombineMultPoolsForSameIndvbamMergeList.vs1.sh then removes the individual lines for each pool from the main Createbam file, collects them into a single line and reattaches the new single-line-per-individual to the removed file (producing a list of the compeltely removed main file, a list of all the new lines, and the to-be-used list of removed main file + new list
#Going to rerun the 'new list' of individuals and then continue doing analysis with the removed maine file + new list, e.g. DataOrganization.CreatebamMergeList.vs1.20131114_193315.output.multPOOLperIndvCollected
#There may be one or two individuals being dropped in the mix that should not be so, but for the time being I will move forward with the analysis. I believe, after spot-checking most parts of the analysis and lines of code, that things are functioning more or less as they should be. When the rest of the individuals are added this will allow a second go-around to investigate if other individuals are being dropped unintentionally and to fully iron-out these portions of the code
#python /home/pg/michaelt/Data/ALL_MAPPING/DataOrganization.Utility.CheckForDupEntriesPOPSampleInfoFile.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/20131202_POP_genomics_sample_information_Solid_and_MM5.noMeta.noStar.csv

python /home/pg/michaelt/Data/ALL_MAPPING/DataOrganization.Utility.CheckForDupEntriesPOPSampleInfoFile.vs1.py --file1 20130930_POP_genomics_sample_information_2.edited.noMeta.noCarrot.csv | perl -F: -ane 'my @vals1 = split(/,/, $F[0]); my $id1 = $vals1[1]; print $id1, ":"; foreach my $entry1 (@F) { my @valsN = split(/,/, $entry1); my @MID = split(//, $valsN[2]); if ($#MID == "3") { print "0", $valsN[2], ","; } else { print $valsN[2], ","; } foreach my $entry2 (@valsN) { if ($entry2 =~ m/ool/) { print $entry2; } } print ":";} print "\n";' | sed "s/'//g" | sed 's/\s//g' | perl -F: -lane 'print join(":", @F[1..$#F]);' > 20130930_POP_genomics_sample_information_2.edited.noMeta.noCarrot.DupListPrepforMergeListUse.txt
#Manually delete first line of this resulting file since it somewhat not needed and adding in an arbitrary piece of code to just 'delete the first line of the output' seems too hard-coded to just put in there. Would rather do it manually and observe the need for this each time this may have to be done

bash DataProcessing.Pipeline.Utility.CombineMultPoolsForSameIndvbamMergeList.vs1.sh /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/20130930_POP_genomics_sample_information_2.edited.noMeta.noCarrot.DupListPrepforMergeListUse.txt DataOrganization.CreatebamMergeList.vs1.20131114_193315.output #Creates DataOrganization.CreatebamMergeList.vs1.20131114_193315.output.multPOOLperIndvCollected* files 

cat 20130930_POP_genomics_sample_information_2.edited.noMeta.noCarrot.csv | grep -v \* > 20130930_POP_genomics_sample_information_2.edited.noMeta.noCarrot.dropIndvs.csv

python DataProcessing.Pipeline.DropIndividualsBasedOnPopGenomFile.vs2.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/20130930_POP_genomics_sample_information_2.edited.noMeta.noCarrot.dropIndvs.csv --file2 DataOrganization.CreatebamMergeList.vs1.20131114_193315.output.multPOOLperIndvCollected > DataOrganization.CreatebamMergeList.vs1.20131114_193315.multPOOLperIndvCollected.dropIndvs.output 

bash DataProcessing.Pipeline.pt3.MergeallSampleBamFiles.Launcher.vs1.sh DataOrganization.CreatebamMergeList.vs1.20131114_193315.output.multPOOLperIndvCollected.newEntries

bash DataProcessing.Pipeline.pt4.ProcessSampleLvlbamFiles.Launcher.vs1.sh DataOrganization.CreatebamMergeList.vs1.20131114_193315.output.multPOOLperIndvCollected.newEntries

#bash DataProcessing.Pipeline.pt5.MergebamFilesVariantCall.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged DataOrganization.CreatebamMergeList.vs1.20131114_193315.multPOOLperIndvCollected.dropIndvs.output

bash DataProcessing.Pipeline.pt6.All.pta.SplitBamIntoChromosomes.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt6.Samtools.pta.CreateVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt6.GATK.pta.RunReduceReadsPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt6.GATK.ptb.CreateVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash ../../../../DataProcessing.Pipeline.pt6.GATK.ptc.MergeVCFsAcrossChromosomes.vs1.sh

bash DataProcessing.Pipeline.pt6.GATK.ptd.RecalAndApplyVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

gzip AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.raw.vcf

zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz | grep PASS > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.temp1

zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz | grep \# > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.header

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.header AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.temp1 | gzip > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.gz

rm AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.temp1

vcftools --gzvcf AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.gz --geno .9 --recode --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.geno90.vcf

#NOTE (20131211) -- so realized when I merged multiple POOL#s into one file I kept the POOL#s the same in the .bam file's sample ID tag, so the variant calling partitioned the merged .bam file into separate 'individuals' again. So updated DataProcessing.Pipeline.pt3.MergeallSampleBamFiles.vs3.sh to now change the SM:... ID in the merged .bam file to only contain one POOL# to account for the file only supposed to be representing a single individual now. As a result, redoing everything from the pt3 merge step onwards again

bash DataProcessing.Pipeline.Utility.RemoveaCertainFile.vs2.sh DataOrganization.CreatebamMergeList.vs1.20131114_193315.multPOOLperIndvCollected.dropIndvs.output 

bash DataProcessing.Pipeline.pt3.MergeallSampleBamFiles.Launcher.vs1.sh DataOrganization.CreatebamMergeList.vs1.20131114_193315.multPOOLperIndvCollected.dropIndvs.output

bash DataProcessing.Pipeline.pt4.ProcessSampleLvlbamFiles.Launcher.vs1.sh DataOrganization.CreatebamMergeList.vs1.20131114_193315.multPOOLperIndvCollected.dropIndvs.output

#bash DataProcessing.Pipeline.pt5.MergebamFilesVariantCall.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged DataOrganization.CreatebamMergeList.vs1.20131114_193315.multPOOLperIndvCollected.dropIndvs.output

bash DataProcessing.Pipeline.pt6.All.pta.SplitBamIntoChromosomes.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt6.Samtools.pta.CreateVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt6.GATK.pta.RunReduceReadsPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash DataProcessing.Pipeline.pt6.GATK.ptb.CreateVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

bash ../../../../DataProcessing.Pipeline.pt6.GATK.ptc.MergeVCFsAcrossChromosomes.vs1.sh

bash DataProcessing.Pipeline.pt6.GATK.ptd.RecalAndApplyVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

gzip AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.raw.vcf

zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz | grep PASS > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.temp1

zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.gz | grep \# > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.header

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.vcf.header AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.temp1 | gzip > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.gz

rm AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.temp1

vcftools --gzvcf AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.gz --geno .9 --recode --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.geno90.vcf

vcftools --gzvcf AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.gz --geno .85 --recode --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.geno85.vcf

vcftools --gzvcf AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.gz --geno .95 --recode --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.geno95.vcf

vcftools --gzvcf AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.gz --missing --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss | awk '{ print $6 }' | perl -lane 'printf "%.2f\n", $F[0];' | sort -g -k 1,1 | uniq -c
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss | awk '{ print $6 }' | perl -lane 'printf "%.2f\n", $F[0];' | sort -g -k 1,1 | uniq -c | perl -lane '$cumulativeSum += $F[0]; push(@F, $cumulativeSum/2292557); print join("\t", @F);'

cat /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/OID41305_HG19_Match5_probes/OID41305_HG19_Match5_probe_coverage.bed | perl -lane 'if ($F[0] =~ m/chr([a-zA-Z0-9]*).*/) { $F[0] = $1; print join("\t", @F); } ' > /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/OID41305_HG19_Match5_probes/OID41305_HG19_Match5_probe_coverage.formatted.bed

samtools view  ../../mapping_pool_106-124/POOL106_01RL/POOL106_01RL.preGATK.samplesMerged.rmdup.BQSR.calmd.bam | perl -lane 'my @vals1 = split(//, $F[9]); print $F[2], "\t", $F[3], "\t", $F[3] + scalar(@vals1), "\t", scalar(@vals1);' > ../../mapping_pool_106-124/POOL106_01RL/POOL106_01RL.preGATK.samplesMerged.rmdup.BQSR.calmd.OverlapPlot.formatted

python DataProcessing.Pipeline.Utility.AddColorInfotoVCFtoolslmissFile.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss.0kbWindow.plotReady

#R --vanilla --slave --args < ../../../../DataProcessing.Pipeline.Utility.PlotArrayReads_SeqReads.wVariants.vs1.R /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/OID41305_HG19_Match5_probes/OID41305_HG19_Match5_probe_coverage.formatted.bed /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_106-124/POOL106_01RL/POOL106_01RL.preGATK.samplesMerged.rmdup.BQSR.calmd.OverlapPlot.formatted /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/OutputFiles/DataProcessing.Pipeline.Utility.PlotArrayReads_SeqReads.wVariants.vs1

R --vanilla --slave --args < ../../../../DataProcessing.Pipeline.Utility.PlotArrayReads_SeqReads.wVariants.vs2.R /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_106-124/POOL106_01RL/POOL106_01RL.preGATK.samplesMerged.rmdup.BQSR.calmd.OverlapPlot.formatted /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss.0kbWindow.plotReady /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/OutputFiles/DataProcessing.Pipeline.Utility.PlotArrayReads_SeqReads.wVariants.vs2

python ../../../../DataProcessing.Pipeline.Utility.AddColorInfotoVCFtoolslmissFile.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss --window 500 > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss.500bWindow.plotReady

python ../../../../DataProcessing.Pipeline.Utility.AddColorInfotoVCFtoolslmissFile.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss --window 1000 > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss.1kbWindow.plotReady

python ../../../../DataProcessing.Pipeline.Utility.AddColorInfotoVCFtoolslmissFile.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss --window 5000 > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss.5kbWindow.plotReady

python ../../../../DataProcessing.Pipeline.Utility.AddColorInfotoVCFtoolslmissFile.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss --window 10000 > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss.10kbWindow.plotReady

python ../../../../DataProcessing.Pipeline.Utility.AddColorInfotoVCFtoolslmissFile.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss --window 25000 > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss.25kbWindow.plotReady

python ../../../../DataProcessing.Pipeline.Utility.AddColorInfotoVCFtoolslmissFile.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss --window 50000 > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss.50kbWindow.plotReady

R --vanilla --slave --args < ../../../../DataProcessing.Pipeline.Utility.PlotArrayReads_SeqReads.wVariants.vs2.R /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_106-124/POOL106_01RL/POOL106_01RL.preGATK.samplesMerged.rmdup.BQSR.calmd.OverlapPlot.formatted /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss.500bWindow.plotReady /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/OutputFiles/DataProcessing.Pipeline.Utility.PlotArrayReads_SeqReads.wVariants.vs2.500bWindow

R --vanilla --slave --args < ../../../../DataProcessing.Pipeline.Utility.PlotArrayReads_SeqReads.wVariants.vs2.R /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_106-124/POOL106_01RL/POOL106_01RL.preGATK.samplesMerged.rmdup.BQSR.calmd.OverlapPlot.formatted /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss.1kbWindow.plotReady /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/OutputFiles/DataProcessing.Pipeline.Utility.PlotArrayReads_SeqReads.wVariants.vs2.1kbWindow

R --vanilla --slave --args < ../../../../DataProcessing.Pipeline.Utility.PlotArrayReads_SeqReads.wVariants.vs3.R /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_106-124/POOL106_01RL/POOL106_01RL.preGATK.samplesMerged.rmdup.BQSR.calmd.OverlapPlot.formatted /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss.1kbWindow.plotReady /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/OutputFiles/DataProcessing.Pipeline.Utility.PlotArrayReads_SeqReads.wVariants.vs3.1kbWindow

zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.gz | awk '{ print $1, "\t", $2, "\t", $2, "\t", $4, "\t", $5 }' | grep -v ^# > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.AnnovarFormat

perl /home/michaelt/Software/annovar/summarize_annovar.pl /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.AnnovarFormat /home/michaelt/Software/annovar/ --ver1000g 1000g2012apr --verdbsnp 129 --veresp 6500 --buildver hg19 --remove

mv DataProcessing.Pipeline.DropOffTargetReads.vs1.py DataProcessing.Pipeline.Utility.DropOff.TargetReads.vs1.py

python /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.DropOff.VCFVariants.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.gz --window 1000 | gzip > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.DropOffTargetVariants.1kbWindow.vcf.gz

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.DropOffTargetVariants.1kbWindow.vcf.gz --geno .85 --recode --recode-INFO-all --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.DropOffTargetVariants.1kbWindow.85geno

gzip /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.DropOffTargetVariants.1kbWindow.85geno.recode.vcf &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.DropOffTargetVariants.1kbWindow.vcf.gz --geno .95 --recode --recode-INFO-all --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.DropOffTargetVariants.1kbWindow.95geno

gzip /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.DropOffTargetVariants.1kbWindow.95geno.recode.vcf &


#In directory /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles
#Using phenotype file descriptions in DataProcessing.Pipeline.CreatePhenotypeFile.vs1.py to help determine which column + values to use
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($3 == "1") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.WhiteOnly.justSeroNeg.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($3 == "2") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.WhiteOnly.justSeroPos.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($4 == "1") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.WhiteOnly.justSeroHighlyExposedNeg.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($5 == "1") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.WhiteOnly.justRapidVRapid.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($5 == "2") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.WhiteOnly.justSlowVSlow.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($6 == "1") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.WhiteOnly.justVeryRapid.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($6 == "2") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.WhiteOnly.justVerySlow.FID

#In directory /home/michaelt/Data/1000G/AncestralAlignments online sources say these reference files based on Gch37 which is the equivalent of hg19 so should be same reference bases between these files and my own 
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/pilot_data/technical/reference/ancestral_alignments/human_ancestor*
wget http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/phase1/analysis_results/supporting/ancestral_alignments/human_ancestor_GRCh37_e59.tar.bz2

#Trying to get AA information for each variant called in the dataset. Following code was copied/pasted from http://seqanswers.com/forums/showthread.php?t=15026 "1000 genomes ancestral alleles?"
ls human_ancestor_*.fa.bz2 | while read IN; do
OUT=`echo $IN | sed 's,bz2$,gz,'`
CHR=`echo $IN | sed 's,human_ancestor_,, ; s,.fa.bz2,,'`
bzcat $IN | sed "s,^>.*,>$CHR," | gzip -c > $OUT
samtools faidx $OUT
done
#

#Test line
samtools faidx human_ancestor_1.fa.gz 1:1000000-1000020 #Expect to see tgggcacagcctcacccagga

zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.gz | fill-aa -a /home/michaelt/Data/1000G/AncestralAlignments/human_ancestor_GRCh37_e59/human_ancestor_ | gzip -c > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz

vcftools --gzvcf AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --plink --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped | awk '{ print $1, "\t", $2 } ' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDIIDs

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDIIDs | awk '{ print $1 } ' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs

python /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.DropOff.VCFVariants.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --window 1000 | gzip > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.vcf.gz

python /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.DropOff.VCFVariants.vs1.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --window 0 | gzip > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.0kbWindow.vcf.gz

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.vcf.gz --geno .95 --recode --recode-INFO-all --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno

gzip /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.FID --freq --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.FID --freq --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos.FID --freq --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.FID --freq --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.FID --freq --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.FID --freq --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.FID --freq --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.FID --freq --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow &

#
#20140101 NOTE -- These *.pheno and *.covar files contain FID and IID information for /every/ POOL_* individual, even if the main .vcf/.ped/.whatever file does not contain duplicate entries of the same FID/IID (e.g. multiple POOL_* were combined for a single FID/IID, as should be). So 'total line counts' for some of these *.pheno and *.covar files may be 'off' but in fact this is fine since the main .vcf/.ped/.whatever file is properly delimited. This is just to allow /all/ entries to have information so if the leading POOL_* identifier for a given FID/IID group changes for whatever reason, these information files can still be used since each POOL_* in any particular FID/IID group should be annotated
#

python DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs2.py --file1 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/20130930_POP_genomics_sample_information_2.edited.noMeta.noCarrot.dropIndvs.csv --file2 /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/Sample_status_list_9-16-13_CT.edited.noMeta.csv > DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs2.20140101_POP_genomics_sample.status_list_9-16-13.output

python DataProcessing.Pipeline.CreatePhenotypeFile.vs1.py --file1 DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs2.20140101_POP_genomics_sample.status_list_9-16-13.output > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno

python DataProcessing.Pipeline.CreateCovariateFile.vs1.py --file1 DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs2.20140101_POP_genomics_sample.status_list_9-16-13.output > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar 

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar | awk '{ if ($5 == "1") { print $1, "\t", $2 } } ' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDIIDs

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDIIDs | awk '{ print $1 } ' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs

#Reran creating PLINK pheno files that contain only certain sero+/- and slow/rapid individuals

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($3 == "1") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($4 == "1") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($5 == "1") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($5 == "2") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($6 == "1") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($6 == "2") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.FID

#So order is: justSeroHighlyExposedNeg 
paste AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.frq | gzip > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.AllPhenos.frq.gz

gzip AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.frq 

#gunzip AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.frq.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.frq.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.frq.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos.frq.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.frq.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.frq.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.frq.gz

#paste <(zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz | tail -n +125 | perl -lane 'print join("\t", @F[0..8]);') <(zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.AllPhenos.frq.gz | tail -n +2) | gzip > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.wFreqsRplcGenos.noHeader.vcf.gz

###cat <(zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz | head -n 124) <(zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.wFreqsRplcGenos.noHeader.vcf.gz) | gzip > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.wFreqsRplcGenos.vcf.gz
#cat <(zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz | awk '{ if (NR < 125) { print $0 } }' ) <(zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.wFreqsRplcGenos.noHeader.vcf.gz) | gzip > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.wFreqsRplcGenos.asddadadad.vcf.gz
#rm /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.wFreqsRplcGenos.noHeader.vcf.gz
#rm AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.*

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.AnnovarFormat.genome_summary.csv | grep exonic | grep -v ncRNA | head -n 10 | perl -F, -lane 'print join("\t", @F[$#F-6..$#F]);' | perl -lane 'print join("\t", @F[$#F-4..$#F]);' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AnnovarTest/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.AnnovarFormat.TestGroup.vs1

perl /home/michaelt/Software/annovar/summarize_annovar.pl /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AnnovarTest/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.AnnovarFormat.TestGroup.vs1 /home/michaelt/Software/annovar/ --ver1000g 1000g2012apr --verdbsnp 129 --veresp 6500 --buildver hg19 --remove

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.AnnovarFormat.TestGroup.vs1 | perl -lane '($F[3], $F[4]) = ($F[4], $F[3]); print join("\t", @F);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.AnnovarFormat.TestGroup.vs2

perl /home/michaelt/Software/annovar/summarize_annovar.pl /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AnnovarTest/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.AnnovarFormat.TestGroup.vs2 /home/michaelt/Software/annovar/ --ver1000g 1000g2012apr --verdbsnp 129 --veresp 6500 --buildver hg19 --remove

python /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.CombineVCFwFreqsAnnovarInfo.vs1.py --file1 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.AllPhenos.frq.gz --file3 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.vcf.AnnovarFormat.genome_summary.csv | sort -t, -k 1,1 -k 2,2 | sed 's/"//g' | perl -F, -lane 'for (my $i = 25; $i <= 31; $i++) { if ($F[$i] eq "NA") { $F[$i] = "-9"; } } print join(",", @F);' | gzip > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.txt.gz

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.CalcMeandAF.vs1.R AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.txt.gz

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/OutputFiles/DataProcessing.Pipeline.Utility.CalcMeandAF.vs1.GeneSpecificAnalyses.txt | grep PP2D | grep -v PP2DP | sort -g -k 9,9

Timepoint check: 20140106

bash DataPrcoessing.Pipeline.Utility.GetperRegionpostQCStats.vs1.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output

cat DataPrcoessing.Pipeline.Utility.GetperRegionpostQCStats.vs1.output | perl -lane 'my @array1; push(@array1, $F[1]); foreach my $entry (@F) { if ($entry !~ m/[a-zA-Z]/) { push (@array1, $entry); } } print join(",", @array1);' | awk 'BEGIN{ print "ID,TotalReadsPreQC,TotalReadsQ10,TotalReadsQ10Prcnt,TotalReadsF4,TotalReadsF4Prcnt,TotalReadsF256,TotalReadsF256Prcnt,TotalReadsPostQC,TotalReadsDropped,TotalReadsDroppedPrcnt,AverageReadLengthPreQC,AverageReadLengthPostQC,BedFileCoveragePostQC" } { print $0 } ' > DataPrcoessing.Pipeline.Utility.GetperRegionpostQCStats.vs1.output.reformatted 

bash DataPrcoessing.Pipeline.Utility.GetperFullBampostQCStats.vs1.sh DataOrganization.CreatebamMergeList.vs1.20131114_193315.multPOOLperIndvCollected.dropIndvs.output

#Total column numbers post formatting = 27
cat DataPrcoessing.Pipeline.Utility.GetperFullBampostQCStats.vs1.output | perl -lane 'my @array1; push(@array1, $F[1]); foreach my $entry (@F) { if ($entry !~ m/[a-zA-Z]/) { push (@array1, $entry); } } print join(",", @array1);' | awk 'BEGIN{ print "ID,NumberOfOriginalBamFiles,TotalReadsPreQC,TotalReadsPreQCForward,TotalReadsPreQCReverse,TotalReadsPreQCForward_Reverse,PreQCMAPQmean,PreQCMAPQsd,PreQCMean,PreQCSD,PreQCMax,PreQCMin,CoveragePreQC,TotalReadsPostRmdup,TotalReadsPostRmdupDropped,TotalReadsPostRmdupDroppedPercentage,TotalReadsPostQC,TotalReadsPostQCForward,TotalReadsPostQCReverse,TotalReadsPostQCForward_Reverse,PostQCMAPQmean,PostQCMAPQsd,PostQCMean,PostQCSD,PostQCMax,PostQCMin,CoveragePostQC" } { print $0 } ' > DataPrcoessing.Pipeline.Utility.GetperFullBampostQCStats.vs1.output.reformatted

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.EvaluateSummaryFiles.vs1.R /home/pg/michaelt/Data/ALL_MAPPING/DataPrcoessing.Pipeline.Utility.GetperRegionpostQCStats.vs1.output.reformatted /home/pg/michaelt/Data/ALL_MAPPING/DataPrcoessing.Pipeline.Utility.GetperFullBampostQCStats.vs1.output.reformatted

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz --plink --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode

plink --file /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode --make-bed --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.ped | perl -lane '$F[5] = "1"; print join("\t", @F);' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.phenoColEdit.ped

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.phenoColEdit.ped | perl -lane 'print join("\t", @F[0..5]);' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.phenoColEdit.pedind

ln -s /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.bim /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.pedsnp

scp /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.phenoColEdit.ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.phenoColEdit.pedind /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.pedsnp mturchin20@wolfy.uchicago.edu:/Users/mturchin20/clstrHme/Lab_Stuff/StephensLab/NUWrk/HIVStff/PG/Eigenstrat/.  

cp -p AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.250k.parfile AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.parfile

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/smartpca -p AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.parfile

scp mturchin20@wolfy.uchicago.edu:/Users/mturchin20/clstrHme/Lab_Stuff/StephensLab/NUWrk/HIVStff/PG/Eigenstrat/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.Results.pca /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/.

python /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.py --file1 /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20140101_POP_genomics_sample.status_list_9-16-13.output --file2 AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.Results.pca > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.Results.pca.altrd.race

scp /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.Results.pca.altrd.race mturchin20@wolfy.uchicago.edu:/Users/mturchin20/clstrHme/Lab_Stuff/StephensLab/NUWrk/HIVStff/PG/Eigenstrat/.

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.Results.pca.altrd.race -c 1:2 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.Results.pca.altrd.race.plot.1vs2.xtxt

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.Results.pca.altrd.race -c 3:4 -p White_non-Hispanic:American_Indian_or_Alaskan_Native:Black_non-Hispanic:Other:White_Hispanic -x -o AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.Results.pca.altrd.race.plot.3vs4.xtxt

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.Results.pca.altrd.race | grep White_non-Hispanic | perl lane 'my @vals1 = split(/:/, $F[0]); $F[0] = $vals1[0]; print join("\t", @F);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.Results.pca.altrd.race.FIDs 

#Directory /home/michaelt/Data/HapMap/HapMap3
wget ftp://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/2009-01_phaseIII/plink_format/*
wget ftp://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/2009-01_phaseIII/draft2_samples_QC+.txt

#Direcotry /home/michaelt/Software/liftOver
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/liftOver
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg18/liftOver/hg18ToHg19.over.chain.gz

cat hapmap3_r2_b36_fwd.consensus.qc.poly.map | perl -lane '$val1++; print "chr", $F[0], "\t", $F[3], "\t", $F[3]+1, "\t", $val1;' > hapmap3_r2_b36_fwd.consensus.qc.poly.map.liftOverFormat

./../../Software/liftOver/liftOver hapmap3_r2_b36_fwd.consensus.qc.poly.map.liftOverFormat ../../Software/liftOver/hg18ToHg19.over.chain.gz hapmap3_r2_b36_fwd.consensus.qc.poly.map.liftOverFormat.hg19 hapmap3_r2_b36_fwd.consensus.qc.poly.map.liftOverFormat.dropped

paste hapmap3_r2_b36_fwd.consensus.qc.poly.map hapmap3_r2_b36_fwd.consensus.qc.poly.map.liftOverFormat > hapmap3_r2_b36_fwd.consensus.qc.poly.map.liftOverFormat.ForPostProcessing

python /home/michaelt/Data/HapMap/HapMap3/VLookUp.Python.vs1.py --file1 /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly.map.liftOverFormat.hg19 --file2 /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly.map.liftOverFormat.ForPostProcessing > /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly.liftOver.hg18tohg19.map

python /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/VLookUp.Python.vs1.py --file1 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.map --file2 /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly.liftOver.hg18tohg19.map | awk '{ print $2 }' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.rsIDs

cat /home/michaelt/Data/HapMap/HapMap3/draft2_samples_QC+.txt | grep -E 'CEU|CHB|YRI' | awk '{ if ($8 =="x") { print $0 } } ' > /home/michaelt/Data/HapMap/HapMap3/draft2_samples_QC+.CEUCHBYRI.Unrelated.txt

cat /home/michaelt/Data/HapMap/HapMap3/draft2_samples_QC+.CEUCHBYRI.Unrelated.txt | awk '{ print $1, "\t", $2 }' > /home/michaelt/Data/HapMap/HapMap3/draft2_samples_QC+.CEUCHBYRI.Unrelated.FIDIIDs

plink --file /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly --make-bed --out /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly

plink --bfile /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly --extract /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.rsIDs --keep /home/michaelt/Data/HapMap/HapMap3/draft2_samples_QC+.CEUCHBYRI.Unrelated.FIDIIDs --recode --out /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly.UnrelatedCEUCHBYRI.overlapHIVGeneExomeData

cat /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly.UnrelatedCEUCHBYRI.overlapHIVGeneExomeData.map | awk '{ print $2 }' > /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly.UnrelatedCEUCHBYRI.overlapHIVGeneExomeData.map.rsIDs 

plink --file /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3 --make-bed --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3

plink --bfile /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode --extract /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly.UnrelatedCEUCHBYRI.overlapHIVGeneExomeData.map.rsIDs --recode --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3

#There are a few SNPs that do not match up between the two files. Removing them (about ~30?) and recreating the overlap .ped files once more
paste /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.bim /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly.UnrelatedCEUCHBYRI.overlapHIVGeneExomeData.bim | awk '{ if (($5 == $11) || ($5 == $12) ) { print $0 } } ' | awk '{ print $2 }' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.FinalListwDrops.rsIDs

plink --bfile /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly --extract /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.FinalListwDrops.rsIDs --keep /home/michaelt/Data/HapMap/HapMap3/draft2_samples_QC+.CEUCHBYRI.Unrelated.FIDIIDs --recode --out /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly.UnrelatedCEUCHBYRI.overlapHIVGeneExomeData.vs2

plink --bfile /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode --extract /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.FinalListwDrops.rsIDs --recode --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.vs2

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.vs2.ped /home/michaelt/Data/HapMap/HapMap3/hapmap3_r2_b36_fwd.consensus.qc.poly.UnrelatedCEUCHBYRI.overlapHIVGeneExomeData.vs2.ped > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.ped

plink --ped AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.ped --map AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.vs2.map --make-bed --out AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.ped | perl -lane '$F[5] = "1"; print join("\t", @F);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.phenoColEdit.ped

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.phenoColEdit.ped | perl -lane 'print join("\t", @F[0..5]);' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.phenoColEdit.pedind

ln -s AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.bim AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.pedsnp

scp AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.phenoColEdit.ped AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.phenoColEdit.pedind AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.pedsnp mturchin20@wolfy.uchicago.edu:/Users/mturchin20/clstrHme/Lab_Stuff/StephensLab/NUWrk/HIVStff/PG/Eigenstrat/.

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/smartpca -p AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.parfile

scp mturchin20@wolfy.uchicago.edu:/Users/mturchin20/clstrHme/Lab_Stuff/StephensLab/NUWrk/HIVStff/PG/Eigenstrat/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/.

python /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.py --file1 /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.CreateProperIndvPhenoLinkFile.vs1.20140101_POP_genomics_sample.status_list_9-16-13.output --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.pt1

cp -p /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.py /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.HapMap3vs.py

python /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.EditEigenstratPCAfileForPlotting.HapMap3vs.py --file1 /home/michaelt/Data/HapMap/HapMap3/draft2_samples_QC+.txt --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.pt2

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.pt1 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.pt2 > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race

sed -i 's/American_Indian_or_Alaskan_Native/AIndian_or_Alaskan_Native/g' AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race

scp /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race mturchin20@wolfy.uchicago.edu:/Users/mturchin20/clstrHme/Lab_Stuff/StephensLab/NUWrk/HIVStff/PG/Eigenstrat/.

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race -c 1:2 -p White_non-Hispanic:White_Hispanic:Asian_or_Pacific_Islander:AIndian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_non-Hispanic:Black_Hispanic:Other:CEU:CHB:YRI -x -o AllPools.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.plot.1vs2.xtxt

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race | awk '{ if ((($2 >= 0) && ($2 <= .2)) && (($3 >= -.01) && ($3 <= .03))) { print $0 } } ' | grep White_non-Hispanic > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race -c 3:4 -p White_non-Hispanic:White_Hispanic:Asian_or_Pacific_Islander:AIndian_or_Alaskan_Native:Asian_or_Pacific_Islander:Black_non-Hispanic:Black_Hispanic:Other:CEU:CHB:YRI -x -o AllPools.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.plot.3vs4.xtxt

ln -s AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed AllPools.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed

/mnt/lustre/home/mturchin20/Software/EigenSoft/bin/ploteig -i  AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed -c 1:2 -p White_non-Hispanic -x -o  AllPools.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed.xtxt

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed | perl -lane 'my @vals1 = split(/:/, $F[0]); print $vals1[0];' > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed.justFIDs

scp mturchin20@wolfy.uchicago.edu:/Users/mturchin20/clstrHme/Lab_Stuff/StephensLab/NUWrk/HIVStff/PG/Eigenstrat/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed.justFIDs /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/.

cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed.justFIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($3 == "1") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed.justFIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($4 == "1") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed.justFIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($5 == "1") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed.justFIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($5 == "2") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed.justFIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($6 == "1") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed.justFIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.FID
cat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | awk '{ if ($6 == "2") { print $1 } }' | grep -f AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed.justFIDs > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.FID

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.EvaluateSummaryFiles.vs1.R /home/pg/michaelt/Data/ALL_MAPPING/DataPrcoessing.Pipeline.Utility.GetperRegionpostQCStats.vs1.output.reformatted /home/pg/michaelt/Data/ALL_MAPPING/DataPrcoessing.Pipeline.Utility.GetperFullBampostQCStats.vs1.output.reformatted

scp /home/pg/michaelt/Data/ALL_MAPPING/Results/Graphics/DataProcessing.Pipeline.Utility.EvaluateSummaryFiles.vs1.*.jpeg mturchin20@wolfy.uchicago.edu:/Users/mturchin20/LabStuff/StephensLab/HIVStuff/PG/Results/Graphics/.

bash DataPrcoessing.Pipeline.Utility.GetperfastQpostQCStats.vs1.sh DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output 
#Deleted 4 lines with nothing in them
sed -i 's/(//g' /home/pg/michaelt/Data/ALL_MAPPING/DataPrcoessing.Pipeline.Utility.GetperfastQpostQCStats.vs1.output
sed -i 's/)//g' /home/pg/michaelt/Data/ALL_MAPPING/DataPrcoessing.Pipeline.Utility.GetperfastQpostQCStats.vs1.output

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.EvaluateSummaryFiles.vs1.R /home/pg/michaelt/Data/ALL_MAPPING/DataPrcoessing.Pipeline.Utility.GetperfastQpostQCStats.vs1.output /home/pg/michaelt/Data/ALL_MAPPING/DataPrcoessing.Pipeline.Utility.GetperRegionpostQCStats.vs1.output.reformatted /home/pg/michaelt/Data/ALL_MAPPING/DataPrcoessing.Pipeline.Utility.GetperFullBampostQCStats.vs1.output.reformatted

python DataProcessing.Pipeline.AddPCComponentsToCovarFile.py --file1 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/Eigenstrat/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.5PCs.covar
#Edit code in between runs
python DataProcessing.Pipeline.AddPCComponentsToCovarFile.py --file1 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/Eigenstrat/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.covar.WhiteOnly.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.ped.FIDs | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/Eigenstrat/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.Results.pca.altrd.race.justWhiteQCed.justFIDs | awk '{ print $1, "\t", $2 } ' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar.justWhite.FIDIIDs

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar.justWhite.FIDIIDs | awk '{ print $1 }' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar.justWhite.FIDs

plink --bfile /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar --covar-number 1,2,3,4,5,6,7,8 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar.justWhite.FIDIIDs --logistic --allow-no-sex --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.whiteOnly.5PCs

plink --bfile /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar --covar-number 2,4,5,6,7,8 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar.justWhite.FIDIIDs --logistic --allow-no-sex --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.whiteOnly.5PCs

plink --bfile /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar --covar-number 2,4,5,6,7,8 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar.justWhite.FIDIIDs --maf .01 --logistic --allow-no-sex --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.whiteOnly.5PCs.maf01

plink --bfile /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode --pheno /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno --mpheno 1 --covar /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar --covar-number 1,2,3,4,5,6,7,8,9,10,11,12,13 --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar.justWhite.FIDIIDs --logistic --allow-no-sex --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.whiteOnly.10PCs

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.vs2.R /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.whiteOnly.5PCs.assoc.logistic Pheno1_Logistic_5PCs /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.5PCs.assoc.logsitic.QQplot.jpeg &

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.QQPlot.vs2.R /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.whiteOnly.10PCs.assoc.logistic Pheno1_Logistic_10PCs /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.10PCs.assoc.logsitic.QQplot.jpeg &

zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq.gz | perl -lane 'my @vals1 = split(/:/, $F[4]); my @vals2 = split(/:/, $F[5]); push(@F, sprintf("%.0f", $vals1[1]*$F[3])); push(@F, sprintf("%.0f", $vals2[1]*$F[3])); print join("\t", @F); ' | gzip > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq.wAlleleCounts.gz

#Edited VLookUp.Python.vs1.py
python /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/VLookUp.Python.vs1.py --file1 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.whiteOnly.5PCs.assoc.logistic --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq.wAlleleCounts.gz | gzip > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.whiteOnly.5PCs.assoc.logistic.wAC.gz

R --vanilla --slave --args  < /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Utility.ComparePValvsAC.vs1.R /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.whiteOnly.5PCs.assoc.logistic.wAC.gz /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Utility.ComparePValvsAC.vs1.plot.jpeg

R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.PlotSFS.vs1.R /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.txt.gz /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/OutputFiles/Graphics/DataProcessing.Pipeline.Utility.PlotSFS.vs1.plot.jpeg

zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.txt.gz | grep exonic | awk -F, '{ print $19 } ' | sort | uniq > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.txt.GeneIDList

zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.txt.gz | grep exonic | awk -F, '{ print $19 } ' | sort | uniq > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.txt.GeneIDList.Exonic

zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.txt.gz | grep exonic | grep -v RNA | gzip > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.Exonic.txt.gz

python /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Analysis.VariantDensity.vs2.py --file1 /home/michaelt/Data/UCSC/UCSC_hg19_GeneInformation_wSymbols.vs2.gz --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.Exonic.txt.gz > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Analysis.VariantDensity.vs2.ExonicVariants.All.output

#Edited code
python /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Analysis.VariantDensity.vs2.py --file1 /home/michaelt/Data/UCSC/UCSC_hg19_GeneInformation_wSymbols.vs2.gz --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.Exonic.txt.gz > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Analysis.VariantDensity.vs2.ExonicVariants.Nonsynonymous.output

#Edited code
python /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Analysis.VariantDensity.vs2.py --file1 /home/michaelt/Data/UCSC/UCSC_hg19_GeneInformation_wSymbols.vs2.gz --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.Exonic.txt.gz > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Analysis.VariantDensity.vs2.ExonicVariants.PP2_D.output

#Edited code
python /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Analysis.VariantDensity.vs2.py --file1 /home/michaelt/Data/UCSC/UCSC_hg19_GeneInformation_wSymbols.vs2.gz --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.Exonic.txt.gz > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Analysis.VariantDensity.vs2.ExonicVariants.PP2_DP.output

R --vanilla --slave --args < DataProcessing.Pipeline.Analysis.VariantDensity.FollowUpCalculations.vs1.R DataProcessing.Pipeline.Analysis.VariantDensity.vs2.ExonicVariants.PP2_D.output | awk '{ if (($4 != "NA") && ($2 >= 4)) { print $0 } } ' | sort -rg -k 3,3
R --vanilla --slave --args < DataProcessing.Pipeline.Analysis.VariantDensity.FollowUpCalculations.vs1.R DataProcessing.Pipeline.Analysis.VariantDensity.vs2.ExonicVariants.PP2_DP.output | awk '{ if (($4 != "NA") && ($2 >= 4)) { print $0 } } ' | sort -rg -k 3,3

#MAPK12 specifically looking at here
zcat AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz | awk '{ if ($1 == "22") { print $0 } } ' | grep 50691870 | perl -ane 'for (my $i = 9; $i <= $#F; $i++) { my @vals1 = split(/:/, $F[$i]); if ($vals1[0] =~ m/1/) { print $i, "-", $F[$i], "\t"; } } print "\n";'

zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz | awk '{ if ($1 == "22") { print $0 } } ' | grep 50693697 | perl -ane 'for (my $i = 9; $i <= $#F; $i++) { my @vals1 = split(/:/, $F[$i]); if ($vals1[0] =~ m/1/) { print $i, "-", $F[$i], "\t"; } } print "\n";'
346-0/1:6,10:16:99:271,0,158    398-0/1:10,1:11:1:1,0,294
zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz | awk '{ if ($1 == "22") { print $0 } } ' | grep 50694078 | perl -ane 'for (my $i = 9; $i <= $#F; $i++) { my @vals1 = split(/:/, $F[$i]); if ($vals1[0] =~ m/1/) { print $i, "-", $F[$i], "\t"; } } print "\n";'
301-0/1:9,1:10:4:4,0,238        316-0/1:10,1:11:2:2,0,278       379-0/1:5,5:10:99:147,0,116
zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz | awk '{ if ($1 == "22") { print $0 } } ' | grep 50694084 | perl -ane 'for (my $i = 9; $i <= $#F; $i++) { my @vals1 = split(/:/, $F[$i]); if ($vals1[0] =~ m/1/) { print $i, "-", $F[$i], "\t"; } } print "\n";'
220-0/1:2,12:15:20:373,0,20     234-0/1:12,9:20:99:241,0,282    435-0/1:6,6:12:99:176,0,150
zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz | awk '{ if ($1 == "22") { print $0 } } ' | grep 50694251 | perl -ane 'for (my $i = 9; $i <= $#F; $i++) { my @vals1 = split(/:/, $F[$i]); if ($vals1[0] =~ m/1/) { print $i, "-", $F[$i], "\t"; } } print "\n";'
428-0/1:5,1:6:4:4,0,156 493-0/1:10,2:12:32:32,0,302     495-0/1:9,1:10:4:4,0,280        571-0/1:18,20:37:99:499,0,506
zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz | awk '{ if ($1 == "22") { print $0 } } ' | grep 50694280 | perl -ane 'for (my $i = 9; $i <= $#F; $i++) { my @vals1 = split(/:/, $F[$i]); if ($vals1[0] =~ m/1/) { print $i, "-", $F[$i], "\t"; } } print "\n";'
569-0/1:18,20:37:99:530,0,453
zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz | awk '{ if ($1 == "22") { print $0 } } ' | grep 50694529 | perl -ane 'for (my $i = 9; $i <= $#F; $i++) { my @vals1 = split(/:/, $F[$i]); if ($vals1[0] =~ m/1/) { print $i, "-", $F[$i], "\t"; } } print "\n";'
440-0/1:4,1:5:21:21,0,105       492-0/1:8,1:9:10:10,0,223       554-0/1:11,9:19:99:262,0,261
zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz | awk '{ if ($1 == "22") { print $0 } } ' | grep 50696678 | perl -ane 'for (my $i = 9; $i <= $#F; $i++) { my @vals1 = split(/:/, $F[$i]); if ($vals1[0] =~ m/1/) { print $i, "-", $F[$i], "\t"; } } print "\n";'
33-0/1:1,2:3:26:64,0,26 54-0/1:10,1:11:2:2,0,281        75-0/1:10,1:11:3:3,0,293        82-0/1:4,3:7:79:79,0,115        94-0/1:10,1:11:2:2,0,301        100-0/1:7,8:15:99:241,0,188     105-0/1:10,21:30:99:665,0,220   117-0/1:8,3:11:74:74,0,241      188-0/1:3,1:4:20:20,0,91        216-0/1:1,1:2:27:29,0,27        220-0/1:3,6:9:66:183,0,66  234-0/1:5,7:12:99:210,0,137     235-0/1:9,8:17:99:227,0,235     260-0/1:1,3:4:23:93,0,23        265-0/1:8,10:18:99:294,0,208    304-1/1:0,1:1:3:35,3,0  313-0/1:1,4:5:17:124,0,17       318-0/1:3,1:4:23:23,0,82        323-0/1:2,4:6:51:117,0,51       349-0/1:4,4:8:99:120,0,101      354-0/1:3,3:6:74:88,0,74   361-0/1:10,5:15:99:127,0,263    388-0/1:3,2:5:58:58,0,79        393-1/1:0,5:5:15:181,15,0       399-1/1:0,11:11:33:390,33,0     414-0/1:6,3:9:80:80,0,148       417-0/1:3,4:7:73:122,0,73       423-0/1:8,5:13:99:132,0,203     430-0/1:5,2:7:49:49,0,147       435-0/1:4,3:7:87:87,0,106       448-0/1:4,6:10:99:183,0,100        451-1/1:0,2:2:6:67,6,0  460-0/1:2,3:5:49:87,0,49        514-0/1:1,2:3:24:61,0,24        515-0/1:4,1:5:19:19,0,113       544-0/1:5,5:10:99:139,0,127     554-0/1:3,5:8:70:153,0,70       568-0/1:5,23:27:50:713,0,50     570-0/1:9,8:17:99:223,0,255     589-0/1:7,5:12:99:131,0,189     590-0/1:7,4:11:99:106,0,190        592-0/1:14,13:26:99:358,0,345   594-0/1:21,20:40:99:570,0,518   599-0/1:3,6:9:64:174,0,64       616-0/1:7,6:13:99:171,0,168     622-0/1:8,3:11:64:64,0,215      631-0/1:7,5:12:99:141,0,175     632-0/1:15,6:20:99:113,0,410    633-0/1:10,10:20:99:286,0,247   662-0/1:3,2:5:47:47,0,69        687-0/1:1,3:4:20:92,0,20   691-0/1:6,2:8:48:48,0,175       738-0/1:22,15:36:99:422,0,551


R --vanilla --slave --args < /home/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.PlotArrayReads_SeqReads.wVariants.vs3.R /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/120326_HG19_SW_MM5_EZ_HX3/120326_HG19_SW_MM5_EZ.altrd.bed /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_106-124/POOL106_01RL/POOL106_01RL.preGATK.samplesMerged.rmdup.BQSR.calmd.OverlapPlot.formatted /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss.0kbWindow.plotReady /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/OutputFiles/DataProcessing.Pipeline.Utility.PlotArrayReads_SeqReads.wVariants.vs3.0kbWindow

plink --bfile /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar.justWhite.FIDIIDs --make-bed --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.pheno | grep -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.CEUCHBYRI.10PCs.covar.justWhite.FIDs > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.pheno
#Expecting 619 individuals based on plink .fam output and FIDs file -- get 619 in '...justWhite.pheno' output file

cp -p VLookUp.Python.vs1.py VLookUp.Python.vs1.vs2.py 

#Later did mv VLookUp.Python.vs1.vs2.py DataProcessing.Pipeline.PythonVLookUp.AddAnnotationsToBimFile.vs1.py 

python /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.PythonVLookUp.AddAnnotationsToBimFile.vs1.py --file1 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.txt.gz --file2 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs | awk -F, '{ if ($7 =="exonic") { print $8, "\t", $2 } }' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.SetIDFile.Exonic

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs | awk -F, '{ if ($7 =="exonic") { if (($9 == "nonsynonymous_SNV") || ($9 == "stoploss_SNV") || ($9 == "stopgain_SNV") ) { print $8, "\t", $2 } } } ' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.SetIDFile.Exonic.Nonsynonymous

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs | awk -F, '{ if ($7 =="exonic") { if (($9 == "nonsynonymous_SNV") || ($9 == "stoploss_SNV") || ($9 == "stopgain_SNV") ) { if (($11 == "P") || ($11 == "D") ) { print $8, "\t", $2 } } } } ' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.SetIDFile.Exonic.Nonsynonymous.PP2_PD

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs | awk -F, '{ if ($7 =="exonic") { if (($9 == "nonsynonymous_SNV") || ($9 == "stoploss_SNV") || ($9 == "stopgain_SNV") ) { if ($11 == "D") { print $8, "\t", $2 } } } } ' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SKATFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.SetIDFile.Exonic.Nonsynonymous.PP2_D

#Hardcoding SKAT analysis script because the tools require 'file location' as input so it seems like I'll need multiple file sets to run the code on multiple SetID sets for example

R --vanilla --slave --args < DataProcessing.Pipeline.Analysis.Skat.vs1.R

#EPACTS
#Using same 'file creation setup' instead of doing these commands within the Python script to help maintain consistency with how I'm partitioning variants into exonic, nonsynonymous, Polyphen2 categories, etc...these partitions are based on the commands I use in my CalcMeandAF.vs1.R scripts 

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs | awk -F, '{ if ($7 =="exonic") { print $0 } }' | python /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Utility.PrepareGroupFileForEPACTS.vs1.py --file1 - > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs | awk -F, '{ if ($7 =="exonic") { if (($9 == "nonsynonymous_SNV") || ($9 == "stoploss_SNV") || ($9 == "stopgain_SNV") ) { print $0 } } } ' | python /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Utility.PrepareGroupFileForEPACTS.vs1.py --file1 - > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs | awk -F, '{ if ($7 =="exonic") { if (($9 == "nonsynonymous_SNV") || ($9 == "stoploss_SNV") || ($9 == "stopgain_SNV") ) { if (($11 == "P") || ($11 == "D") ) { print $0 } } } } ' | python /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Utility.PrepareGroupFileForEPACTS.vs1.py --file1 - > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_PD

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs | awk -F, '{ if ($7 =="exonic") { if (($9 == "nonsynonymous_SNV") || ($9 == "stoploss_SNV") || ($9 == "stopgain_SNV") ) { if ($11 == "D") { print $0 } } } } ' | python /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Utility.PrepareGroupFileForEPACTS.vs1.py --file1 - > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_D

zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz | awk '{ if ($1 == "23") { $1 = "X"} print $0 } ' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip

/home/shared/software/tabix-0.2.5/bgzip /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip

/home/shared/software/tabix-0.2.5/tabix -pvcf -f /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.pheno | awk '{ print $1, "\t", $2, "\t0\t0\t0\t", $3, "\t", $4, "\t", $5, "\t", $6 } ' | sed 's/-9/NA/g' | perl -lane 'print join("\t", @F); ' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped

#Add line #FAM_ID IND_ID FAT_ID MOT_ID SEX HIVPROG HIVPROGHE AIDS AIDSEXTR to /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.pheno

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROG \
--test b.collapse \
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.EPACTS.collapse

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_PD \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROG \
--test b.collapse \
--max-maf .9 \
-min-maf .000000000000001 \
--min-callrate .01 \
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_PD.EPACTS.collapse

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROG \
--test b.madsen \
--max-maf .9 \
-min-maf .000000000000001 \
--min-callrate .01 \
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.EPACTS.madsen

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROG \
--test b.madsen \
--max-maf .9 \
-min-maf .000000000000001 \
--min-callrate .01 \
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.EPACTS.madsen

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_PD \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROG \
--test b.madsen \
--max-maf .9 \
-min-maf .000000000000001 \
--min-callrate .01 \
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_PD.EPACTS.madsen

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_D \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROG \
--test b.madsen \
--max-maf .9 \
-min-maf .000000000000001 \
--min-callrate .01 \
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_D.EPACTS.madsen

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROG \
--test b.wcnt \
--max-maf .9 \
-min-maf .000000000000001 \
--min-callrate .01 \
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.EPACTS.wcnt

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_PD \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROG \
--test b.wcnt \
--max-maf .9 \
-min-maf .000000000000001 \
--min-callrate .01 \
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_PD.EPACTS.wcnt


epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROG \
--test skat --skat-o --skat-adjust \
--max-maf .9 \
--min-callrate .01 \ 
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.EPACTS.Skat0

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROG \
--test skat --skat-o --skat-adjust \
--max-maf .9 \
-min-maf .000000000000001 \ 
--min-callrate .01 \ 
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.EPACTS.Skat0

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_PD \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROG \
--test skat --skat-o --skat-adjust \
--max-maf .9 \
-min-maf .000000000000001 \ 
--min-callrate .01 \ 
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_PD.EPACTS.Skat0

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_D \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROG \
--test skat --skat-o --skat-adjust \
--max-maf .9 \
-min-maf .000000000000001 \ 
--min-callrate .01 \ 
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_D.EPACTS.Skat0

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_PD \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROGHE \
--test b.madsen \
--max-maf .9 \
-min-maf .000000000000001 \
--min-callrate .01 \
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Pheno2.Exonic.Nonsynonymous.PP2_PD.EPACTS.madsen &

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_D \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROGHE \
--test b.madsen \
--max-maf .9 \
-min-maf .000000000000001 \
--min-callrate .01 \
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Pheno2.Exonic.Nonsynonymous.PP2_D.EPACTS.madsen &

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_PD \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno AIDS \
--test b.madsen \
--max-maf .9 \
-min-maf .000000000000001 \
--min-callrate .01 \
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Pheno3.Exonic.Nonsynonymous.PP2_PD.EPACTS.madsen &

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_D \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno AIDS \
--test b.madsen \
--max-maf .9 \
-min-maf .000000000000001 \
--min-callrate .01 \
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Pheno3.Exonic.Nonsynonymous.PP2_D.EPACTS.madsen &


epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_PD \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROGHE \
--test skat --skat-o --skat-adjust \
--max-maf .9 \
-min-maf .000000000000001 \ 
--min-callrate .01 \ 
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Pheno2.Exonic.Nonsynonymous.PP2_PD.EPACTS.Skat0 &

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_D \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno HIVPROGHE \
--test skat --skat-o --skat-adjust \
--max-maf .9 \
-min-maf .000000000000001 \ 
--min-callrate .01 \ 
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Pheno2.Exonic.Nonsynonymous.PP2_D.EPACTS.Skat0 &

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_PD \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno AIDS \
--test skat --skat-o --skat-adjust \
--max-maf .9 \
-min-maf .000000000000001 \ 
--min-callrate .01 \ 
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Pheno3.Exonic.Nonsynonymous.PP2_PD.EPACTS.Skat0 &

epacts group --vcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.bgzip.gz \
--groupf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.PP2_D \
--ped /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.EPACTSedit.ped \
--pheno AIDS \
--test skat --skat-o --skat-adjust \
--max-maf .9 \
-min-maf .000000000000001 \ 
--min-callrate .01 \ 
--run 2 \
--out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.overlapHapMap3.wHapMap3Data.justWhite.bim.wGeneIDs.GroupFile.Pheno3.Exonic.Nonsynonymous.PP2_D.EPACTS.Skat0 &

#KIAA1429
zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.vcf.gz | awk '{ if ($1 == "8") { print $0 } } ' | grep 95501065 | perl -ane 'for (my $i = 9; $i <= $#F; $i++) { my @vals1 = split(/:/, $F[$i]); if ($vals1[0] =~ m/1/) { print $i, "-", $F[$i], "\t"; } } print "\n";'

zcat /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.Exonic.txt.gz | grep KIAA1429 | awk -F, '{ if (($28 == "D") || ($28 == "P")) { print $2, "\t", $28 } }' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SpecificGenes/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.Exonic.Exonic.KIAA1429.PP2_PD.Locations

bash DataProcessing.Pipeline.Analysis.IdentifyIndividualsContainingVariants.vs1.sh 8 /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/SpecificGenes/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.Exonic.Exonic.KIAA1429.PP2_PD.Locations

95501065(D): 31-0/1:9,1:10:6:6,0,264    350-0/1:6,12:18:99:365,0,129    411-0/1:5,4:9:99:108,0,122      649-0/1:7,1:8:11:11,0,197
95508103(D): 102-0/1:11,7:18:99:175,0,337
95518785(D): 362-0/1:14,18:31:99:469,0,376
95522750(D): 715-0/1:11,12:22:99:296,0,326
95522824(D): 163-0/1:5,1:6:16:16,0,152  686-0/1:13,9:21:99:248,0,354
95530099(D): 107-0/1:5,1:6:17:17,0,160  192-0/1:6,1:7:3:3,0,178 243-0/1:13,13:26:99:377,0,379   
95531388(P): 721-0/1:3,4:7:69:110,0,69  
95531525(P): 473-0/1:10,8:18:99:221,0,273       705-0/1:9,1:10:4:4,0,278
95538947(P): 96-0/1:21,26:45:99:638,0,623       759-0/1:7,1:8:7:7,0,218 
95541400(P): 625-0/1:9,5:14:99:125,0,259        719-0/1:8,1:9:5:5,0,248 
95549374(P): 153-0/1:8,1:9:8:8,0,249    296-0/1:5,5:10:99:103,0,141     297-0/1:7,1:8:2:2,0,214 421-0/1:9,1:10:4:4,0,285
95550513(P): 92-0/1:8,5:13:99:131,0,242 296-0/1:4,1:5:9:9,0,95  683-0/1:6,1:7:13:13,0,175


vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.FID --counts --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.FID --counts --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos.FID --counts --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.FID --counts --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.FID --counts --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.FID --counts --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.FID --counts --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid &

vcftools --gzvcf /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.vcf.gz --keep /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.FID --counts --out /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow &

paste AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.frq.count | gzip > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.AllPhenos.frq.count.gz

gzip AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.frq.count 

#gunzip AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq.count.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.frq.count.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.frq.count.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.frq.count.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos.frq.count.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.frq.count.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.frq.count.gz AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.frq.count.gz

paste AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.frq.count | gzip > AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.AllPhenos.frq.AndCount.gz

gzip AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.frq.count

#gunzip AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.frq AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroNeg.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroHighlyExposedNeg.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSeroPos.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justRapidVRapid.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justSlowVSlow.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVeryRapid.frq.count AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.WhiteOnly.justVerySlow.frq.count













bash DataProcessing.Pipeline.pt6.GATK.pta.RunReduceReadsPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.SteveSubSample

bash DataProcessing.Pipeline.pt6.GATK.ptb.CreateVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.SteveSubSample

bash ../../../../DataProcessing.Pipeline.pt6.GATK.ptc.MergeVCFsAcrossChromosomes.vs1.sh

bash DataProcessing.Pipeline.pt6.GATK.ptd.RecalAndApplyVCFfilesPerChromosome.Launcher.vs1.sh /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.SteveSubSample



