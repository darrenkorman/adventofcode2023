$inputContent = Get-Content "input.txt"

$inputCount = 0
$sum = 0

$inputContent | ForEach-Object -Process {
    $inputCount += 1
    $digits = ""

    for($inputToProcess = $_; $inputToProcess.Length -gt 0; $inputToProcess = $inputToProcess.Substring(1)) {
        $firstElement = $inputToProcess.Substring(0,1).ToLower()

        if($firstElement -in "0", "1", "2", "3", "4", "5", "6", "7", "8", "9") {
            $digits = -join ($digits, $firstElement)
        }

        switch($firstElement) {
            "o" {
                if ($inputToProcess.StartsWith("one")) {
                    $digits = -join ($digits, 1)
                }
            }
            "t" {
                if ($inputToProcess.StartsWith("two")) {
                    $digits = -join ($digits, 2)
                }
                if ($inputToProcess.StartsWith("three")) {
                    $digits = -join ($digits, 3)
                }
            }
            "f" {
                if ($inputToProcess.StartsWith("four")) {
                    $digits = -join ($digits, 4)
                }
                if ($inputToProcess.StartsWith("five")) {
                    $digits = -join ($digits, 5)
                }
            }
            "s" {
                if ($inputToProcess.StartsWith("six")) {
                    $digits = -join ($digits, 6)
                }
                if ($inputToProcess.StartsWith("seven")) {
                    $digits = -join ($digits, 7)
                }
            }
            "e" {
                if ($inputToProcess.StartsWith("eight")) {
                    $digits = -join ($digits, 8)
                }
            }
            "n" {
                if ($inputToProcess.StartsWith("nine")) {
                    $digits = -join ($digits, 9)
                }
            }
            default {
                # Write-Host "Not special: $firstElement"
            }
        }
    }

    $firstDigit = $digits -split "(.)" -ne "" | Select-Object -First 1
    $lastDigit = $digits -split "(.)" -ne "" | Select-Object -Last 1

    $TwoDigit = -join ($firstDigit, $lastDigit)
    $sum += $TwoDigit
    Write-Host "$inputCount : $_ => $digits => $firstDigit,$lastDigit => $TwoDigit (sum=$sum)"
}

Write-Host "sum = $sum"

