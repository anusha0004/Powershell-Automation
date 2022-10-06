$ProjectDir = "."
$PackagesDir = "$ProjectDir\packages"
$OutDir =   ".\TicTacToeTests2\bin\Debug\netcoreapp3.1"     #"$ProjectDir\bin\Debug"
#C:\Users\PRATHYUSHA\source\repos\tictactoe\TicTacToeTests2\bin\Debug\netcoreapp3.1\TicTacToeTests.dll


# Install NUnit Test Runner
$nuget = "$ProjectDir\.nuget\nuget.exe"
& $nuget install NUnit.Runners  -Version 2.6.2 -o $PackagesDir

# Set nunit path test runner
$nunit =  ".\packages\NUnit.org\nunit-console\nunit.engine.dll"              #"$ProjectDir\packages\NUnit.org\nunit-console\nunit-console.exe"

#Find tests in OutDir
$tests = (Get-ChildItem $OutDir -Recurse -Include *Tests.dll)

# Run tests
& $nunit /noshadow /framework:"net-4.0" /xml:"$OutDir\Tests.nunit.xml" $tests
& nunit3-console.exe 

nunit3-console.exe C:\Users\PRATHYUSHA\source\repos\tictactoe\TicTacToeTests2\bin\Debug\netcoreapp3.1\TicTacToeTests.dll

 /out:TestResult.txt

 nunit3-console.exe .\TicTacToeTests2\ProgramTests.cs


/xml:"$OutDir\Tests.nunit.xml" $tests
