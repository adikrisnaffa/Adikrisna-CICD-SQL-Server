# Function to create SQL Server script with SET ANSI_NULLS ON and SET QUOTED_IDENTIFIER ON
function Create-SqlScript {
    param (
        [string]$FilePath
    )

    $sqlScript = Get-Content $FilePath -Raw

    # Add GO before each ALTER PROCEDURE statement
    $sqlScript = $sqlScript -replace '(ALTER PROCEDURE[^\r\n]+)\r?\n', "GO`r`n`$1`r`n"

    # Save the modified script
    $sqlScript | Out-File -FilePath $FilePath -Encoding UTF8
}

# Example: Provide the path to your SQL script
Create-SqlScript -FilePath "....."
