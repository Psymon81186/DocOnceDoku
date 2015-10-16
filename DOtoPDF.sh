#!/bin/bash

if [ $# -eq 0 ]
  then
		echo "\e[31mBitte geben sie einen Dateinamen ein!\e[0m"
	else
		file=$1
		sudo doconce format pdflatex $file --latex_packages=ngerman,parskip,nopageno --latex_font=helvetica --latex_code_style=vrb --latex_papersize=a4 --latex_title_layout=titlepage
		echo -e "\e[32mLaTex File erstellt!\e[0m"
    filename="${file%%.*}"
    echo $filename
		filetex="$filename.tex"
		echo -e "\e[32mBeginne PDF-Erstellung\e[0m"
		pdflatex -interaction=batchmode $filetex
		echo -e "\e[32mSchritt1: pdfLatex\e[0m"
		pdflatex -interaction=batchmode $filetex
		echo -e "\e[32mSchritt2: pdfLatex\e[0m"
		pdflatex -interaction=batchmode $filetex
		echo -e "\e[32mSchritt3: makeindex\e[0m"
		makeindex $filetex
		echo -e "\e[32mSchritt4: bibtex\e[0m"
		bibtex $filetex
		echo -e "\e[32mSchritt5: pdfLatex\e[0m"
		pdflatex -interaction=batchmode $filetex
		echo -e "\e[32mPDF erstellt!\e[0m"
    rm "$filename.aux"
    rm "$filename.idx"
    rm "$filename.ilg"
    rm "$filename.ind"
    rm "$filename.out"
    rm "$filename.tex"
    rm "$filename.toc"
fi
