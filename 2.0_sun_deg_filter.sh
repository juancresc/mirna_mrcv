set -x 
export PATH=$PATH:/home/juan/Desktop/juan/bio/sw/fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64/bin
SRNA_PATH=/home/juan/Desktop/juan/bio/mirna_mite/data/sun/degradome
cd $SRNA_PATH
for file_name in SRR1197125  SRR1197127 SRR1197126  SRR1197128
do
    gunzip -c ${file_name}.fastq.gz | fastx_clipper -Q33 -l 21 | fastx_trimmer -Q33 -l 21 | paste - - - - | sed 's/^@/>/g'| cut -f1-2 | tr '\t' '\n' > ${file_name}.trimmed.21.fasta
done

