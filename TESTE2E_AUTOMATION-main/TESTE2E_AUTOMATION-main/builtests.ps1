#towards fial code
$result=vstest.console.exe ".\BankTests.dll"


$testDLL = ".\BankTests.dll"
$fs = New-Object -ComObject Scripting.FileSystemObject
$f = $fs.GetFile("C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\MSTest.exe")
$mstestPath = $f.shortpath   
$arguments = " /testcontainer:" + $testDLL + " /test:UnitTest1"
Invoke-Expression "$mstestPath $arguments"

