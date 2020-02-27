library(ggplot2)
library(dplyr)
library(stringr)
library(rlist)
library(RColorBrewer)
library(wrapr)
library(glue)

#display.brewer.all()
#Arrange the dataframe first by Levels and then their descending mutations
arrange_rows<-function(df, col1, col2)
{

  new_df = df %>% arrange(col1, desc(col2)) 
  return(new_df)

}

#Collect all the Empty* values from the Gene column
collect_empty<-function(df)
{
  all_empty_values <-c()
  for(i in 1:nrow(df))
  {
    if (grepl("Empty", as.character(df[i,"Gene"]), perl=TRUE))
    {
      all_empty_values<-append(all_empty_values, as.character(df[i,"Gene"]))
      
    }
  }
  return (all_empty_values)
}


#Insert a line after every index given for a dataframe
insert_row <- function(df, new_line, index) {
  df[seq(index+1,nrow(df)+0,1),] <- df[seq(index,nrow(df)),]
  df[index,] <- new_line
  df
}

#Insert a line after every line in the dataframe
insert_line<-function(df)
{
  final<-c()
  for ( i in 1:nrow(df))
  {
    level = df[i,"Level"]
    new_line <-c(paste0("Empty",i), level, 0.1)
    n1 <-rbind(df[i,], new_line)
    final<-rbind(n1,final)
  }
  #Remove the last line
  final <- final[-nrow(final),]
  return(final)
}


assign_colors<-function(df, genelist)
{
  level_cols <-c()
  for (i  in 1:length(df))
  {
    assign_col= paste(double_quote(genelist[[i]]),"=", double_quote(df[[i]]))
    level_cols<-append(level_cols,assign_col)
  }
  #mapply(function(df, genelist){"df"=genelist })
  return(level_cols)
}




x=read.table("Actionable", sep="\t", stringsAsFactors = FALSE, header=FALSE)
x=read.table("d", sep="\t", stringsAsFactors = FALSE, header=FALSE)

colnames(x)=c("Gene", "Level", "Mutations")
new_df<-NULL
new_df = arrange_rows(x,x$Level, x$Mutations)

final_df <- insert_line(new_df)


new_df <-NULL
new_df = final_df
new_df$Gene <- factor(new_df$Gene, levels = unique(new_df$Gene))
all_empty<-collect_empty(new_df)

new_empty<-list()
new_empty<-lapply(all_empty, function(x){ 
   paste(double_quote(x),"=",double_quote("#ffffff"))
}
)

#Initialize! 
new_colors_assigned<-c()
final_all_ggplot_colors <-c()

for ( i in unique(new_df$Level))
{
  newdf<-NULL
  #Subset according to levels
  newdf <- subset(new_df, Level == i)
  gene_list <-c()
  
  "Remove each and every level from the dataframe and then
   assign different variations of the color from RColorBrewer depending
   on the number of observation for the x axis label.
  "
  for (j in 1:nrow(newdf)){
    
    if (grepl("Empty", as.character(newdf[j,"Gene"]), perl=TRUE)){}
    else{
    gene_list <-append(gene_list,(as.character(newdf[j,"Gene"])))
    }
  }
  color_name =""
  
  if (i  == "4"){
   
    color_name  ="Purples"
  }else if (i == "2B")
  {
    color_name = "Greens"
  }else if (i == "3B")
  {
    color_name = "Reds"
  }
  getPalette = colorRampPalette(brewer.pal(9, color_name))
  cols   = getPalette(length(gene_list))
  colors = assign_colors(cols, gene_list)
  #Append to the empty ones
  
  new_colors_assigned = c(new_empty,colors )
  final_all_ggplot_colors<- append(final_all_ggplot_colors, new_colors_assigned)
}

sloppy = as.character(unlist(final_all_ggplot_colors))
ggplot(new_df, aes(x=Level,y=Mutations)) + geom_bar(stat="identity", aes(fill=Gene))+
  scale_fill_manual(values = final_all_ggplot_colors))  +
    theme(panel.background = element_blank(), axis.line.x = element_line(), axis.text.y = element_blank(), axis.ticks.y=element_blank())












