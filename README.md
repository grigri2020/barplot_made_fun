# barplot_made_fun

Just for fun. This can be done in various ways. The easiest is:

ggplot(g, aes(x=Level, y=Mutations, fill=Gene)) + geom_bar(stat="identity", color="white", size=2)
Just by increasing the size, you can input a white block! 

The input file is under the example folder.This has been used in a manuscript for a specific purpose. Script has been changed a little bit to preserve reproduction. 

What the script does:
====================
It takes a regular bar plot and inserts a white block between the bars. It can be done more easily by varying the size of the color parameter too! 

It can iterate through the dataframe with values 2B, 3B and 4 (which are OncoKB Levels:https://www.oncokb.org) and then use RColorBrewer to choose the number of colors needed (ie. partition for the white spaces). It also sorts it in ascending order.
Final result looks closer to this:
<img src = example/Example_barplot.png>
