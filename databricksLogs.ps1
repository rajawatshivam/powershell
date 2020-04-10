#https://docs.databricks.com/dev-tools/cli/index.html
#https://docs.databricks.com/dev-tools/cli/dbfs-cli.html

$x=01
$date=17
while($date -lt 19) {
  
    while($x -lt 24){
        if($x -lt 10) {

	    dbfs cp dbfs:/mnt/logfiles/"cluster_id_here"/driver/log4j-2020-03-$date-0$x.log.gz ./logs/driver --profile "ProfileNameHere"
        $x=$x+1
        }
        else {
        dbfs cp dbfs:/mnt/logfiles/"cluster_id_here"/driver/log4j-2020-03-$date-$x.log.gz ./logs/driver --profile Shivam
        $x=$x+1
        #write-host($x)
	    #print(x)
        }
      }
 }
	