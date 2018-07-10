#$ -V -cwd -j y -o /Users/ranum/sge_logs  -m e -M paul-ranum@uiowa.edu -q MORL,UI-HM -pe smp 10 -ckpt user 
#! /bin/bash

# STEP ONE: Load required packages
# Here i am loading samtools and bedtools into my environment.  This process may differ on your system but you will need both of them accessible in your path to execute the following commands.

module load samtools
module load bedtools

# STEP TWO: Download the chromosome sizes file for your genome
######################################################################################
# This is how you download the chromosome sizes file
#Use this one for mm10
#wget http://hgdownload-test.cse.ucsc.edu/goldenPath/mm10/bigZips/mm10.chrom.sizes

#Use this one for GRCH38
#wget http://hgdownload-test.cse.ucsc.edu/goldenPath/hg38/bigZips/hg38.chrom.sizes
######################################################################################

# STEP THREE: Now that you have the required packages loaded and the chromosome sizes file downloaded we are ready to run the script.
# Use bedtools to convert from .psl to .bed format
../../Tools/pslToBed DC_Merged.psl DC_Merged.bed

# Use bedtools to convert from .bed to .bam format
bedtools bedtobam -bed12 -i DC_Merged.bed -g mm10.chrom.sizes > DC_Merged.bam

# Use samtools to sort and index the .bam file
samtools sort DC_Merged.bam > DC_Merged_Sorted.bam

samtools index DC_Merged_Sorted.bam

mv DC_Merged_Sorted.bam.bai DC_Merged_Sorted.bai


