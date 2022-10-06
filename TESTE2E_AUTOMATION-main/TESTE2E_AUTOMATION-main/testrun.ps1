#dotnet test C:\Users\PRATHYUSHA\source\repos\tictactoe\TicTacToeTests2\bin\Debug\netcoreapp3.1\TicTacToeTests.dll 


##############################TEST CASES RUN#############################################################



cls
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




