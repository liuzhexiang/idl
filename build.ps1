If (!(Test-Path .\ts)) {
    $null = New-Item -Path "$PSScriptRoot" -name "ts" -ItemType "directory"
}
If (!(Test-Path .\js)) {
    $null = New-Item -Path "$PSScriptRoot" -name "js" -ItemType "directory"
}
Get-ChildItem .\proto -Filter *.proto | ForEach-Object -Process {
    $sourcePrefix = ".\proto\"
    protoc --go_out=. "$sourcePrefix$_"
    $prefix = ".\ts\"
    $jsPrefix = ".\js\"
    $name = $_.BaseName
    $suffix = ".ts"
    $jsSuffix = ".js"
    pbjs "$sourcePrefix$_" --ts "$prefix$name$suffix"
    pbjs "$sourcePrefix$_" --es6 "$jsPrefix$name$jsSuffix"
}