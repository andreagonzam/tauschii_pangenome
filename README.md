# Get cumulative counts of core and shell k-mers from a pangenome

Bash script for extracting and counting core and shell k-mers in a pangenome dataset

Input files are sorted k-mers (no counts) extracted from illumina reads. Any k-mer counting software can be used.

Usage:

get_core_and_shell_kmers_pangenome.sh <kmer_file_1> <kmer_file_2> <kmer_files_all.fofn>

Output files:
- shared_kmers.out #
- shell_kmers.out
- shared_kmers.count.out
- shell_kmers.count.out
