write-Host '*****Script for building and Running test cases*****'`n -Foregroundcolor Magenta
#dependencies
 if(!(Get-InstalledModule | Where-Object {$_.Name -like "buildut*"})){
 Install-Module BuildUtils -Scope CurrentUser -Force}
 $msbuildLocation = Get-LatestMsbuildLocation
 set-alias msb $msbuildLocation


 ################BUILD STARTED#######################################
msb "C:\Users\PRATHYUSHA\source\repos\tictactoe\TicTacToe.sln"
#Invoke-MsBuild -Path "C:\Users\PRATHYUSHA\source\repos\tictactoe\TicTacToe.sln"
#dotnet.exe build "C:\Users\PRATHYUSHA\source\repos\tictactoe\TicTacToe.sln"



 
                if($LASTEXITCODE -eq 0)
                {
                    Write-Host "Build SUCCESS" -ForegroundColor Green
                    #Clear-Host
                    #break
                }
                else
                {
                    Write-Host "Build FAILED" -ForegroundColor Red
                    
                   # $action = Read-Host "Enter Y to Fix then continue, N to Terminate, I to Ignore and continue the build"
                    }


##################BUILD COMPLETED##########################################




##################CHECKING TEST CASES##########################################

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



##################TEST CASES CHECKED#############################################

##################mail delivery##################################################

Write-Host "Sending report to mail" -ForegroundColor Green

Function Global:Send-Email() {
[cmdletbinding()]
Param (
[Parameter(Mandatory=$False,Position=0)]
[String]$Address = "guido@compperf.com",
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


$bodyContents=get-content ".\source\repos\RAVITEJAPOOSALA.log" | where {$_ -match "passed" -or $_ -match "failed"} | Format-Table -AutoSize | Out-String


#where {$_ -match "passed" -and "failed"}

 
$msg = new-object Net.Mail.MailMessage
$MSG.Body="===========================BUILD SUCCESSED======================================== `n`n`n" 
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


