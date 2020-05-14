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

*bin\_size* = FALSE -- logical: should a column containing the bin size be attached to the output

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
    1  1.839569 29.98928 18.08924
    2  2.504805 29.93909 18.14086
    3  3.630907 29.81154 18.23834
    4  4.560465 29.78159 18.28353
    5  8.472528 29.73549 18.35619
    6 10.017403 29.62108 18.47133

<img src="README_files/figure-markdown_github/plot original-1.png" style="display: block; margin: auto;" />

binning data

``` r
binned_cast <- bin_cast(x = cast, 
                        bin_depth = 10)
head(binned_cast)
```

      binned_depth     temp      sal
    1            0 29.88037 18.18800
    2           10 29.44612 19.14264
    3           20 28.59929 21.05889
    4           30 27.80375 22.34259
    5           40 27.18193 23.54558
    6           50 25.96970 25.39162

<img src="README_files/figure-markdown_github/plot bin-1.png" style="display: block; margin: auto;" />

effects of arguments

``` r
binned_cast1 <- bin_cast(x = cast, 
                        bin_depth = 2, 
                        depth_col = "depth",
                        bin_fun = median, 
                        bin_size = TRUE)
head(binned_cast1)
```

      depth     temp      sal bin_size
    1     2 29.96419 18.11505        2
    2     4 29.79656 18.26094        2
    3     8 29.73549 18.35619        1
    4    10 29.62108 18.47133        1
    5    12 29.45970 19.19519        3
    6    14 29.17662 19.84522        2
