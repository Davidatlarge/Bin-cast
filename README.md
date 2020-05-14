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
    1 0.6977031 29.80684 18.27234
    2 1.1374422 29.70196 18.34154
    3 1.4877293 29.53120 18.38017
    4 1.9089965 29.52193 18.40428
    5 2.0968131 29.46801 18.49492
    6 2.1911099 29.37081 18.54929

"original" dummy data plotted <img src="README_files/figure-markdown_github/plot original-1.png" style="display: block; margin: auto;" />

binning data

``` r
binned_cast <- bin_cast(x = cast, 
                        bin_depth = 10)
head(binned_cast)
```

      binned_depth     temp      sal
    1            0 29.43433 18.48745
    2           10 28.73204 19.17094
    3           20 27.90210 20.35656
    4           30 27.00409 21.23033
    5           40 26.15561 22.45508
    6           50 24.77459 24.82890

plot binned data <img src="README_files/figure-markdown_github/plot bin-1.png" style="display: block; margin: auto;" />

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
    1     0 29.80684 18.27234
    2     2 29.49497 18.44960
    3     4 29.13362 18.66780
    4     6 29.02728 18.93920
    5     8 28.80866 19.09064
    6    10 28.77319 19.21685
