
#####################################################################################################
#####################################################################################################
#####################################################################################################
#' write out table for import into rqtl
#'
#' @description
#' \code{convert2qtl_table} will take a genotypeR object that
#' contains binary coded genotypes, and export this to a csv
#' file suitable for use with Rqtl.
#'
#' @param genotypeR_object this is a genotypeR object that has had
#' genotypes coded as binary with binary_coding
#' @param temp_cross_for_qtl name of the output file that will be output
#' into the working directory
#' @param chromosome_vect this is a vector of marker chromosome
#' the length of the markers
#' @keywords genotypeR, rqtl
#' @return table to disk for input into rqtl
#' @export
#' @examples
#' 
#' data(genotypes_data)
#' data(markers)
#' ## genotype table
#' marker_names <- make_marker_names(markers)
#' GT_table <- Ref_Alt_Table(marker_names)
#' ## remove those markers that did not work
#' genotypes_data_filtered <- genotypes_data[,c(1, 2, grep("TRUE",
#' colnames(genotypes_data)%in%GT_table$marker_names))]
#' 
#' warnings_out2NA <- initialize_genotypeR_data(seq_data = genotypes_data_filtered,
#' genotype_table = GT_table, output = "warnings2NA")
#' binary_coding_genotypes <- binary_coding(warnings_out2NA, genotype_table = GT_table)
#' chr2 <- subsetChromosome(binary_coding_genotypes, chromosome="chr2")
#' count_CO <- count_CO(chr2)
#' convert2qtl_table(count_CO, paste(temp_cross_for_qtl=getwd(),
#' "test_temp_cross.csv", sep="/"),
#' chromosome_vect=rep("2", (length(colnames(binary_genotypes(count_CO)))-2)))
#' 
#' 

convert2qtl_table <- function(genotypeR_object, temp_cross_for_qtl="temp_cross_for_qtl.csv", chromosome_vect=NULL){


###    test <- 0
###    if(test==1){
###       ##test data
###       bin <- binary_genotypes(counted_COs)
###    }

    bin <- binary_genotypes(genotypeR_object)
    
    toMatch <- c("SAMPLE_NAME", "WELL")
    numeric_binary <- apply(grep_df_subset(bin, toMatch=toMatch), 2, as.numeric)
    bin_numeric <- data.frame(bin[,toMatch], numeric_binary)
    bin.melt <- melt(bin_numeric, id.vars=c("SAMPLE_NAME", "WELL"), value.name = "binary_coding")
    ##treatments <- temperatures
    ##

    coc.data <- bin.melt
    
    ##coc.data <- coc.data[grep("chr2", coc.data$variable),]

    coc.data$binary_coding <- as.character(coc.data$binary_coding)

    ##coc.data[grep("warning", coc.data$binary_coding),"binary_coding"] <- NA

    coc.data[grep("1", as.character(coc.data$binary_coding)),"binary_coding"] <- "H"

    coc.data[grep("0", as.character(coc.data$binary_coding)),"binary_coding"] <- "A"

    coc.data[grep("2", as.character(coc.data$binary_coding)),"binary_coding"] <- "B"
    
    coc.data$binary_coding <- as.character(coc.data$binary_coding) 

    coc.bin.df <- dcast(coc.data, formula=SAMPLE_NAME+WELL~variable, value.var="binary_coding")

    rownames(coc.bin.df) <- coc.bin.df$SAMPLE_NAME

    coc.bin.df <- coc.bin.df[,-c(1,2)] 

    coc.bin.df <- rbind(colnames(coc.bin.df), chromosome_vect, coc.bin.df)

    rownames(coc.bin.df)[1:2] <- c("ID", "")

    ##rownames(coc.bin.df) <- c("ID", "", paste("ID", seq(1:(length(rownames(coc.bin.df))-2)), spe=""))

    ##colnames(coc.bin.df)[1] <- "ID"

    write.table(coc.bin.df, temp_cross_for_qtl, col.names=F, sep=",")

    ##library(xoi)

    ##cross.qtl <- read.cross("csv", ".", "temp_cross_for_qtl.csv", na.strings="NA")

    ##return(cross.qtl)

}
