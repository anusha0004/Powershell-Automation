
$bodyContents=get-content ".\source\repos\RAVITEJAPOOSALA.log" | where {$_ -match "passed" -and "failed"} | Format-Table -AutoSize | Out-String

if($bodyContents -ne $null)
{

$Outputreport =

"<HTML><TITLE> Website Availability Status </TITLE>
<BODY background-color:peachpuff>
<font color =""#99000"" face=""Microsoft Taile""><H2> BUILD SUCCESSED </H2></font>

<Table border=1 cellpadding=0 cellspacing=0>
<TR bgcolor=gray align=center>
<TD><B>TEST CASES PASSED</B></TD>
</TR>"

 Foreach($Entry in $bodyContents)
 {

 
        if(!($Entry -match "PASSED")){ $Outputreport += "<TR bgcolor=red>"}
        ELSE{ 
             $Outputreport += "<TR bgcolor=green>"
            }

  $Outputreport += "<TD>$($Entry)</TD></TR>" 

  } 
  $Outputreport += "</Table></BODY></HTML>"
}


Write-Host "Output html file is saved on your desktop" -ForegroundColor Green

 

$Outputreport | out-file C:\Users\$UserAlias\Desktop\SCMWebsiteHealthStatusReport.htm
Invoke-Expression C:\Users\$UserAlias\Desktop\SCMWebsiteHealthStatusReport.htm