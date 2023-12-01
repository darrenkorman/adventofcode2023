$inputContent = Get-Content "input.txt"

$elementCount = 0
$sum = 0

$inputContent | ForEach-Object -Process {
    $elementCount = $elementCount + 1

    $elements = $_ -split "(.)" -ne ""

    $digits = ""

    $elements | ForEach-Object -Process {
        if($_ -in "0", "1", "2", "3", "4", "5", "6", "7", "8", "9") {
            $digits = -join ($digits, $_)
        }
    }

    $firstDigit = $digits -split "(.)" -ne "" | Select-Object -First 1
    $lastDigit = $digits -split "(.)" -ne "" | Select-Object -Last 1

    $TwoDigit = -join ($firstDigit, $lastDigit)
    $sum += $TwoDigit
    Write-Host "$elementCount : $_ => $digits => $firstDigit,$lastDigit => $TwoDigit (sum=$sum)"
}

Write-Host "sum = $sum"

