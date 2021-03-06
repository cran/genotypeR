% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zero_one_two_coding.R
\name{zero_one_two_coding}
\alias{zero_one_two_coding}
\title{Code genotypes as 0, 1, 2}
\usage{
zero_one_two_coding(genotype_warnings_passthrough, genotype_table)
}
\arguments{
\item{genotype_warnings_passthrough}{is a genotypeR object that has been processed by BC_Genotype_Warnings
with output="pass_through"}

\item{genotype_table}{is a data frame produced with Ref_Alt_Table}
}
\value{
A data frame of 0, 1, and 2 coded genotypes as a slot in the input
}
\description{
\code{zero_one_two_coding} code homozygous reference as 0, heterozygous as 1, and homozygous alternate as 2 using a genotypeR object created with \code{initialize_genotypeR_data} with the pass_through argument.
}
\examples{

data(genotypes_data)
data(markers)
## genotype table
marker_names <- make_marker_names(markers)
GT_table <- Ref_Alt_Table(marker_names)
## remove those markers that did not work
genotypes_data_filtered <- genotypes_data[,c(1, 2, grep("TRUE",
colnames(genotypes_data)\%in\%GT_table$marker_names))]

pass_through <- initialize_genotypeR_data(seq_data = genotypes_data_filtered,
genotype_table = GT_table, output = "pass_through")

genotypes_object <- zero_one_two_coding(pass_through, GT_table)

}
\keyword{0}
\keyword{1}
\keyword{2}
\keyword{Alt}
\keyword{Heterozygous,}
\keyword{Homozygous}
\keyword{Ref,}
\keyword{and}
\keyword{as}
\keyword{code}
\keyword{genotypes}
