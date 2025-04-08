\name{M2algorithmique-package}
\alias{M2algorithmique-package}
\alias{M2algorithmique}
\docType{package}
\title{
  A package for sorting algorithms in R with C++ implementation
}
\description{
  This package provides implementations of common sorting algorithms such as radix sort, quick sort, heap sort, and merge sort, written in C++ for efficiency.
}
\details{
  The package includes functions for sorting numeric vectors using various algorithms:
  
  \itemize{
    \item \code{\link{radix_sort_Rcpp}} - Sorts a numeric vector using the radix sort algorithm.
    \item \code{\link{quick_sort_Rcpp}} - Sorts a numeric vector using the quick sort algorithm.
    \item \code{\link{heap_sort_Rcpp}} - Sorts a numeric vector using the heap sort algorithm.
    \item \code{\link{merge_sort_Rcpp}} - Sorts a numeric vector using the merge sort algorithm.
    \item \code{\link{radix_sort}} - R wrapper function for radix sort.
    \item \code{\link{quick_sort}} - R wrapper function for quick sort.
    \item \code{\link{heap_sort}} - R wrapper function for heap sort.
    \item \code{\link{merge_sort}} - R wrapper function for merge sort.
  }
  
  These functions use C++ code to provide fast sorting, especially for large vectors.
}
\author{
  Your Name, email optional.

  Maintainer: Your Name <your@email.com>
}
\references{
  Optional references can be added here, for example:
  \itemize{
    \item Knuth, D. (1998). \emph{The Art of Computer Programming, Volume 3: Sorting and Searching}. Addison-Wesley.
  }
}
\keyword{ package }
\seealso{
  \code{\link{radix_sort_Rcpp}}, \code{\link{quick_sort_Rcpp}}, \code{\link{heap_sort_Rcpp}}, \code{\link{merge_sort_Rcpp}},
  \code{\link{radix_sort}}, \code{\link{quick_sort}}, \code{\link{heap_sort}}, \code{\link{merge_sort}}
}
\examples{
  \dontrun{
    ## Example usage of the sorting functions:
    v <- c(3, 2, 1)
    
    ## Radix sort
    print(radix_sort_Rcpp(v))  # Returns: c(1, 2, 3)
    
    ## Quick sort
    print(quick_sort_Rcpp(v))  # Returns: c(1, 2, 3)
    
    ## Heap sort
    print(heap_sort_Rcpp(v))   # Returns: c(1, 2, 3)
    
    ## Merge sort
    print(merge_sort_Rcpp(v))  # Returns: c(1, 2, 3)
    
    ## R wrapper examples:
    print(radix_sort(v))  # Returns: c(1, 2, 3)
    print(quick_sort(v))  # Returns: c(1, 2, 3)
    print(heap_sort(v))   # Returns: c(1, 2, 3)
    print(merge_sort(v))  # Returns: c(1, 2, 3)
  }
}
