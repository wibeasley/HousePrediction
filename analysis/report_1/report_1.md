# Predicting House Sales

This report describes the rough expected sale price for a friend's house.

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of two directories.-->


<!-- Set the report-wide options, and point to the external code file. -->


<!-- Load the sources.  Suppress the output when loading sources. --> 


<!-- Load 'sourced' R files.  Suppress the output when loading packages. --> 


<!-- Load any global functions and variables declared in the R file.  Suppress the output. --> 


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 


<!-- Load the datasets.   -->


<!-- Tweak the datasets.   -->



 HouseSqFt   LandSqFt   PriceSold   PriceOrder  PriceMissing 
----------  ---------  ----------  -----------  -------------
     3,528      8,250   1,010,000            1  FALSE        
     3,160     16,936   1,018,000            2  FALSE        
     3,691      8,643   1,050,000            3  FALSE        
     3,983      8,294   1,070,000            4  FALSE        
     4,501      7,377   1,075,000            5  FALSE        
     4,242     25,142   1,075,000            6  FALSE        
     4,833      7,421   1,150,000            7  FALSE        
     4,729     33,174   1,213,050            8  FALSE        
     3,890      8,992   1,325,000            9  FALSE        
     5,311     18,857   1,400,000           10  FALSE        
     4,000     32,912   1,470,000           11  FALSE        
     4,378     23,047   1,525,000           12  FALSE        
     3,448     54,014   1,950,000           13  FALSE        
     4,215     10,563          NA           14  TRUE         

## Notes
* **Note 1**: The current report covers 14 houses.

# Marginals
![](figure_raw/marginals-1.png) ![](figure_raw/marginals-2.png) ![](figure_raw/marginals-3.png) 

# Scatterplots
![](figure_raw/scatterplots-1.png) ![](figure_raw/scatterplots-2.png) ![](figure_raw/scatterplots-3.png) 

# Models

```
============= Simple model with two main effects. =============
```

```

Call:
lm(formula = PriceSold ~ 1 + HouseSqFt + LandSqFt, data = ds)

Residuals:
    Min      1Q  Median      3Q     Max 
-282817  -45156   -6099  100655  242197 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)
(Intercept) 769884.96  373130.12   2.063  0.06602
HouseSqFt       44.53      85.89   0.518  0.61544
LandSqFt        15.54       3.74   4.155  0.00197

Residual standard error: 181500 on 10 degrees of freedom
  (1 observation deleted due to missingness)
Multiple R-squared:  0.6333,	Adjusted R-squared:  0.5599 
F-statistic: 8.633 on 2 and 10 DF,  p-value: 0.006635
```

```
     14 
1121682 
```

```
============= Simple model with two main effects and an interaction. =============
```

```

Call:
lm(formula = PriceSold ~ 1 + HouseSqFt * LandSqFt, data = ds)

Residuals:
    Min      1Q  Median      3Q     Max 
-231874 -106755    9292   53676  243938 

Coefficients:
                     Estimate Std. Error t value Pr(>|t|)
(Intercept)        -2.175e+05  6.087e+05  -0.357   0.7291
HouseSqFt           3.000e+02  1.526e+02   1.966   0.0808
LandSqFt            6.555e+01  2.610e+01   2.512   0.0332
HouseSqFt:LandSqFt -1.309e-02  6.777e-03  -1.932   0.0854

Residual standard error: 160800 on 9 degrees of freedom
  (1 observation deleted due to missingness)
Multiple R-squared:  0.7408,	Adjusted R-squared:  0.6544 
F-statistic: 8.573 on 3 and 9 DF,  p-value: 0.005277
```

```
     14 
1156586 
```

# Graphs
![](figure_raw/plots-1.png) ![](figure_raw/plots-2.png) 

# Session Information
For the sake of documentation and reproducibility, the current report was rendered on a system using the following software.


```
Report rendered by wibeasley at 2015-09-10, 00:50 -0500
```

```
R version 3.2.2 (2015-08-14)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 14.04.3 LTS

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8    LC_PAPER=en_US.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] scatterplot3d_0.3-36 ggplot2_1.0.1        RColorBrewer_1.1-2   scales_0.3.0         knitr_1.11.3        

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.0        digest_0.6.8       MASS_7.3-44        grid_3.2.2         plyr_1.8.3         gtable_0.1.2      
 [7] formatR_1.2        magrittr_1.5       evaluate_0.7.2     highr_0.5          stringi_0.5-5      reshape2_1.4.1    
[13] rmarkdown_0.8      labeling_0.3       proto_0.3-10       tools_3.2.2        stringr_1.0.0.9000 munsell_0.4.2     
[19] yaml_2.1.13        colorspace_1.2-6   htmltools_0.2.6   
```
