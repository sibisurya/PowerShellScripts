Get-ChildItem  -Recurse -Filter *.dll | 
Foreach-Object {
    $outputpath = [System.IO.Path]::GetDirectoryName($_.FullName)
    $path = $_.FullName + ".nuspec"
    $Myasm = [System.Reflection.Assembly]::Loadfile($_.FullName)
    $content ='<?xml version="1.0"?>' + "`n" + '<package>' + "`n`t" + '<metadata>' + "`n`t`t" + '<id>' + $_.BaseName + '</id>' + "`n`t`t" + '<version>' + $Myasm.GetName().version + '</version>' + "`n`t`t" + '<authors>' + $Myasm.GetName().Name.Split('.')[0] + '</authors>' + "`n`t`t" + '<owners>' + $Myasm.GetName().Name.Split('.')[0] + '</owners>' + "`n`t`t" + '<requireLicenseAcceptance>false</requireLicenseAcceptance>' + "`n`t`t" + '<description>Nuget Package of ' + $Myasm.GetName().Name.Split('.') + '</description>' + "`n`t`t" + '<releaseNotes>Initial Release of ' + $Myasm.GetName().Name + '</releaseNotes>' + "`n`t`t" + '<copyright>Copyright 2019</copyright>' + "`n`t`t" + '<tags>' + $Myasm.GetName().Name.Split('.')[0] + ',' + $Myasm.GetName().Name.Split('.')[1] + '</tags>' + "`n`t`t" + '<dependencies></dependencies>' + "`n`t" + '</metadata>' + "`n" + '</package>'
    Set-Content -Path $path -Value $content 
    nuget pack $path 
}