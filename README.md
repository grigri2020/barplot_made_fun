# barplot_made_fun

The input file is under the example folder.This has been used in a manuscript. Script hasd been changed a little bit to preserve reproduction. 

What the script does:
====================
It takes a regular bar plot and inserts a white block between the bars. Its for aesthetic purpose  only. 

It can iterate through the dataframe with values 2B, 3B and 4 (which are OncoKB Levels) and then use RColorBrewer to choose the number of colors needed (ie. partition for the white spaces). It also sorts it in ascending order.
Final result looks closer to this:
<img src = example/Example_barplot.png>
