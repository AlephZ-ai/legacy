#!/usr/bin/env pwsh
param (
  [Parameter(Mandatory = $true)]
  [string]$rc
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Read the rc file
$content = Get-Content -Path "$rc"

# Initialize an empty hashtable to store the environment variables
$envVars = @{}

# Initialize an empty array to store the lines in order
$orderedLines = @()

# Iterate over each line in the rc file
foreach ($line in $content) {
  # Check if the line is an export statement
  if ($line -match '^export\s') {
    # Split the line into name and value
    $name, $value = $line -replace '^export\s' -split '='
    $value = $value.Trim('"')

    # Check if the environment variable is one of the specified ones
    if ($name -in 'PATH', 'MANPATH', 'CPPFLAGS', 'LDFLAGS', 'PKG_CONFIG_PATH') {
      # Define the delimiter based on the name of the environment variable
      $delimiter = if ($name -in 'CPPFLAGS', 'LDFLAGS') { ' ' } else { ':' }

      # Check if the environment variable already exists
      if ($envVars.ContainsKey($name)) {
        $splits = @($delimiter, '$')
        $fullCommonEnding = ''
        foreach ($split in $splits) {
          # Split the values by the delimiter
          $oldParts = $envVars[$name] -split ('[{0}]' -f $split)
          $newParts = $value -split ('[{0}]' -f $split)
          [System.Array]::Reverse($oldParts)
          [System.Array]::Reverse($newParts)

          # Find the longest common ending
          $commonEnding = ''
          for ($i = 0; $i -lt [Math]::Min($oldParts.Count, $newParts.Count); $i++) {
            if ($oldParts[$i] -eq $newParts[$i]) {
              $commonEnding = $split + $oldParts[$i] + $commonEnding
            }
            else {
              break
            }
          }

          # Remove the common ending from the current and new value
          $envVars[$name] = $envVars[$name].Substring(0, $envVars[$name].Length - $commonEnding.Length)
          $value = $value.Substring(0, $value.Length - $commonEnding.Length)
          $fullCommonEnding = $commonEnding + $fullCommonEnding
        }

        # Combine the values
        $envVars[$name] += "$delimiter$value$fullCommonEnding"
      }
      else {
        # Add the environment variable to the hashtable
        $envVars[$name] = $value

        # Add the line to the ordered lines array
        $orderedLines += "export $name=$value"
      }
    }
    else {
      # Add the line to the ordered lines array
      $orderedLines += $line
    }
  }
  else {
    # Add the line to the ordered lines array
    $orderedLines += $line
  }
}

# Create a new array to store the final lines
$finalLines = @()

# Iterate over the ordered lines array
foreach ($line in $orderedLines) {
  # Check if the line is an export statement
  if ($line -match '^export\s') {
    # Split the line into name and value
    $name, $value = $line -replace '^export\s' -split '='

    # Check if the environment variable is one of the specified ones
    if ($name -in 'PATH', 'MANPATH', 'CPPFLAGS', 'LDFLAGS', 'PKG_CONFIG_PATH') {
      # Replace the value with the combined value
      $line = "export $name=`"" + $envVars[$name] + "`""
    }
  }

  # Add the line to the final lines array
  $finalLines += $line
}

# Return results
return $finalLines
