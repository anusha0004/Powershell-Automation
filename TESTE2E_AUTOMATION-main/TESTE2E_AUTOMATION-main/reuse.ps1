
#https://www.codeproject.com/Articles/363922/Simple-build-script-using-Power-Shell

Clear-Host

Write-Host "Please make sure you do not have any instances of Visual studio running before running the script..." -ForegroundColor Red -BackgroundColor White
Write-Host "You have 10 seconds" -ForegroundColor Red -BackgroundColor White

Start-Sleep -s 2

$baseDirectory = "C:\Users\PRATHYUSHA\source\repos\tictactoe"  #"D:\Project1\Source"
$solutionFilesPath = "$baseDirectory\SolutionConfig.txt"
$projectFiles = Get-Content $solutionFilesPath 

$msbuild = "C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"
$MSBuildLogger="/flp1:Append;LogFile=Build.log;Verbosity=Normal; /flp2:LogFile=BuildErrors.log;Verbosity=Normal;errorsonly"

$devenv = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\devenv.exe"

$action = "Y"

# $env:Path = $env:Path + ";C:\Program Files\Microsoft SDKs\Windows\v7.0A"

foreach($projectFile in $projectFiles)
{
Write-Host "enterforeach"
Write-Host $projectFile.EndsWith(".sln")

    if ($projectFile.EndsWith(".sln")) 
    {

    Write-Host $projectFile 

        $projectFileAbsPath = "$baseDirectory\$projectFile"
        
        $filename = [System.IO.Path]::GetFileName($projectFile); 
        $action = "Y"  
        while($action -eq "Y") 
        {
      #Test-Path $projectFileAbsPath
            if(Test-Path $projectFileAbsPath) 
            {
                Write-Host "Building $projectFileAbsPath"
                & $msbuild $projectFileAbsPath /t:rebuild /p:PlatformTarget=x86 /fl "/flp1:logfile=$baseDirectory\msbuild.txt;Verbosity=Normal;Append;" "/flp2:logfile=$baseDirectory\errors.txt;errorsonly;Append;"
                #& $devenv $projectFileAbsPath /Rebuild
                
                if($LASTEXITCODE -eq 0)
                {
                    Write-Host "Build SUCCESS" -ForegroundColor Green
                    Clear-Host
                    break
                }
                else
                {
                    Write-Host "Build FAILED" -ForegroundColor Red
                    
                    $action = Read-Host "Enter Y to Fix then continue, N to Terminate, I to Ignore and continue the build"
                    
                    if($action -eq "Y")
                    {
                        & $devenv $projectFileAbsPath
                        wait-process -name devenv    
                    }
                    else 
                    {
                        if($action -eq "I")
                        {
                            Write-Host "Ignoring build failure..."
                            break
                        }
                        else
                        {
                            Write-Host "Terminating Build... Please restart the build once the issue is fixed." -ForegroundColor Red
                            break
                        }
                    }
                }
            }
            else
            {
                Write-Host "File does not exist : $projectFileAbsPath"
                Start-Sleep -s 5
                break
            }
        }
        
        if($action -eq "N")
        {
            break;
        }
        
    }
}