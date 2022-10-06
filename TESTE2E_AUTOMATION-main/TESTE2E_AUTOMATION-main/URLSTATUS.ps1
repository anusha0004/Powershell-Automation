$UserAlias=$env:USERNAME

$URLList = @(("https://www.youtube.com/"),
            "https://www.facebook.com/",
            "https://www.indiatoday.in/",
            "https://www.seattleu.edu/",
            "https://www.sunilxyz.edu/"
            )
         
$Result = @()

 

  Foreach($Uri in $URLList) 
 {
  $time = try{
  $request = $null
   ## Request the URI and measure how long the response took.
  $result1 = Measure-Command { $request = Invoke-WebRequest -Uri $uri -UseDefaultCredentials }
  $result1.Totalseconds

 

  } 
  catch
  {
   <# If the request generated an exception (i.e.: 500 server
   error or 404 not found), we can pull the status code from the
   Exception.Response property #>
   $request = $_.Exception.Response
   $time = -1
  }  
  $result += [PSCustomObject] @{
  Time = Get-Date;
  Uri = $uri;
  StatusCode = [int] $request.StatusCode;
  StatusDescription = $request.StatusDescription;
  ResponseLength = $request.RawContentLength;
  TimeTaken =  $time;
  }

 

}
    #Prepare email body in HTML format
if($result -ne $null)
{
    $Outputreport = "<HTML><TITLE> Website Availability Status </TITLE>
                           <BODY background-color:peachpuff>
                           <font color =""#99000"" face=""Microsoft Taile"">
                           <H2> TEST URL Health status </H2>
                           </font>
                           <Table border=1 cellpadding=0 cellspacing=0>
                           <TR bgcolor=gray align=center><TD><B>URL</B></TD><TD><B>StatusCode</B></TD><TD><B>StatusDescription</B></TD><TD><B>ResponseLength</B></TD><TD><B>TimeTaken(in sec)</B></TD</TR>"
    Foreach($Entry in $Result)
    {
        if($Entry.StatusCode -ne "200")
        {
            $Outputreport += "<TR bgcolor=red>"
        }
        else
        {
            $Outputreport += "<TR bgcolor=green>"
        }
        $Outputreport += "<TD>$($Entry.uri)</TD>
                          <TD align=center>$($Entry.StatusCode)</TD>
                          <TD align=center>$($Entry.StatusDescription)</TD>
                          <TD align=center>$($Entry.ResponseLength)</TD>
                          <TD align=center>$($Entry.timetaken)</TD></TR>"
    }
    $Outputreport += "</Table></BODY></HTML>"
}

 

Write-Host "Output html file is saved on your desktop" -ForegroundColor Green

 

$Outputreport | out-file C:\Users\$UserAlias\Desktop\SCMWebsiteHealthStatusReport.htm
Invoke-Expression C:\Users\$UserAlias\Desktop\SCMWebsiteHealthStatusReport.htm
