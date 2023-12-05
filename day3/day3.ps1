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

$PartNumbers = @()

for(($IAbove = 0), ($ICurrent = 1), ($IBelow = 2); $IBelow -lt $InputLines.Count; ($IAbove += 1), ($ICurrent += 1), ($IBelow += 1)){
    $Above = $InputLines[$IAbove]
    $Current = $InputLines[$ICurrent]
    $Below = $InputLines[$IBelow]

    Write-Host "input # $($ICurrent - 1)"
    Write-Host "above: $Above"
    Write-Host "cur  : $Current"
    Write-Host "below: $Below"

    $NumberLength = 1
    # Find each number in current line
    for($Index = 0; $Index -lt $Current.Length; $Index += 1 ) {
        if($NumberLength -eq 1) {
            $Element = $Current[$Index]
            if($Element -in "0", "1", "2", "3", "4", "5", "6", "7", "8", "9") {
                # Start of a number, now figure out how long it is.
                Write-Host "[$Index] $Element begins a number"
                $NumberLength = 1
                while(($Index + $NumberLength) -lt $Current.Length -and $Current[($Index + $NumberLength)] -in "0", "1", "2", "3", "4", "5", "6", "7", "8", "9") {
                    Write-Host "[$Index] $($Current[($Index + $NumberLength)]) continues a number"
                    $NumberLength += 1
                }
                $Number = $Current.SubString($Index, $NumberLength)
                Write-Host "$Number is the number"

                $Lower = $Index -1
                $Upper = $Index + $NumberLength
                $AdjacentRange = $Lower..$Upper

                # Check to see if number is adjacent to a special char ex: "#","$","*","+"
                # Adjacent above
                # Adjacent current
                # Adjacent below
                $Adjacent = $false
                @($Above, $Current, $Below) | ForEach-Object -Process {
                    for($AdjIndex = 0; $AdjIndex -lt $_.Length; $AdjIndex += 1 ) {
                        $AdjElement = $_[$AdjIndex]
                        # * / @ & % - $ = # +
                        if($AdjElement -in "!","@","#","$","%","^","&","*","-","+","=","/") {
                            if ($AdjIndex -in $AdjacentRange) {
                                Write-Host "$AdjElement is adjacent from index $AdjIndex"
                                $Adjacent = $true
                            } else {
                                Write-Host "$AdjElement is NOT adjacent from index $AdjIndex"
                            }
                        }
                    }
                }

                # If Adjacent, add number to PartNumbers array
                if($Adjacent -eq $true) {
                    Write-Host "$Number was found to be adjacent"
                    $PartNumbers += @($Number)
                }
            } else {
                # Write-Host "[$Index] $Element not a number"
            }
        } else {
            Write-Host "[$Index] $($Current[$Index]) is skipped"
            $NumberLength -= 1
        }
    }
}

# Sum up the part numbers
$PartNumberSum = 0
$PartNumbers | ForEach-Object -Process {
    $PartNumberSum += [int]$_
}

# Find symbols in the input content
# $Symbols = @{}
# $Content | ForEach-Object -Process {
#     for($Index = 0; $Index -lt $_.Length; $Index += 1) {
#         if($_[$Index] -notin "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".") {
#             $Symbols[$_[$Index]] = 1
#         }
#     }
# }
# Write-Host $Symbols.Keys


Write-Host "Sum of Part Numbers=$PartNumberSum"
