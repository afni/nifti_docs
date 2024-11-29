#!/bin/tcsh

set here = $PWD

set ifile = $1

set bb    = `basename $ifile .pdf`
set ofile = ${bb}.jpg

convert -resample 150 -density 300 -quality 100 $ifile $ofile
