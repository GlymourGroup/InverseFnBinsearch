#
# Author: Scott Zimmerman (scott.zimmerman@ucsf.edu)
# November 28, 2021
#
#Description:
#  An wrapper around cmna::bisection to do "binary search"
#  to find the inverse of monotonic functions
#
#  Parameters are the same as ecdf::bisection, plus the target value "target"
#
#  Returns the value of the function's innput that yields the functions output
#
#  Import into scripts with
#  binnsearch_fn <- dget(file.path("binsearch_fn.R"))

#Example usage:
# binnsearch_fn <- dget(file.path("binsearch_fn.R"))
# X <- rnorm(100000)
# cdf <- ecdf(X) #Empirical cdf of X - should be appx normal
# binsearch_fn(cdf,-5,5,0.975) # Should be about 1.96
function(){
  library("cmna")
  binsearch_fn <- function(f,a,b,target,tol=0.001,m=100){
    bisection(function(z){target-f(z)},a,b,tol=tol,m=m)
  }
  binsearch_fn_vectorized <- function(f,a,b,targetVector,tol=0.001,m=100){
    sapply(targetVector,
           function(y){
             binsearch_fn(f,a=a,b=b,target=y,tol=tol,m=m)
             }
    )
  }
  return(binsearch_fn_vectorized)
}





