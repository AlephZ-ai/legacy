$envOutput = bash -c "source ~/.bashrc; env"
$envOutput -split "`n" | ForEach-Object {
    if ($_ -match "([^=]+)=(.*)") {
        $name = $matches[1]
        $value = $matches[2]

        if ($name -eq "PATH") {
            $existingValue = [System.Environment]::GetEnvironmentVariable($name)

            if ($existingValue) {
                $newValue = $value -split ":"
                $existingValue = $existingValue -split ":"

                # Initialize a list to hold the unique values
                $uniqueValues = [System.Collections.Generic.List[string]]::new()

                # Merge the values maintaining order and uniqueness
                foreach ($item in ($newValue + $existingValue)) {
                    if ($item -notin $uniqueValues) {
                        $uniqueValues.Add($item)
                    }
                }

                $value = $uniqueValues -join ":"
            }
        }

        [System.Environment]::SetEnvironmentVariable($name, $value)
    }
}
