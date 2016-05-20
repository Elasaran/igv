PosFile=$1                    #PosFile contains chr Pos from variant caller result
SesFile1=$2                   #Path of Normal realigned bam file
SesFile2=$3                  #Path of Tumor realigned bam file
ImgDir=$4                    # snapshot directory of sample
Range=$5                     # to set range in IGV browser
#========================================================
# Creating batch txt file for IGV to take snapshot on given pos in Posfile
awk '{ print $1,$2,$3}' ${PosFile} | sort -t";" -k1,1 -k2,2n -u | gawk -v Sess1=$SesFile1 -v Sess2=$SesFile2 -v IMGDIR=${ImgDir} -v range=${Range} 'BEGIN{print "new \nload "Sess1"\nload "Sess2" \nsnapshotDirectory " IMGDIR}{print "goto "$1":"($2)-(1.0*range)"-"($2)+(1.0*range)"\nSetDataRange 0,40""\nsort base""\ncollapse""\nsnapshot "$1":"($2)-(1.0*range)"-"($2)+(1.0*range)"-"($3)".png"}END{print "exit \n"}'
