
t0="Jan 1 2016"   # starting time: 0Z
t1="Feb 28 2016"   # end time: 0Z

sec0=`date -u -d "$t0" +%s`
sec1=`date -u -d "$t1" +%s`
let days=(sec1-sec0)/86400

for day in `seq 0 $days`; do

  t1=`date -u -d "$t0 $day day"`  # for new "date" command
  ymd=`date -u -d "$t1" +%Y-%m-%d`

  /usr/bin/Rscript senti_analysis_sp500.R $ymd

done
