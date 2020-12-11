$help = "
compandoc
--------------------------
Program to compile .md files to .html files inside a directory and its children.
compandoc uses 'pandoc' for compilation.

Arguments:
    make <directory>    : Compile
    clean <directory>   : Remove the compiled HTML files (*.md.html) inside the directory and its children
    help                : Show this help text
"

if ($args.Length -ge 3) {
    Write-Output $help
    exit
}

$param = $args[0]

if ( ($args.Length -eq 0) -or ( ($args.Length -eq 1) -or ($param -eq "help") ) ) {
    Write-Output $help
    exit
}

$directory= $args[1]


if (-Not (Test-Path -Path $directory)) {
    Write-Output "Cannot find directory."
    exit
}

# Root directory to get the CSS file
$fileLink = (Get-Item $PSCommandPath).LinkType
if ( ($fileLink -eq "SymbolicLink") -or ($fileLink -eq "HardLink") ) {
    $rootDir = Split-Path -Parent (Get-ChildItem $PSCommandPath | Select-Object -ExpandProperty Target)
} else {
    $rootDir = $PSScriptRoot
}
    

$fullPath = Resolve-Path $directory
Push-Location $fullPath

function make {
    param ()
    Get-ChildItem -Recurse -Filter *.md | ForEach-Object {
        $newFile = $_.FullName + '.html'
        Write-Host "Compiling : " $_.Name
        pandoc -s -f markdown -t html5 -o ($newFile) $_.FullName -c $rootDir\COMPANDOC.css 
      }
}

function clean {
    param ()
    Get-ChildItem -Recurse -Filter *.md | ForEach-Object {
        Write-Host "Removing : " $_.Name + ".html"
        Remove-Item ($_.FullName + ".html") -ErrorAction SilentlyContinue
      }
}

switch ($param) {
    "make" { make }
    "clean" { clean }
    Default { Write-Output $help }
}

Pop-Location
