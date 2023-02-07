mkdir processed_files/
grep ">" Fasta.fa > processed_files/header1.txt
perl -pe 's/>//' processed_files/header1.txt > processed_files/header.txt
perl findaminoacid_acidic.pl Fasta.fa > processed_files/acidic.txt
perl findaminoacid_basic.pl Fasta.fa > processed_files/basic.txt
mkdir processed_files/acidic/
cp processed_files/acidic.txt processed_files/acidic/
mkdir processed_files/basic 
cp processed_files/basic.txt processed_files/basic/
cd processed_files/basic/
awk '{print>$1}' basic.txt 
rm basic.txt 
cd ../acidic
awk '{print>$1}' acidic.txt 
rm acidic.txt

cd ../../
python window.py > processed_files/NCPR1.txt
sed 's/(//g' processed_files/NCPR1.txt >  processed_files/NCPR2.txt
sed "s/['\"]//g" processed_files/NCPR2.txt > processed_files/NCPR3.txt
perl -pe 's/>//' processed_files/NCPR3.txt > processed_files/NCPR.txt 
awk 'BEGIN{FS=OFS=" "} {print $0, gsub(/D|E/,"",$2)}' processed_files/NCPR.txt > processed_files/DE_10.txt
awk 'BEGIN{FS=OFS=" "} {print $0, gsub(/R|H|K/,"",$2)}' processed_files/NCPR.txt > processed_files/RHK_10.txt
awk -v FS=" " -v OFS="\t" '{print $1, $2, $3,-$4}' processed_files/DE_10.txt > processed_files/new_DE_10.txt
awk -v FS=" " -v OFS="\t" '{print $1, $2, $3, $4}' processed_files/RHK_10.txt > processed_files/new_RHK_10.txt


paste processed_files/new_DE_10.txt processed_files/new_RHK_10.txt > processed_files/charge.txt
awk -v FS="\t" -v OFS="\t" '{print $1, $2, $4+$8}' processed_files/charge.txt > processed_files/sliding_window.txt

mkdir processed_files/sliding_window

cp processed_files/sliding_window.txt processed_files/sliding_window/

cd processed_files/sliding_window/

awk '{print>$1}' sliding_window.txt 

rm sliding_window.txt



for file in * ; do awk '{print NR-1 "\t" $0}'  $file > out_$file ; done

for file in out_* ; do awk -v OFS='\t' '{print $0, (1*10)+$1}' $file > final-$file; done 

mkdir blocks/

for file in final-out_* ; do awk '{if($4>=5) print $0}' $file > blocks/basic_patch_$file ; done

for file in final-out_* ; do awk '{if($4<=-5) print $0}' $file > blocks/acidic_patch_$file ; done
 
cd blocks/

for file in acidic_patch* ; do awk 'BEGIN{FS="\t";OFS="\t"} {print $1, $2, $3, $4, $5, -12}' $file > plot_$file; done

for file in basic_patch* ; do awk 'BEGIN{FS="\t";OFS="\t"} {print $1, $2, $3, $4, $5, 12}' $file > plot_$file; done

find . -empty -type f -exec bash -c "echo '0 0 0 0 0 0' >  {}" \; 



cd ../../../

mkdir output/
mkdir output/plots/
mkdir output/files/

Rscript plot.R

mv *.pdf output/plots/
cp processed_files/sliding_window/blocks/acidic_patch_final-out* output/files

cp processed_files/sliding_window/blocks/basic_patch_final-out* output/files

#rm -rf processed_files/

