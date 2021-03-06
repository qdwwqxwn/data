
# Download 10-K files from EDGAR
# given a symbol. 
# first looks up CIK from local database from the symbol. 
# then search the CIK in all the master files and filter for 10-K. 
# Finally parse the 10-K data for the quaterly EarningsPerShareDiluted
# 
# 
# Usage: 
# ./extract_10-K.sh symbol

if [ $# != 1 ]; then 
  echo usage: 
  echo ./extract_10-K.sh symbol
  exit -1
fi

cdir=`dirname $0`
cd $cdir

symbol=$1
mkdir -p 10-K/$symbol

# get all symbols from database 
export MYSQL_HOME=/home/yudong 

cik=`mysql -udb -pallpublic -N <<EOF
use FA;
select cik from companies where symbol='$symbol';
EOF`

#echo symbol=$symbol  cik=$cik

files=`grep -h "^${cik}|" /data1/yudong/EDGAR/[1-2]???/QTR[1-4]/master |grep "|10-K|"  |awk -F'|' '{print $5}'`

cd 10-K/$symbol

for file in $files; do 
  local_f=`basename $file`
  #echo $local_f
  if [ ! -f $local_f ]; then 
    wget https://www.sec.gov/Archives/$file  > /dev/null 2>&1 
  else 
     :
     #echo $local_f exists. skip ... 
  fi
done
 
# Extract Quaterly EarningsPerShareDiluted

grep -h "<us-gaap:EarningsPerShareDiluted "  *.txt |grep -v "eol_" | while read line; do 
  period=`echo $line |grep -Po  "contextRef=\".*?\"" |sed -e 's/contextRef=//' -e 's/"//g'`
  earning=`echo $line |grep -Po  ">.*?<" |sed -e 's/<//' -e 's/>//'` 
  # normalize period. Formats seen: 
  #  D2011Q4, FD2012Q2QTD, Duration_2_1_2009_To_1_30_2010
  # change Q1 to -3-31, Q2 to -6-30, Q3 to -9-30, and Q4 to -12-31. 

  ymd=`echo $period |grep -v "YTD" | grep -Po "[1-2][0-9][0-9][0-9]Q[1-4]" | \
       sed -e 's/Q1/-3-31/' -e 's/Q2/-6-30/' -e 's/Q3/-9-30/' -e 's/Q4/-12-31/'`
  if [ "$ymd" == "" ]; then  # dealing with Duration_2_1_2009_To_1_30_2010
     if [[ $period =~ ^Duration ]]; then 
       sdate=`echo $period |awk -F_ -vOFS='-' '{print $4, $2, $3}'` 
       edate=`echo $period |awk -F_ -vOFS='-' '{print $8, $6, $7}'` 

       ssec=`date -d $sdate +%s`
       esec=`date -d $edate +%s`

       let sdif=esec-ssec
       let season=95*24*3600  # seconds in a season

       if [ $sdif -lt $season ]; then
          echo $edate, $earning
       else  
          echo skipping $period >&2 
       fi

     else 
       echo Unrecognized pattern: $period  >&2 
     fi
  else 
    echo $ymd, $earning 
  fi

done






