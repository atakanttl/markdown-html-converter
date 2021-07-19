# markdown-html-converter  

This PowerShell script converts the .md files to .html files (with pandoc) recursively in a folder and its children folders.  
The [CSS file](https://github.com/atakanttl/markdown-html-converter/blob/main/COMPANDOC.css) can be edited to change the appearance of the HTML file. Original pandoc demo css file can be found [here](https://pandoc.org/demo/pandoc.css).

## Pre-requisites  

- [pandoc](https://pandoc.org/) installed and added to path (Tested on pandoc 2.11.2)
- Bash or [PowerShell](https://github.com/PowerShell/PowerShell) (Tested on PowerShell 7.1)

## Usage  

```
compandoc
--------------------------
Program to compile .md files to .html files inside a directory and its children.
compandoc uses 'pandoc' for compilation.

Arguments:
    html <directory>    : Compile to html
    clean <directory>   : Remove the compiled HTML files (*.md.html) inside the directory and its children
    help                : Show this help text

Note: You should only call the path to the file as the directory, file name excluded, as this script compiles the entire directory instead of a specific file.
```

### Bash  

```shell
# Converts the .md files to .html files recursively inside the <directory>
$ ./compandoc.sh html <directory>

# Cleans the *.md.html files by scanning the *.md files inside the <directory>
$ ./compandoc.sh clean <directory>

# Shows help text
$ ./compandoc.sh help
```

compandoc can detect if it is being called from a symbolic linked file. You can make the script a symbolic link (on Linux) with:  

```shell
$ ln -s <FULL-PATH-TO-FILE> <FULL-PATH-TO-TARGET>

# Then call it from anywhere after adding compandoc to the path
$ compandoc html <directory>
```

### Powershell  

```shell
# Converts the .md files to .html files recursively inside the <directory>
$ compandoc.ps1 html <directory>

# Cleans the *.md.html files by scanning the *.md files inside the <directory>
$ compandoc.ps1 clean <directory>

# Shows help text
$ compandoc.ps1 help
```

compandoc can detect if it is being called from a symbolic linked file. You can make the script a symbolic link (on Windows) with:

```shell
$ New-Item -ItemType SymbolicLink -Path <FULL-PATH-TO-FILE> -Value <FULL-PATH-TO-TARGET>

# Then call it from anywhere after adding compandoc to the path
$ compandoc html <directory>
```
