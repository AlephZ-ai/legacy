#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
gh auth token | docker login ghcr.io -u TOKEN --password-stdin
