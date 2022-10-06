function Test-Stress 
{
    <#
    .Synopsis
        Stress testing with PowerShell
    .Description
        Test-Stress runs any PowerShell script block in parallel, which lets you stress test code.
 
        It returns the results of the script, the start time, end time, and total time to execute
    .Example
         
        Test-Stress -ScriptBlock { Get-Process } -Stress 50 |
            ForEach-Object { $_.ExecutionTime.TotalMilliseconds} |
            Measure-Object -Sum -Average -Minimum -Maximum
         
    #>
    param(
    # The script block that runs the stress test
    [ScriptBlock]
    $ScriptBlock,

    # If set, will run the stress tests as a background job
    [Switch]
    $AsJob,

    # The number of times the script block will run. By default, this is 16
    [Uint32]
    $Stress = 16
    )

    process {
$StressNumber = Get-Random
        . ([ScriptBlock]::Create("
 
workflow StressTest$StressNumber {
 
    foreach -parallel (`$n in 1..$Stress) {
        inlinescript {
            `$start = [DateTime]::Now
            `$results = . {
$ScriptBlock
}
            `$end = [DateTime]::Now
 
            New-Object PSObject -Property @{
                Script = {$ScriptBlock}
                Results = `$results
                Start = `$start
                End = `$end
                ExecutionTime = `$end - `$start
            }
         
        }
    }
}
"))
        
        $wf = gcm "stressTest$StressNumber" 
        & $wf -asjob:$AsJob

    }
} 
