#!/usr/bin/env -S pwsh -nop

function Move-Html {
    <#
    .SYNOPSIS
    Move all files ending with `.html` to the ./out directory
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [switch]
        $P
    )
    begin {
        if (!(Test-Path out -PathType Container)) {
            Write-Warning "out dir not found, creating."
            New-Item -Path ./out -ItemType Directory -Verbose
        } else {
            Write-Host -ForegroundColor Cyan "found out dir, continuing."
        }
    }
    process {
    if (Test-Path . -Filter '*.html') {
        Write-Verbose "Moving html files to out dir."
        Get-ChildItem -Filter '*.html' | ForEach-Object {
            Move-Item $_ ./out -Verbose -Debug
        }
        return $true
    } else {
        Write-Warning "No html files found"
        return $null
    }
}
    end {
        Write-Debug "ended"
    }
}

Move-Html -Verbose -ErrorAction Stop