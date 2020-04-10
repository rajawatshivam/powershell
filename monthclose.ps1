$MyEmail =  "Sender Name <sender's email id>"
$SMTP = "smtp server name"
$To ="SHIVAM RAJAWAT [C] <EMAIL ID HERE>","Tarun <Tarun's email id>"
$password = cat D:\Users\O46658\Desktop\shivam_automation_notebooks\pss.txt | convertto-securestring
$Creds = new-object -typename System.Management.Automation.PSCredential -argumentlist $MyEmail, $password


  $region = @{

  'Database' = 'database name'

  'ServerInstance' =  'Azure server name'

  'Username' = 'username'

  'Password' = 'password'

  'OutputSqlErrors' = $true


  'Query' = "select distinct file_load_status from t_sub_table where catalog_dttm>= convert(DATE,getdate())  and sys_id=12020"

}

 
 $dt =Get-Date -f yyyyMMddhhmmss

  
   Invoke-Sqlcmd  @region | Export-Csv -Path "D:\Users\Desktop\shivam_automation_notebooks\abc\abc$dt.csv" -Encoding ascii -NoTypeInformation -force
 
  $files = Get-ChildItem "D:\Users\Desktop\shivam_automation_notebooks\abc\*$dt.csv" | % {$_.BaseName}
	foreach ($item in $files) {  


  
 	$x2 = new-object -comobject excel.application
	$x2.visible = $true
	$userWorkbook =$x2.workbooks.open("D:\Users\Desktop\shivam_automation_notebooks\abc\$item.csv")
	
	$userWorksheet = $userWorkbook.Worksheets.Item(1)
	$userWorksheet.activate()
	

	$CHILD = $userWorksheet.Cells.Item(2,1).text
	$SECROW = $userWorksheet.Cells.Item(3,1).text

 
  if($CHILD -eq "COMPLETED" -and $SECROW -eq "")
   {  
	$f= Get-Content D:\Users\Desktop\shivam_automation_notebooks\abc\$item.csv | Measure-Object -line
	$l =$f.lines-1
	$name = $item.ToUpper().replace($dt,'')
	$Body = "Hi All,<br><br>
	Cbo files got loaded successfully.<br> 
	<br>
	Regards,<br>
	NSR CG Support" 
	$Subject="Success Notification - $name files got loaded successfully"
	Send-MailMessage -To $To -From $MyEmail -Subject $Subject -BodyAsHTML $Body -SmtpServer $SMTP -Credential $Creds -Port 25 -DeliveryNotificationOption never
	}
 else {
	$f= Get-Content D:\Usersc\Desktop\shivam_automation_notebooks\abc\$item.csv | Measure-Object -line
	$l =$f.lines-1
	$name = $item.ToUpper().replace($dt,'')
	$Body = "Hi All,<br><br>
	Please check $name files as they are not yet completed <br>
	<br>
	<br>
	Regards,<br>
	NSR CG Support" 
	$Subject="Warning - $name files still not loaded"
	Send-MailMessage -To $To -From $MyEmail -Subject $Subject -BodyAsHTML $Body -SmtpServer $SMTP -Credential $Creds -Port 25 -DeliveryNotificationOption never
  }
  }	
  Start-Sleep -s 5
	Kill -processname excel
	Remove-Item D:\Users\Desktop\shivam_automation_notebooks\abc\*.csv
	Remove-Item D:\Users\Desktop\shivam_automation_notebooks\abc\*.*
	
