Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force

# Install the SqlServer module
Install-Module -Name SqlServer -Force -AllowClobber -Scope CurrentUser

[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.ConnectionInfo") | Out-Null

# Memuat Assembly SMO
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | Out-Null

# Menentukan informasi koneksi
$serverInstance = "....."
$databaseName = "....."
$username = "....."
$password = "....."

# Nama file output
$outputFile = "....."

# Menulis pernyataan USE
$useStatement = "USE [$databaseName]`nGO`n"
$useStatement | Out-File -Append $outputFile

# Membuat objek ServerConnection
$serverConnection = New-Object Microsoft.SqlServer.Management.Common.ServerConnection($serverInstance, $username, $password)

# Membuat Objek Server dengan menggunakan ServerConnection
$server = New-Object Microsoft.SqlServer.Management.Smo.Server($serverConnection)

# Mendapatkan Objek Database
$database = $server.Databases[$databaseName]

# Menggunakan Metode Script() untuk Stored Procedures
$storedProceduresScript = $database.StoredProcedures | Where-Object {
    # Filter stored procedures berdasarkan kriteria
    -not $_.IsSystemObject -and
    $_.Name -notlike 'sys.sp_FuzzyLookupTableMaintenance%'
} | ForEach-Object {
    try {
        # Mengganti CREATE dengan ALTER
        $script = $_.Script().Replace("CREATE PROCEDURE", "ALTER PROCEDURE")
        # Menambahkan pernyataan GO setelah setiap stored procedure
        $script += "`nGO`n"
        $script
    }
    catch {
        Write-Host "Failed to script stored procedure $($_.Name): $_"
    }
}

# Menyimpan Hasil ke File
$storedProceduresScript | Out-File -Append $outputFile

Write-Host "Stored Procedures script has been generated to: $outputFile"