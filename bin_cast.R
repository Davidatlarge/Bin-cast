# function intended to bin CTD casts by depth
# by David Kaiser
# https://github.com/Davidatlarge

bin_cast <- function(x, # dataframe containing the cast
                     bin_depth, # the interval the bins should take, e.g. *0.5* would round to the nearest 0.5 [in units of depth]
                     depth_col = NULL, # name or index of the column containing the depth values, if not supplied first column will be used
                     bin_fun = mean, # the function to be passed to aggregate, defaults to mean
                     bin_size = FALSE){ # logical: should a column containing the bin size be attached to the output
  factor <- 1/bin_depth
  
  depth_index <-  if(is.null(depth_col)) { 1 } else { # if no column is supplied use first column
    if(is.numeric(depth_col)){ depth_col } else {# if column is supplied as index, use the numerical value
      as.numeric(which(colnames(x)==depth_col)) } # is column is named, find the index for the name
  }
  
  x[,depth_index] <- round(x[,depth_index] * factor)/factor
  
  binned_x <- aggregate(x[,-depth_index], # take original data without original depth column
                        by = list(binned_depth=x[,depth_index]), # aggregate by a column called binned_depth
                        bin_fun) # using the specified aggregation function
  
  if(is.character(depth_col)) { colnames(binned_x)[1] <- depth_col } # plug any supplied depth column name back in
  if(bin_size) { binned_x$bin_size <- aggregate(x[,depth_index], by = list(binned_depth = x[,depth_index]), length)[2] }
  return(binned_x)
}
