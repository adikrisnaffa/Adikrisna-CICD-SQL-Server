## Introduction

This repository contains two PowerShell scripts designed to streamline the management of SQL Server databases. The first script focuses on collecting stored procedures from a local machine's database, while the second script is dedicated to transforming the document format.

## Getting Started

### Prerequisites
Before using the scripts, ensure that you have the following prerequisites installed:

[PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.4)
[SqlServer Module](https://learn.microsoft.com/en-us/sql/powershell/download-sql-server-ps-module?view=sql-server-ver16)

### Installation
1. Open a PowerShell session with administrative privileges.

2. Set the execution policy for the current process:

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force

3. Install the SqlServer module:
```
Install-Module -Name SqlServer -Force -AllowClobber -Scope CurrentUser
```
4. Load the required assemblies:
```
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.ConnectionInfo") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | Out-Null
```

### Configuration
Edit the following variables in the scripts to match your environment:

$serverInstance: SQL Server instance name.
$databaseName: Database name.
$username: SQL Server username.
$password: SQL Server password.
$outputFile: Path to the output SQL script.
Running the First Script
Execute the first script (CollectStoredProcs.ps1) to generate an ALTER script for stored procedures:
```
.\CollectStoredProcs.ps1
```
This script collects non-system stored procedures from the specified database, converts them to ALTER statements, and saves the output to the specified file.

Running the Second Script
Execute the second script (TransformDocument.ps1) to modify the generated SQL script:
```
.\TransformDocument.ps1 -FilePath "C:\path\to\your\script.sql"
```

This script adds "GO" statements before each ALTER PROCEDURE statement in the SQL script.

The modified script is saved with UTF-8 encoding.

Now you're ready to efficiently manage and modify stored procedures in your SQL Server database.