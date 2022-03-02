# R functions to be placed here
# Note: do not put calls to library() in here, but rather in the "setup" chunk in the .Rmd script

#' Performs a Differential Expression Analysis and returns DF of Statistics
#'
#' @param expression_data a numeric matrix with gene-level count.
#' Every row represents a gene and every column represents a sample. 
#' @param sample_annot a data table that includes clinical annotation for 
#' each sample. Sample name: first column ; Group names: second column.
#' @param group_var_name a character vector of group name for analysis.
#' Note, the group name should be consistent with the sample annotation table.
#' 
#' @examples
#' diff_analysis(expression_data, sample_annot, c("cancer","normal"))
#' diff_analysis(expression_data, sample_annot)
#' 
diff_analysis <- function(expression_data, sample_annot, group_var_name=c("patient","normal")) {
  as.data.frame(sample_annot) -> sample_annot
  as.factor(sample_annot[,2]) -> group
  #Create a design matrix
  model.matrix(~ 0 + group) -> design
  group_var_name -> colnames(design)
  #The voom approach is more powerful in variable library sizes:
  voom(expression_data,design,plot = F) -> v
  #Fitting a linear model for each gene
  lmFit(v) -> fit
  #Paste the group variables into the function 
  astr = paste0(group_var_name[1],"-",group_var_name[2])
  prestr = "makeContrasts("
  poststr = ",levels=design)"
  commandstr = paste(prestr,astr,poststr,sep="")
  #Run "makeContrasts" function 
  eval(parse(text=commandstr)) -> cont.matrix
  contrasts.fit(fit, cont.matrix) -> fit.cont
  #Compute empirical Bayes statistics
  eBayes(fit.cont) -> fit.cont
  #Assign the outcome of each hypothesis test
  decideTests(fit.cont) -> summa.fit
  #Return DF of DE statistics
  return (as.data.frame(summary(summa.fit)))
}

#' This function identifies outlier samples. If found - returns DF of sample names.
#' Else- returns message "No outliers detected".
#'
#' @param expression_data a numeric matrix with gene-level count.
#' Every row represents a gene and every column represents a sample. 
#' @param group_variable a data table that includes clinical annotation for 
#' each sample. Sample name: first column ; Group names: second column.
#' 
#' @examples
#' find_outliers(expression_data, group_variable)
#' 
find_outliers <- function(expression_data, group_variable) {
  expression_data %>%  as.matrix() %>% t() -> pca_matrix
  # Perform a PC analysis and return the results as an object
  prcomp(pca_matrix) -> sample_pca
  # Outliers = more than 6 standard deviations away from the mean:
  apply(sample_pca$x, 2, function(x) which( abs(x - mean(x)) > (6 * sd(x)) )) %>% Reduce(union, .) -> outliers_samples
  #Check if any ouliers found
  if(!is.null(outliers_samples)){
  # Find samples name
  as.data.frame(group_variable[,1][outliers_samples]) -> outliers_sample_name
  # Return DF with outlier sample names
  return (outliers_sample_name)
  } else {
  return("No outliers detected")
  }
}