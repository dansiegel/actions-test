try {
    $artifactDirectory = 'Artifacts'
    Write-Host "Currect working directory - $artifactDirectory"
    $nupkg = Get-ChildItem -Path $artifactDirectory -Filter *.nupkg -Recurse | Select-Object -First 1

    if($null -eq $nupkg)
    {
        Throw "No NuGet Package could be found in the current directory"
    }

    Write-Host "Package Name $($nupkg.Name)"
    $nupkg.Name -match '^(.*?)\.((?:\.?[0-9]+){3,}(?:[-a-z]+)?)\.nupkg$'
    $VersionName = $Matches[2]
    $IsPreview = $VersionName -match '-pre$'
    $ReleaseDisplayName = $VersionName
    $artifacts = "$env:PIPELINE_WORKSPACE/Release"

    if($null -eq $env:IS_PREVIEW)
    {
        [System.Environment]::SetEnvironmentVariable('IsPreview',$true)
    }
    else {
        [System.Environment]::SetEnvironmentVariable('IsPreview',$false)
    }

    if($true -eq $IsPreview)
    {
        $baseVersion = $VersionName.Split('-')[0]
        $ReleaseDisplayName = "$baseVersion - Preview"
    }

    Write-Host "Version Name - $VersionName"
    Write-Host "Release Display Name - $ReleaseDisplayName"
    
    [System.Environment]::SetEnvironmentVariable('VersionName',$VersionName)
    [System.Environment]::SetEnvironmentVariable('ReleaseDisplayName',$ReleaseDisplayName)
}
catch {
    Write-Error $_
    exit 1
}