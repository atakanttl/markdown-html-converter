# markdown-html-converter

This PowerShell script converts the .md files to .html files (with pandoc) recursively in a folder and its children folders.  
The [CSS file](https://github.com/atakanttl/markdown-html-converter/blob/main/COMPANDOC.css) can be edited to change the appearance of the HTML file.

## Pre-requisites

- [pandoc](https://pandoc.org/) installed and added to path (Tested on pandoc 2.11.2)
- [PowerShell](https://github.com/PowerShell/PowerShell) (Tested on PowerShell 7.1)

## Usage

```shell
compandoc
--------------------------
Program to compile .md files to .html files inside a directory and its children.
compandoc uses 'pandoc' for compilation.

Arguments:
    make <directory>    : Compile
    clean <directory>   : Remove the compiled HTML files (*.md.html) inside the directory and its children
    help                : Show this help text
```

```shell
# Converts the .md files to .html files recursively inside the <directory>
$ compandoc.ps1 make <directory>

# Cleans the .html files by scanning the .md files inside the <directory>
$ compandoc.ps1 clean <directory>

# Shows help text
$ compandoc.ps1 help
```

compandoc can detect if it is being called from a symbolic linked file. You can make the script a symbolic link (on Windows) with:

```shell
$ New-Item -ItemType SymbolicLink -Path <FULL-PATH-TO-LINK> -Value <FULL-PATH-TO-TARGET>

# Then call it from anywhere after adding compandoc to the path
$ compandoc make <directory>
```
