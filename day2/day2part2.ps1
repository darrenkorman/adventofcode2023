# https://adventofcode.com/2023/day/2

$Content = Get-Content "input.txt"

$SumOfGamePower = 0

$Content | ForEach-Object -Process {
    Write-Host "Input=$_"

    $LineSplit = $_.Split(":")

    $GameID = $LineSplit[0].Substring("Game ".Length)
    $GameMinimum = @{"red"=0; "green"=0; "blue"=0}

    $Games = $LineSplit[1].Split(";")
    $Games | ForEach-Object -Process {
        $GrabResult = @{"red"=0; "green"=0; "blue"=0}

        $DiceGrabs = $_.Split(",")
        $DiceGrabs | ForEach-Object -Process {
            $GrabSplit = $_.Trim().Split(" ")
            $Count = $GrabSplit[0]
            $Color = $GrabSplit[1]
            $GrabResult[$Color] = $Count
        }

        Write-Host $GrabResult
        
        if ([int]$GrabResult["red"] -gt $GameMinimum["red"]) {
            Write-Host "Grab red > Min red"
            $GameMinimum["red"] = $GrabResult["red"]
        }

        if ([int]$GrabResult["green"] -gt $GameMinimum["green"]) {
            Write-Host "Grab green > Min green"
            $GameMinimum["green"] = $GrabResult["green"]
        }

        if ([int]$GrabResult["blue"] -gt $GameMinimum["blue"]) {
            Write-Host "Grab blue > Min blue"
            $GameMinimum["blue"] = $GrabResult["blue"]
        }
    }

    $GamePower = [int]$GameMinimum["red"] * [int]$GameMinimum["green"] * [int]$GameMinimum["blue"]
    Write-Host "GameID: $GameID, Minumum {Red=$($GameMinimum["red"]),Green=$($GameMinimum["green"]),Blue=$($GameMinimum["blue"])}, GamePower=$GamePower"

    $SumOfGamePower += $GamePower
}

Write-Host "Sum of GamePower=$SumOfGamePower"