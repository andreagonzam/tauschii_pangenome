#!/bin/bash

###############################################################################
#Code for extracting and counting core and shell k-mers in a pangenome dataset
#Input files are sorted k-mers (no counts) extracted from illumina reads per sample
###############################################################################

#Usage
#get_core_and_shell_kmers_pangenome.sh <kmer_file_1> <kmer_file_2> <kmer_files_all.fofn>

#Positional arguments
#$1 = input kmer file 1
#$2 = input kmer file 2
#$3 = input file of file names (kmer_files_all.fofn)

STARTTIME=$(date +%s)

#Comparison of first two kmer files
echo "Comparing kmer sets 1 and 2"
comm -12 $1 $2 > shared_kmers.out &
comm -23 $1 $2 > unique_kmers_1.out &
comm -13 $1 $2 > unique_kmers_2.out &
wait
cat unique_kmers_1.out unique_kmers_2.out | sort > shell_kmers.sort.out
echo "Shared and shell kmers extracted"
wc -l shared_kmers.out > shared_kmers_tmp.count &
wc -l shell_kmers.sort.out > shell_kmers_tmp.count &
wait
echo "Shared and shell k-mer counts written"
echo "---------------------------------------"
rm -r unique_kmers_1.out unique_kmers_2.out

#Remaining kmer files comparisons
#initiate kmer set counter at 3
c=3
while IFS= read -r i; do
	echo "Comparing kmer set $c"
	comm -12 shared_kmers.out $i > shared_kmers_tmp.out &
	comm -13 shared_kmers.out $i > unique_kmers_tmp.out &
	comm -23 shared_kmers.out $i > shell_kmers.sort.tmp.out &
	wait
	cat unique_kmers_tmp.out shell_kmers.sort.tmp.out shell_kmers.sort.out | sort | uniq > shell_kmers.$c.sort.out
	rm shared_kmers.out shell_kmers.sort.tmp.out unique_kmers_tmp.out shell_kmers.sort.out
	mv shared_kmers_tmp.out shared_kmers.out
	mv shell_kmers.$c.sort.out shell_kmers.sort.out
	echo "Shared and shell kmers extracted"
	wc -l shared_kmers.out >> shared_kmers_tmp.count &
	wc -l shell_kmers.sort.out >> shell_kmers_tmp.count &
	wait
	echo "Shared and shell k-mer counts written"
	echo "---------------------------------------"
	((c=c+1))
done < $3

#Rename final outputs and remove intermediate files
mv shell_kmers.sort.out shell_kmers.out
cut -f1 -d " " shell_kmers_tmp.count > shell_kmers.count.out &
cut -f1 -d " " shared_kmers_tmp.count > shared_kmers.count.out &
wait
rm -r shell_kmers_tmp.count shared_kmers_tmp.count
echo "Total shared kmers written in 'shared_kmers.out'"
echo "Total shell kmers written in 'shell_kmers.out'"
echo "Total shared kmers counts written in 'shared_kmers.count.out'"
echo "Total shell kmers counts written in 'shell_kmers.count.out'"
echo "Analyses completed"
ENDTIME=$(date +%s)
echo "Runtime: $((ENDTIME - STARTTIME)) seconds"
