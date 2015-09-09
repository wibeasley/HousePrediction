# minimal Example of External Code & External Dataset

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of two directories.-->

```
## Working directory:  D:/Users/Will/Documents/GitHub/HousePrediction/analysis/report_minimal
```

<!-- Set the report-wide options, and point to the external code file. -->

```
## Working directory:  D:/Users/Will/Documents/GitHub/HousePrediction
```

<!-- Load the sources.  Suppress the output when loading sources. --> 


<!-- Load 'sourced' R files.  Suppress the output when loading packages. --> 


<!-- Load any global functions and variables declared in the R file.  Suppress the output. --> 


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 


<!-- Load the datasets.   -->


<!-- Tweak the datasets.   -->


# Print Dataset (from Rmd chunk)

```
   HouseSqFt LandSqFt PriceSold PriceMissing
1       3528     8250   1010000        FALSE
2       3160    16936   1018000        FALSE
3       3691     8643   1050000        FALSE
4       3983     8294   1070000        FALSE
5       4501     7377   1075000        FALSE
6       4242    25142   1075000        FALSE
7       4833     7421   1150000        FALSE
8       4729    33174   1213050        FALSE
9       3890     8992   1325000        FALSE
10      5311    18857   1400000        FALSE
11      4000    32912   1470000        FALSE
12      4378    23047   1525000        FALSE
13      3448    54014   1950000        FALSE
14      4215    10563        NA         TRUE
```
## Notes

# Print Dataset (through externalization)

```
   HouseSqFt LandSqFt PriceSold PriceMissing
1       3528     8250   1010000        FALSE
2       3160    16936   1018000        FALSE
3       3691     8643   1050000        FALSE
4       3983     8294   1070000        FALSE
5       4501     7377   1075000        FALSE
6       4242    25142   1075000        FALSE
7       4833     7421   1150000        FALSE
8       4729    33174   1213050        FALSE
9       3890     8992   1325000        FALSE
10      5311    18857   1400000        FALSE
11      4000    32912   1470000        FALSE
12      4378    23047   1525000        FALSE
13      3448    54014   1950000        FALSE
14      4215    10563        NA         TRUE
```

![](report_minimal_files/figure-html/print_all-1.png) 

# Print Dataset (from Rmd text)
**Note 1**: The current report covers 14 houses.

# Session Information
For the sake of documentation and reproducibility, the current report was rendered on a system using the following software.


```
Report rendered by Will at 2015-09-09, 12:42 -0500
```

```
R version 3.2.2 Patched (2015-08-14 r69078)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252    LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                           LC_TIME=English_United States.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] knitr_1.11

loaded via a namespace (and not attached):
 [1] magrittr_1.5    formatR_1.2     tools_3.2.2     htmltools_0.2.6 yaml_2.1.13     stringi_0.5-5   rmarkdown_0.8  
 [8] stringr_1.0.0   digest_0.6.8    evaluate_0.7.2 
```
