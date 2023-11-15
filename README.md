# Get cumulative counts of core and shell k-mers from a pangenome

Bash script for extracting and counting core and shell k-mers in a pangenome dataset

# Usage:

get_core_and_shell_kmers_pangenome.sh <kmer_file_1> <kmer_file_2> <kmer_files_all.fofn>

# Input files:
- kmer_files: List of sorted k-mers (no counts) extracted from illumina reads. Any k-mer counting software can be used.

#NOTE: The order of the input genomes is relevant so the first two genomes compared must be specified as kmer_file_1 and kmer_file_2 followed by a "file of file names" containing the list of remaining kmer files in the desired order to compared.

# Output files:
- shared_kmers.out #List of shared (core) k-mers across the pangenome
- shell_kmers.out #List of shell k-mers across the pangenome
- shared_kmers.count.out #Cumulative counts of shared (core) k-mers as each genome is added
- shell_kmers.count.out #Cumulative counts of shell k-mers as each genome is added
