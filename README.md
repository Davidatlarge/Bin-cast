Bin cast
================
David Kaiser
14 May 2020

Description
-----------

This function is intended be used to "bin" CTD casts by depth. It takes a data frame and a bin depth that specifies the output depth interval. The column of depth values can by specified by name or index, otherwise the first column will be used. If a name is supplied, the column containing the depth bins will be called by this name, if no name or an index is supplid, the column will be called "binned\_depth". A call to **aggregate()** uses this column for binning. The aggregation function can be set, it defaults to **mean()**. There's an option to output the bin size (number of values in each depth bin) with the result.

Arguments
---------

*x* -- dataframe containing the cast

*bin\_depth* -- the interval the bins should take, e.g. *0.5* would round to the nearest 0.5 \[in units of depth\]

*depth\_fun* = mean -- the function to be passed to aggregate, defaults to mean

*depth\_col* = NULL -- name or index of the column containing the depth values, if not supplied first column will be used

*bin\_size* = TRUE -- logical: should a column containing the bin size be attached to the output

Result
------

A dataframe containing the binned results

Examples
--------

dummy data:

``` r
cast <- data.frame(depth = sort(runif(100, min = 0, max = 100)),
                   temp = sort(runif(100, min = 20, max = 30), decreasing = TRUE),
                   sal = sort(runif(100, min = 18, max = 35)))
head(cast)
```

          depth     temp      sal
    1 0.0553685 29.95769 18.08900
    2 0.3512025 29.83043 18.89326
    3 1.2198783 29.63237 18.97185
    4 1.3326132 29.59212 19.00996
    5 2.3489631 29.57774 19.14497
    6 2.7440120 29.57309 19.43075

<img src="README_files/figure-markdown_github/plot original-1.png" style="display: block; margin: auto;" />

binning data

``` r
binned_cast <- bin_cast(x = cast, 
                        bin_depth = 10)
head(binned_cast)
```

      binned_depth     temp      sal
    1            0 29.56109 19.24192
    2           10 28.96220 20.29413
    3           20 28.17320 21.56559
    4           30 26.27630 25.32202
    5           40 25.03282 27.83551
    6           50 23.89911 28.83188

<img src="README_files/figure-markdown_github/plot bin-1.png" style="display: block; margin: auto;" />

effects of arguments

``` r
binned_cast1 <- bin_cast(x = cast, 
                        bin_depth = 2, 
                        depth_col = "depth",
                        bin_fun = median, 
                        bin_size = FALSE)
head(binned_cast1)
```

      depth     temp      sal
    1     0 29.89406 18.49113
    2     2 29.58493 19.07747
    3     4 29.32779 19.69047
    4     6 29.21653 20.04516
    5     8 29.10697 20.11345
    6    12 28.98615 20.22012
