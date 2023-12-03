# https://adventofcode.com/2023/day/2

$Content = Get-Content "input-sample.txt"

$SumOfGameIDs = 0

$MaxResult = @{"red"=12; "green"=13; "blue"=14}

$Content | ForEach-Object -Process {
    Write-Host $_

    $LineSplit = $_.Split(":")

    $GameID = $LineSplit[0].Substring("Game ".Length)
    Write-Host "GameID: $GameID"
    $GamePossible = $true

    $Games = $LineSplit[1].Split(";")
    $Games | ForEach-Object -Process {
        $GrabResult = @{}

        $DiceGrabs = $_.Split(",")
        $DiceGrabs | ForEach-Object -Process {
            $GrabSplit = $_.Trim().Split(" ")
            $Count = $GrabSplit[0]
            $Color = $GrabSplit[1]
            # Write-Host "Dice: $GrabSplit, $Color $Count"
            $GrabResult[$Color] = $Count
        }

        Write-Host $GrabResult
        if ($GrabResult["red"] -le $MaxResult["red"] -and $GrabResult["green"] -le $MaxResult["green"] -and $GrabResult["blue"] -le $MaxResult["blue"]) {
            Write-Host "Possible game"
        } else {
            Write-Host "Impossible Game"
            $GamePossible = $false
        }
    }

    if ($GamePossible -eq $false) {
        $SumOfGameIDs += $GameID
    }
}

Write-Host "Sum of GameIDs=$SumOfGameIDs"