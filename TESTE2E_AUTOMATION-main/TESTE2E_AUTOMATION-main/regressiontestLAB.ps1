write-Host '*****Script for building and Running test cases*****'`n -Foregroundcolor Magenta
#dependencies
 if(!(Get-InstalledModule | Where-Object {$_.Name -like "buildut*"})){
 Install-Module BuildUtils -Scope CurrentUser -Force}
 $msbuildLocation = Get-LatestMsbuildLocation
 set-alias msb $msbuildLocation


 ################BUILD STARTED#######################################

 $path="C:\Users\PRATHYUSHA\source\repos\"

msb "C:\Users\PRATHYUSHA\source\repos\tictactoe\TicTacToe.sln"| Out-File $path\failedbuil.log

$swap=0;

$log = get-content $path\failedbuil.log

foreach ($line in $log) { 
    if ($line -like "*error CS*") {
$line | out-file -FilePath "$path\failbuildmsg.log" -Append

$swap=1;

    }
}
 
                if($swap -ceq 1)
                {
                Write-Host "Build FAILED" -ForegroundColor Red

                #Invoke-Expression -Command .\Desktop\mailDelivery2.ps1 -path "C:\Users\PRATHYUSHA\source\repos\failbuildmsg.log"

                Write-Host "Sending BUILD FAILD to mail" -ForegroundColor Green

Function Global:Send-Email {
[cmdletbinding()]
Param (
[Parameter(Mandatory=$False,Position=0)]
[String]$Address = "rpoosala@seattleu.edu",
[Parameter(Mandatory=$False,Position=1)]
[String]$Subject = "TEST REPORT",
[Parameter(Mandatory=$False,Position=2)]
[String]$Body = "test"
      )
Begin {
#Clear-Host
# Add-Type -assembly "Microsoft.Office.Interop.Outlook"
    }
Process {
# Create an instance Microsoft Outlook
$Outlook = New-Object -ComObject Outlook.Application
$Mail = $Outlook.CreateItem(0)
$Mail.To = "$Address"
$Mail.Subject = $Subject

#$bodyContents=Get-Content -Path .\RAVITEJAPOOSALA.log

#$bodyContents=get-content ".\source\repos\RAVITEJAPOOSALA.log" | where {$_ -match "passed" -and "failed"} 

$bodyContents=get-content ".\source\repos\failbuildmsg.log" | where {$_ -match "error CS*"} | Format-Table -AutoSize | Out-String



$msg = new-object Net.Mail.MailMessage
$MSG.Body="===========================BUILD FAILED======================================== `n`n`n" 
$msg.body += $bodyContents
$body=$msg.body 
$Mail.Body =  $Body 
# $Mail.HTMLBody = "When is swimming?"
# $File = "D:\CP\timetable.pdf"
# $Mail.Attachments.Add($File)
$Mail.Send()
       } # End of Process section
End {
# Section to prevent error message in Outlook
Write-Host "Mail sent Successfully" -ForegroundColor Green
$Outlook.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Outlook)
$Outlook = $null
   } # End of End section!
} # End of function

# Example of using this function
Send-Email -Address rpoosala@seattleu.edu



                exit
      
                }
               
               
    else
     {
                   
       Write-Host "Build SUCCESS" -ForegroundColor Green

       
      Write-Host "Running test cases" -ForegroundColor Green


     $ErrorActionPreference="SilentlyContinue"
     Stop-Transcript | out-null
    $ErrorActionPreference = "Continue"
    $path="C:\Users\PRATHYUSHA\source\repos\$(gc env:computername).log"
    if($path)
    {
    Remove-Item $path
    Start-Transcript -path "C:\Users\PRATHYUSHA\source\repos\$(gc env:computername).log" -append
    dotnet test C:\Users\PRATHYUSHA\source\repos\tictactoe\TicTacToeTests2\bin\Debug\netcoreapp3.1\TicTacToeTests.dll  --logger:"console;verbosity=detailed"
# Do some stuff
    Stop-Transcript
     }
       Invoke-Expression -Command .\Desktop\mailDelivery2.ps1 

     }

       Write-Host "hello"

##################BUILD COMPLETED##########################################




##################CHECKING TEST CASES##########################################




##################TEST CASES CHECKED#############################################

##################mail delivery##################################################

