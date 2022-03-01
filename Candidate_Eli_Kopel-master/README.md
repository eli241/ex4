# CytoReason - Exercise for Bioinformatics candidates

#### Skills assessed

  * Ability to dive into biology-related domain, handle potentially new data-types, perform analyses, and solve several challenges. 
  * Specifically, demonstrate the ability to: 
    a. analyze an RNA-Seq dataset and graphically present the outputs; 
    b. explain, document and organize an analysis workflow and its results; 
    c. efficiently handle data structures.   
  * Proficiency in using the R/Bioconductor eco-system; 
  * This is NOT a timed exercise, but we expect it to be doable in no more than 2 days after the Q&A session with CytoReason. 
  
#### Provided data files

  * `counts.txt.tar.gz`: gene-level raw count matrix (genes x samples).
  * `sample-annotation.txt`: sample annotation file with clinical annotation for each sample
  * Gene annotation file (gene-annotation.txt)
  
#### Setup and output structure requirements

  * The analysis should be performed in an R/Bioconductor environment.
  * You have been provided with a dedicated private GitHub repository (in the email), where you are expected to regularly commit/push your work as you progress through the exercise.
  * You should write your report in the Rmarkdown script `report.Rmd` that already exists in the repository. 
  You will perform and document all your analysis in this script and render it using the command:
  ```R
  rmarkdown::render("report.Rmd", output_dir = "results")
  ```
  * When you need to define functions, put them in the file `R/functions.R` that already exists in the repository. 
  Remember to also commit this file incrementally as you progress through the exercise.
  Functions should have some bare minimal documentation in the form of [Roxygen](https://cran.r-project.org/web/packages/roxygen2/vignettes/roxygen2.html) comments, without going crazy either: a 2-liner overview of what the function does and succint yet dedscriptive `@param` flags for arguments is enough.
  See the example function `hello_world()` already defined in the file.
  * Make sure your code includes detailed explanations/justifications and comments and feel free to add notes/suggestions on further directions or alternative analysis strategies;
  * Save your output files under sub-directory `results/` and remember to commit them too to the repository.
  * You are welcome and encouraged to use any package you deem relevant, however those should be publicly available to ensure that your analysis is reproducible (See section `setup` in the report script).
  * We recommend using the packages `edgeR` and/or `limma`. 
  Other packages/functions you may find useful for this exercise are `ggplot2`, `pheatmap` or `NMF::aheatmap`, `affy`, `ggfortify`, `ggrepel`, `glmnet`, `ROCR` 
  
----

## Instructions

1. Read and understand the exercise;
2. Get in touch with us to setup a meeting, in order to ask questions and make sure everything is clear about the exercise before you start;
3. Setup your environment (R, Git), and start working through the analysis workflow, following the output requirements listed above;
4. Make sure to contact us if you have other questions while busy with the exercise;
5. Send us an email with the final commit hash when you are done.

## Exercise -- RNA-seq differntial expression analysis

### Fictional context
A strange disease has spread across the land, many people seem to be affected in a way that is yet to be understood: when they are in daylight, odd looking marks appears on their skin that appear like burning tissue.
A drug company trying to understand this disease's mechanism of action sent data over to us.
They took normal and lesion skin biopsies from healthy and disease individuals respectively, and performed whole genome RNA-seq profiling in order to identify and understand the disease at the gene expression level.

### Analysis workflow

1. Load the data into R and make sure the count and annotation data are consistent with each other.
2. Filter the count data for lowly-expressed genes, using the strategy of your choice.
For example: only keep genes with a CPM >= 1 in at least 75% samples, in at least one of the groups. 
3. Assign the library-size normalized log-CPM data into an object from a suitable data structure/class. Save it as a binary file (.rda or .rds).
4. Generate basic plots of your choice to investigate its main properties and comment (library sizes, expression distribution densities per sample, PCA colored per group, etc.).
5. Based on the previous plots, look for the presence of outlier/mislabeled samples in this dataset. 
Try to identify and remove them from the downstream analysis. 
6. Run a differential expression analysis to find genes whose expression is different in lesion vs. normal samples. 
This can be done according to your preference either on the count data or the normalized log-CPM data, using an appropriate statistical method. 
7. Generate a volcano plot (x-axis is the effect size and y-axis is the p-value) for this analysis. 
The selected 100 most significant genes should be colored.
8. Re-write step 6. by wrapping it up into a single function that you implement -- and document:
  - arguments: the expression data, the sample annotations and the name of the group variable
  - return value: a `data.frame` of statistics of differential expression.
9. (bonus) Write a function that identifies the outlier(s) based on the expression data and group variable only.

## Pointers

  * [Installing Bioconductor](https://bioconductor.org/install/)
  * For a quick introduction to RNA-seq data in [`limma` user guide](https://bioconductor.org/packages/release/bioc/vignettes/limma/inst/doc/usersguide.pdf) - Section 15
  * Differential expression analysis: 
    - with `limma`: [`limma` user guide](https://bioconductor.org/packages/release/bioc/vignettes/limma/inst/doc/usersguide.pdf) - Section 16
    - with [DESeq2](http://kasperdanielhansen.github.io/genbioconductor/html/Count_Based_RNAseq.html)
  * `ExpressionSet` class: 
    - [Video introduction](https://www.youtube.com/watch?v=5EAOwLDD6Wo)
    - [Class description](http://kasperdanielhansen.github.io/genbioconductor/html/ExpressionSet.html)
  