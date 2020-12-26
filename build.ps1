If (!(Test-Path .\ts)) {
    $null = New-Item -Path "$PSScriptRoot" -name "ts" -ItemType "directory"
}
Get-ChildItem .\proto -Filter *.proto | ForEach-Object -Process {
    $sourcePrefix = ".\proto\"
    protoc --go_out=. "$sourcePrefix$_"
    $prefix = ".\ts\"
    $name = $_.BaseName
    $suffix = ".ts"
    pbjs "$sourcePrefix$_" --ts "$prefix$name$suffix"
}