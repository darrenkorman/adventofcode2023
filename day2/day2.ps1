# https://adventofcode.com/2023/day/2

$Content = Get-Content "input.txt"

$SumOfGameIDs = 0

$MaxResult = @{"red"=12; "green"=13; "blue"=14}

$Content | ForEach-Object -Process {
    Write-Host "Input=$_"

    $LineSplit = $_.Split(":")

    $GameID = $LineSplit[0].Substring("Game ".Length)
    $GamePossible = $true

    $Games = $LineSplit[1].Split(";")
    $Games | ForEach-Object -Process {
        $GrabPossible = $true
        $GrabResult = @{"red"=0; "green"=0; "blue"=0}

        $DiceGrabs = $_.Split(",")
        $DiceGrabs | ForEach-Object -Process {
            $GrabSplit = $_.Trim().Split(" ")
            $Count = $GrabSplit[0]
            $Color = $GrabSplit[1]
            $GrabResult[$Color] = $Count
        }

        Write-Host $GrabResult
        
        if ([int]$GrabResult["red"] -gt $MaxResult["red"]) {
            $GrabPossible = $false
            Write-Host "Grab red > Max red"
        }

        if ([int]$GrabResult["green"] -gt $MaxResult["green"]) {
            $GrabPossible = $false
            Write-Host "Grab green > Max green"
        }

        if ([int]$GrabResult["blue"] -gt $MaxResult["blue"]) {
            $GrabPossible = $false
            Write-Host "Grab blue > Max blue"
        }

        if ($GrabPossible) {
            Write-Host "Possible Grab"
        } else {
            Write-Host "Impossible Grab"
            $GamePossible = $false
        }
    }

    Write-Host "GameID: $GameID, Possible=$GamePossible"

    if ($GamePossible) {
        $SumOfGameIDs += $GameID
    }
}

Write-Host "Sum of Possible GameIDs=$SumOfGameIDs"