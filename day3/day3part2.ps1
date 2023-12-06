# https://adventofcode.com/2023/day/3

$Content = Get-Content "input.txt"
$Line = $Content | Select-Object -First 1
$EmptyStr = "." * $Line.Length

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

$GearRatioSum = 0

for (($IAbove = 0), ($ICurrent = 1), ($IBelow = 2); $IBelow -lt $InputLines.Count; ($IAbove += 1), ($ICurrent += 1), ($IBelow += 1)) {
    $Above = $InputLines[$IAbove]
    $Current = $InputLines[$ICurrent]
    $Below = $InputLines[$IBelow]

    Write-Host "input # $($ICurrent - 1)"
    Write-Host "above: $Above"
    Write-Host "cur  : $Current"
    Write-Host "below: $Below"

    # Find gear in current line
    for ($GearIndex = 0; $GearIndex -lt $Current.Length; $GearIndex += 1 ) {
        $Element = $Current[$GearIndex]
        if ($Element -in "*") {
            Write-Host "[$GearIndex] $Element is a gear"

            $GearAdjacentNumbers = @()
            @($Above, $Current, $Below) | ForEach-Object -Process {
                $Line = $_
                $NumberLength = 1
                # Find each number in line
                for ($Index = 0; $Index -lt $Line.Length; $Index += 1 ) {
                    if ($NumberLength -eq 1) {
                        $Element = $Line[$Index]
                        if ($Element -in "0", "1", "2", "3", "4", "5", "6", "7", "8", "9") {
                            # Start of a number, now figure out how long it is.
                            Write-Host "[$Index] $Element begins a number"
                            $NumberLength = 1
                            while (($Index + $NumberLength) -lt $Line.Length -and $Line[($Index + $NumberLength)] -in "0", "1", "2", "3", "4", "5", "6", "7", "8", "9") {
                                Write-Host "[$Index] $($Line[($Index + $NumberLength)]) continues a number"
                                $NumberLength += 1
                            }
                            $Number = $Line.SubString($Index, $NumberLength)
                            Write-Host "$Number is the number"

                            $Lower = $Index - 1
                            $Upper = $Index + $NumberLength
                            $AdjacentRange = $Lower..$Upper

                            if($GearIndex -in $AdjacentRange) {
                                Write-Host "Gear at [$GearIndex] is adjacent to $Number"
                                $GearAdjacentNumbers += @($Number)
                            }
                        }
                        else {
                            # Write-Host "[$Index] $Element not a number"
                        }
                    }
                    else {
                        # Write-Host "[$Index] $($Line[$Index]) is skipped"
                        $NumberLength -= 1
                    }
                }
            }

            Write-Host "Found $($GearAdjacentNumbers.Count) numbers adjacent to gear $($GearAdjacentNumbers -join ",")"
            if($GearAdjacentNumbers.Count -eq 2) {
                $GearRatio = 1
                $GearAdjacentNumbers | ForEach-Object -Process {$GearRatio = $GearRatio * [int]$_}
                Write-Host "GearRatio=$GearRatio"
                $GearRatioSum += $GearRatio
            }
        }
    }
}


Write-Host "Sum of GearRatios=$GearRatioSum"
