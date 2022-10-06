<#
Install-Module -Name Invoke-MsBuild



$buildResult = Invoke-MsBuild -Path "C:\Users\PRATHYUSHA\source\repos\Bank\Bank.sln"

if ($buildResult.BuildSucceeded -eq $true)
{
  Write-Output ("Build completed successfully in {0:N1} seconds." -f $buildResult.BuildDuration.TotalSeconds)
}
elseif ($buildResult.BuildSucceeded -eq $false)
{
  Write-Output ("Build failed after {0:N1} seconds. Check the build log file '$($buildResult.BuildLogFilePath)' for errors." -f $buildResult.BuildDuration.TotalSeconds)
}
elseif ($null -eq $buildResult.BuildSucceeded)
{
  Write-Output "Unsure if build passed or failed: $($buildResult.Message)"
}

#>





Install-Package -Name Covreport -Source (Get-Location).Path -Destination C:\outputdirectory
Expand-Archive -Path C:\Users\PRATHYUSHA\Downloads\microsoft.codecoverage.16.9.4.zip -DestinationPath C:\Users\PRATHYUSHA\Downloads
Expand-Archive -Path C:\Users\PRATHYUSHA\Downloads\reportgenerator.zip -DestinationPath C:\Users\PRATHYUSHA\Downloads




#$testProjectPath="C:\Users\PRATHYUSHA\source\repos\Bank\BankTests\BankAccountTests.cs"

$testProjectPath="C:\Users\PRATHYUSHA\source\repos\Bank\BankTests\bin\Debug\netcoreapp3.1\BankTests.dll"

$testSettingsPath="C:\Users\PRATHYUSHA\source\repos\Bank\test.runsettings"
$testResultsFolder="C:\Users\PRATHYUSHA\source\repos\Bank\TestResults"

param(
    [Parameter(Mandatory=$true)]
    [string]$testProjectPath,
    [Parameter(Mandatory=$true)]
    [string]$testSettingsPath,
    [Parameter(Mandatory=$true)]
    [string]$testResultsFolder
)

<#
echo "Test Project Path" $testProjectPath
echo "Test Settings Path" $testSettingsPath
echo "Test Results Folder" $testResultsFolder
#>

try {

    if (-not (Test-Path $testProjectPath)) 
    {
        throw [System.IO.FileNotFoundException] "$testProjectPath not found."
    }
    if (-not (Test-Path $testSettingsPath)) 
    {
        throw [System.IO.FileNotFoundException] "$testSettingsPath not found."
    }
    if (-not (Test-Path $testResultsFolder)) 
    {
        throw [System.IO.FileNotFoundException] "$testResultsFolder not found."
    }

    dotnet test $testProjectPath --settings:$testSettingsPath 
    $recentCoverageFile = Get-ChildItem -File -Filter *.coverage -Path $testResultsFolder -Name -Recurse | Select-Object -First 1;
    write-host 'Test Completed'  -ForegroundColor Green

    C:\Users\PRATHYUSHA\Downloads\microsoft.codecoverage.16.9.4\build\netstandard1.0\CodeCoverage\CodeCoverage.exe analyze  /output:$testResultsFolder\MyTestOutput.coveragexml  $testResultsFolder'\'$recentCoverageFile
    write-host 'CoverageXML Generated'  -ForegroundColor Green

    dotnet C:\Users\PRATHYUSHA\Downloads\reportgenerator\tools\netcoreapp2.1\ReportGenerator.dll "-reports:$testResultsFolder\MyTestOutput.coveragexml" "-targetdir:$testResultsFolder\coveragereport"
    write-host 'CoverageReport Published'  -ForegroundColor Green

}
catch {

    write-host "Caught an exception:" -ForegroundColor Red
    write-host "Exception Type: $($_.Exception.GetType().FullName)" -ForegroundColor Red
    write-host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red

}