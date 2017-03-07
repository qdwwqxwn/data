
lasty=`date -d "last year" +%Y`
thisy=`date +%Y`

for year in $lasty $thisy; do

  echo $year 
done

exit


       sdate="2018-1-31" 
       edate="2018-3-1" 


ssec=`date -d $sdate +%s`
esec=`date -d $edate +%s`

let sdif=esec-ssec

echo $sdif 

let season=95*24*3600  # seconds in a season 

echo $season

if [ $sdif -gt $season ]; then 
   echo year 
else 
   echo quaterly 
fi 

