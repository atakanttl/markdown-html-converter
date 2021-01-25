# markdown-html-converter

This PowerShell script converts the .md files to .html files (with pandoc) recursively in a folder and its children folders.  
The [CSS file](https://github.com/atakanttl/markdown-html-converter/blob/main/COMPANDOC.css) can be edited to change the appearance of the HTML file. Original pandoc demo css file can be found [here](https://pandoc.org/demo/pandoc.css).

## Pre-requisites

- [pandoc](https://pandoc.org/) installed and added to path (Tested on pandoc 2.11.2)
- [PowerShell](https://github.com/PowerShell/PowerShell) (Tested on PowerShell 7.1)
- (Optional) [wkhtmltopdf](https://wkhtmltopdf.org/downloads.html) installed and added to path, if you want to convert markdown to pdf (Tested on wkhtmltopdf 0.12.6)

## Usage

```shell
compandoc
--------------------------
Program to compile .md files to .html files inside a directory and its children.
compandoc uses 'pandoc' for compilation.

Arguments:
    html <directory>    : Compile to html
    pdf <directory>     : Compile to pdf
    clean <directory>   : Remove the compiled HTML and PDF files (*.md.html & *.md.pdf) inside the directory and its children
    help                : Show this help text

Note: You should only call the path to the file as the directory, file name excluded, as this script compiles the entire directory instead of a specific file.
```

```shell
# Converts the .md files to .html files recursively inside the <directory>
$ compandoc.ps1 html <directory>

# Converts the .md files to .pdf files recursively inside the <directory>
$ compandoc.ps1 pdf <directory>

# Cleans the *.md.html & *.md.pdf  files by scanning the .md files inside the <directory>
$ compandoc.ps1 clean <directory>

# Shows help text
$ compandoc.ps1 help
```

compandoc can detect if it is being called from a symbolic linked file. You can make the script a symbolic link (on Windows) with:

```shell
$ New-Item -ItemType SymbolicLink -Path <FULL-PATH-TO-LINK> -Value <FULL-PATH-TO-TARGET>

# Then call it from anywhere after adding compandoc to the path
$ compandoc html <directory>
```
