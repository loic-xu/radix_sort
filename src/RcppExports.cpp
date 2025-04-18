// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// heap_sort_Rcpp
NumericVector heap_sort_Rcpp(NumericVector v_);
RcppExport SEXP _RadixSort_heap_sort_Rcpp(SEXP v_SEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type v_(v_SEXP);
    rcpp_result_gen = Rcpp::wrap(heap_sort_Rcpp(v_));
    return rcpp_result_gen;
END_RCPP
}
// merge_sort_Rcpp
NumericVector merge_sort_Rcpp(Nullable<NumericVector> v_);
RcppExport SEXP _RadixSort_merge_sort_Rcpp(SEXP v_SEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Nullable<NumericVector> >::type v_(v_SEXP);
    rcpp_result_gen = Rcpp::wrap(merge_sort_Rcpp(v_));
    return rcpp_result_gen;
END_RCPP
}
// radix_sort_Rcpp
NumericVector radix_sort_Rcpp(NumericVector v_);
RcppExport SEXP _RadixSort_radix_sort_Rcpp(SEXP v_SEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type v_(v_SEXP);
    rcpp_result_gen = Rcpp::wrap(radix_sort_Rcpp(v_));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_RadixSort_heap_sort_Rcpp", (DL_FUNC) &_RadixSort_heap_sort_Rcpp, 1},
    {"_RadixSort_merge_sort_Rcpp", (DL_FUNC) &_RadixSort_merge_sort_Rcpp, 1},
    {"_RadixSort_radix_sort_Rcpp", (DL_FUNC) &_RadixSort_radix_sort_Rcpp, 1},
    {NULL, NULL, 0}
};

RcppExport void R_init_RadixSort(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
