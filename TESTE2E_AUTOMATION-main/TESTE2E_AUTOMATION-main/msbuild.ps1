#dependencies
 Install-Module BuildUtils -Scope CurrentUser -Force
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

















<#



$Logfile = "C:\Users\PRATHYUSHA\source\repos\tictactoe\$(gc env:computername).log"

dotnet test C:\Users\PRATHYUSHA\source\repos\tictactoe\TicTacToeTests2\bin\Debug\netcoreapp3.1\TicTacToeTests.dll  --logger:"console;verbosity=detailed"

Out-File $Logfile #C:\Users\PRATHYUSHA\source\repos\testresultreport.txt




Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}





#>

















<#

msb "C:\Users\PRATHYUSHA\source\repos\Bank\Bank.sln"

Install-Module -Name TrxParser  #https://www.powershellgallery.com/packages/TrxParser/2.0.1.0


Get-MsTestResult


#vstest.console.exe "C:\Users\PRATHYUSHA\source\repos\tictactoe\TicTacToeTests2\bin\Debug\netcoreapp3.1\TicTacToeTests.dll"

 #vstest.console.exe .\BankTests.dll
 
vstest.console.exe "C:\Users\PRATHYUSHA\source\repos\tictactoe\TicTacToeTests2\ProgramTests.cs"

C:\Users\PRATHYUSHA\source\repos\tictactoe\TicTacToeTests2\bin\Debug\netcoreapp3.1

#>