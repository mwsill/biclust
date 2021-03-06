\name{diagnosticPlot}
\alias{diagnosticPlot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Diagnostic F Statistics Visualization
}
\description{
Plots distributions of bootstrap replicates of F-statistics for row and column effect and highlights the observed statistics
}
\usage{
diagnosticPlot(bootstrapOutput)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{bootstrapOutput}{
 	output of \code{\link{diagnoseColRow}} function, containing bootstrap replicates and observed F-statistics
}
}

\value{
No value is returned. The plot is constructed in a current device.
}

\author{
Tatsiana KHAMIAKOVA \email{tatsiana.khamiakova@uhasselt.be}
}

\seealso{
\code{\link{diagnoseColRow}}, \code{\link{computeObservedFstat}}

}
\examples{

#---simulate dataset with 1 bicluster ---#
xmat<-matrix(rnorm(20*50,0,0.25),50,50) # background noise only 
rowSize <- 20 #number of rows in a bicluster 
colSize <- 10 #number of columns in a bicluster
a1<-rnorm(rowSize,1,0.1) #sample row effect from N(0,0.1) #adding a coherent values bicluster:
b1<-rnorm((colSize),2,0.25)  #sample column effect from N(0,0.05)
mu<-0.01 #constant value signal
 for ( i in 1 : rowSize){
 	for(j in 1: (colSize)){
 		xmat[i,j] <- xmat[i,j] + mu + a1[i] + b1[j] 	
 	}
 }
 #--obtain a bicluster by running an algorithm---# 
plaidmab <- biclust(x=xmat, method=BCPlaid(), cluster="b", fit.model = y ~ m + a+ b,  
background = TRUE, row.release = 0.6, col.release = 0.7, shuffle = 50, back.fit = 5, 
max.layers = 1, iter.startup = 100, iter.layer = 100, verbose = TRUE)

#Run bootsrap procedure:
Bootstrap <- diagnoseColRow(x=xmat, bicResult = plaidmab, number = 1, 
  nResamplings = 999, replace = TRUE)

# plotting distribution of bootstrap replicates
diagnosticPlot(bootstrapOutput = Bootstrap) 	

}
