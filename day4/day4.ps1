# https://adventofcode.com/2023/day/4

$Content = Get-Content "input.txt"
#$Content = $Content | Select-Object -First 1

$ScratchCardValue = 0

$Content | ForEach-Object -Process {
    $Input = $_

    $Input = $_.Split(":")

    $Card = $Input[1]
    
    $CardSplit = $Card.Split("|")

    $WinnersNoTrim = $CardSplit[0].Trim().Split(" ")
    $Winners = @()
    $WinnersNoTrim | ForEach-Object -Process {
        if([String]::IsNullOrWhiteSpace($_) -eq $false) {$Winners += @($_.Trim())}
    }

    $NumbersNoTrim = $CardSplit[1].Trim().Split(" ")
    $Numbers = @()
    $NumbersNoTrim | ForEach-Object -Process {
        if([String]::IsNullOrWhiteSpace($_) -eq $false) {$Numbers += @($_.Trim())}
    }

    Write-Host "Winners: $($Winners -join ","), Numbers: $($Numbers -join ",")"

    $CountOfWinners = 0
    $Numbers | ForEach-Object -Process {
        $Number = $_
        if($Number -in $Winners) {
            Write-Host "Winner! $Number"
            $CountOfWinners += 1
        }
    }

    $CardTotal = 0
    if($CountOfWinners -gt 0) {
        $CardTotal = [Math]::Pow(2,($CountOfWinners -1))
    }

    Write-Host "Card total=$CardTotal"

    $ScratchCardValue += $CardTotal
}

Write-Host "Total sum=$ScratchCardValue"
