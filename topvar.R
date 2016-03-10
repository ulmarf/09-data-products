#' Building a Model with top m features
#'
#' This function develops a prediction alogrithm based on the top m features
#' in 'x' that are most predictive of 'y'
#'
#' @param x a n x p matrix of n observations and p predictors
#' @param y a vector of length n representing the response
#' @param m number of variables
#' @return fitted model with top m features
#' @author Florian Ulmar
#' @details
#' This function runs an univariate regression of y on each predictor in x and
#' calculates a p-value indicating the significance of the association. The
#' final set of m predictors is taken from the m smalles p-values.
#' @seealso \code{lm}
#' @export
#' @importFrom stats lm

topfit <- function(x, y, m) {
    
    # x = Matrix of Predictors
    # y = Vector of responses
    
    x <- as.matrix(x)
    m <- min(m, ncol(x))

    pvalues <- toppval(x, y)
    ord <- order(pvalues) # indices from the smallest to the largest p-value
    ord <- ord[1:m]
    xm <- as.matrix(x[, ord])
    fit <- lm(y ~ xm)
    return(fit)
}

#' This function calculates the top m features
#' in 'x' that are most predictive of 'y'
#' 
#' @param x a n x p matrix of n observations and p predictors
#' @param y a vector of length n representing the response
#' @return a vector of p-values from the final fitted model
#' @author Florian Ulmar
#' @details
#' This function runs an univariate regression of y on each predictor in x and
#' calculates a p-value indicating the significance of the association. T
#' @seealso \code{lm}
#' @export
#' @importFrom stats lm

toppval <- function(x, y) {
    
    # x = Matrix of Predictors
    # y = Vector of responses
    
    x <- as.matrix(x)
    p <- ncol(x)

    pvalues <- numeric(p)
    
    for (i in seq_len(p)) {
        fit <- lm(y ~ x[,i])
        summ <- summary(fit)
        pvalues[i] <- summ$coefficients[2, 4] # p-value
    }

    return(pvalues)
}