	$AnalysisServiceAseanDb="ASEAN - NSR"
	
	$AnalysisServiceAsean="Azure server name"
	$dt = Get-Date -f yyyyMMdd

	
	Write-Host "Starting Backup for Asean" -ForegroundColor White
   
    Backup-ASDatabase -backupfile "backupName_$dt.abf" -name $AnalysisServiceAseanDb -server $AnalysisServiceAsean -Credential $cred -ApplyCompression -ErrorAction Stop
	
	Write-Host "Backup complete for Asean..." -ForegroundColor White
