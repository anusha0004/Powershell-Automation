if (-Not (Get-Command -Name reportgenerator -ErrorAction SilentlyContinue))
{
    Write-Output "Instalando reportgenerator"
    Invoke-Expression "dotnet tool install --global dotnet-reportgenerator-globaltool --version 4.0.0"
}

Write-Output "Listando arquivos csproj"
$reports = [System.Collections.ArrayList]@()
Get-ChildItem -Path .\test -Recurse -Filter *.csproj -File | ForEach-Object {
    Write-Output "Executando testes para o projeto $($_.BaseName)/$($_.Name)"
    Invoke-Expression "dotnet test ./test/$($_.BaseName)/$($_.Name) /p:CollectCoverage=true /p:CoverletOutputFormat=opencover"

    $test = $reports.Add("./test/$($_.BaseName)/coverage.opencover.xml")
}

$reportsText = $reports -join ';'

Invoke-Expression "reportgenerator '-reports:$($reportsText)' '-targetdir:./report'"

Invoke-Item ./report/index.htm

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

