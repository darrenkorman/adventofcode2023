# https://adventofcode.com/2023/day/3

$Content = Get-Content "input-sample.txt"
$EmptyStr = "." * $Content.Length

$InputLines = [System.Collections.Generic.List[PSObject]]::new()
$Content | ForEach-Object -Begin {
    # prefix input with empty string so the before/current/after logic will work.
    $InputLines.Add($EmptyStr)
} -Process {
    $InputLines.Add($_)
} -End { 
    # postfix input with empty string too
    $InputLines.Add($EmptyStr) 
}


for(($IPrevious = 0), ($ICurrent = 1), ($INext = 2); $INext -lt $InputLines.Count; ($IPrevious += 1), ($ICurrent += 1), ($INext += 1)){
    Write-Host "input # $($ICurrent - 1)"
    Write-Host "prev: $($InputLines[$IPrevious])"
    Write-Host "cur : $($InputLines[$ICurrent])"
    Write-Host "next: $($InputLines[$INext])"


    #"#","$","*","+"

    # Adjacent above
    # Adjacent same row
    # Adjacent below
}


