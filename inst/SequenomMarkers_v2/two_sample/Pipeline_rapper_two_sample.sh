#!/bin/sh
# Uses vcftools to compare samples
# Input the file names in an unzipped format on the command line.
# Created: April 3, 2017
# Last Updated: May 19, 2017
# Author: Magdalena Castronova
# vcftools v0.1.14+

module load vcftools

echo "Starting step one..."
vcftools --vcf $1 --diff $2 --diff-site --out Sample1_v_Sample2.out
echo "Step one complete!"
echo "Starting step two..."
if [ $3 == "gg" ]; then
    ./Finding_SNPs_two_sample.pl Sample1_v_Sample2.out.diff.sites_in_files gg
    #echo "I chose gg"
else
    if [ $3 == "sq" ]; then
	./Finding_SNPs_two_sample.pl Sample1_v_Sample2.out.diff.sites_in_files sq
	#echo "I chose sq"
	fi
fi
echo "Step two complete!"
echo "Starting step three..."
./Grandmaster_SNPs_two_sample.pl $1 $2
echo "Step three complete!"