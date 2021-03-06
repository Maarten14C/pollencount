% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pollencount.R
\name{count}
\alias{count}
\title{Count several grains}
\usage{
count(m = 10, dat = info, mark = TRUE, cex = 2, graphics = FALSE, round = 0)
}
\arguments{
\item{m}{The number of grains to be identified}

\item{dat}{the underlying locations and names of the simulated grains}

\item{mark}{Draw a green tick mark or red cross for correctly or wrongly identified grains. Set to FALSE for no drawing}

\item{cex}{size of the tick mark or cross}

\item{graphics}{Use a fancy list (default is to use the basic one within the R terminal, but you could try tcltk)}

\item{round}{rounding of percentage, default 0 digits}
}
\value{
A list of pollen types and how many of each were identified correctly
}
\description{
Count several grains and obtain the results
}
\details{
Gives you the opportunity to interactively try and identify a number of  pollen grains.
}
