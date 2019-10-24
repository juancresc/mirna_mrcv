set -x

export PATH=$PATH:/home/juan/Desktop/juan/bio/sw/samtools-1.2
#export PATH=$PATH:/home/juan/Desktop/juan/bio/sw/bowtie-1.0.0
export PATH=$PATH:/home/juan/Desktop/juan/bio/sw/bowtie-1.2.2-linux-x86_64
export PATH=$PATH:/home/juan/Desktop/juan/bio/sw/ViennaRNA-2.4.14/src/bin
./sw/ShortStack/ShortStack --readfile /home/juan/Desktop/juan/bio/mrcv/data/sRNASeq/21dpiR1C.trimmed.fq.gz /home/juan/Desktop/juan/bio/mrcv/data/sRNASeq/21dpiR3C.trimmed.fq.gz /home/juan/Desktop/juan/bio/mrcv/data/sRNASeq/21dpiR1T.trimmed.fq.gz /home/juan/Desktop/juan/bio/mrcv/data/sRNASeq/21dpiR3T.trimmed.fq.gz --genomefile /home/juan/Desktop/juan/bio/data/IWGSC/42/Triticum_aestivum.IWGSC.dna.toplevel.fa --outdir data/CT_SM1.2_BT1.2_V2.4


#export PATH=$PATH:/home/juan/Desktop/juan/bio/sw/samtools-1.9
#export PATH=$PATH:/home/juan/Desktop/juan/bio/sw/bowtie-1.2.2-linux-x86_64
#export PATH=$PATH:/home/juan/Desktop/juan/bio/sw/ViennaRNA-2.4.14/src/bin
#./sw/ShortStack/ShortStack --readfile /home/juan/Desktop/juan/bio/mrcv/data/sRNASeq/21dpiR1C.trimmed.fq.gz /home/juan/Desktop/juan/bio/mrcv/data/sRNASeq/21dpiR3C.trimmed.fq.gz /home/juan/Desktop/juan/bio/mrcv/data/sRNASeq/21dpiR1T.trimmed.fq.gz /home/juan/Desktop/juan/bio/mrcv/data/sRNASeq/21dpiR3T.trimmed.fq.gz --genomefile /home/juan/Desktop/juan/bio/data/IWGSC/42/Triticum_aestivum.IWGSC.dna.toplevel.fa --outdir data/CT4_SM1.9_BT1.2_V2.4


#./sw/ShortStack/ShortStack --readfile /home/juan/Desktop/juan/bio/mrcv/data/sRNASeq/21dpiR1C.trimmed.fq.gz /home/juan/Desktop/juan/bio/mrcv/data/sRNASeq/21dpiR3C.trimmed.fq.gz --genomefile /home/juan/Desktop/juan/bio/data/IWGSC/42/Triticum_aestivum.IWGSC.dna.toplevel.fa --outdir data/C --foldsize 1000
#./sw/ShortStack/ShortStack --readfile /home/juan/Desktop/juan/bio/mrcv/data/sRNASeq/21dpiR1T.trimmed.fq.gz /home/juan/Desktop/juan/bio/mrcv/data/sRNASeq/21dpiR3T.trimmed.fq.gz --genomefile /home/juan/Desktop/juan/bio/data/IWGSC/42/Triticum_aestivum.IWGSC.dna.toplevel.fa --outdir data/T --foldsize 1000


