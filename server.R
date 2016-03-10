library(shiny)

source("topvar.R")

shinyServer(function(input, output) {
    
    # reactive variables
    
    colvar <- reactive({
        colvar <- as.numeric(input$var)
    })
    
    pval <- reactive({
        toppval(x = mtcars[, 2:ncol(mtcars)],
                y = mtcars[, 1])
    })
    
    fitm <- reactive({
        topfit(x = mtcars[, 2:ncol(mtcars)],
               y = mtcars[, 1],
               m = as.numeric(input$num))
    })
    
    # output variables explore
    
    output$sum <- renderPrint({
        summary(mtcars[,colvar()])
    })

    output$str <- renderPrint({
        str(mtcars[,colvar()])
    })

    output$fit <- renderPrint({
        suppressWarnings(
            summary(lm(mtcars$mpg ~ mtcars[,colvar()]))
        )
    })
    
    output$data <- renderTable({
        mtcars[as.numeric(input$var)]
    })
    
    # output variables predict
    
    output$pvalm <- renderTable({
        data.frame(
            name = names(mtcars)[order(pval()) + 1],
            pval = pval()[order(pval())]
        )
    }, digits = 10)
    
    output$model <- renderTable({
        suppressWarnings(
            summary(fitm())
        )
    }, digits = 10)
    
    # plots
    
    output$hist <- renderPlot({
        hist(mtcars[,colvar()],
             main = "Histogram for dataset",
             col = "lightblue",
             breaks = seq(0, max(mtcars[,colvar()]), length = input$bins + 1),
             xlab = names(mtcars)[colvar()]
        )
    })
    
    output$scat <- renderPlot({
        fit <- lm(mtcars$mpg ~ mtcars[,colvar()])
        plot(x = mtcars[,colvar()], y = mtcars$mpg,
             main = paste("mpg vs.", names(mtcars)[colvar()], sep = " "),
             xlab = names(mtcars)[colvar()],
             ylab = "mpg"
        )
        lines(mtcars[,colvar()], predict(fit), lwd = 2)
        points(mtcars[,colvar()], y = mtcars$mpg,
                bg = "lightblue",
                col = "black",
                cex = 2,
                pch = 21)
    })
    
    output$resid <- renderPlot({
        index <- 1:nrow(mtcars)
        yhat <- predict(fitm())
        e <- resid(fitm())
        plot(x = index, y = e,
             main = paste("Residual vs. index"),
             bg = "lightblue",
             col = "black",
             cex = 2,
             pch = 21,
             xlab = "Index",
             ylab = "Residuals"
        )
        abline(h = 0, lwd = 2)
        for(i in 1:nrow(mtcars)) {
            lines(c(index[i], index[i]),
                  c(0, e[i]),
                  col = "red",
                  lwd = 2)
        }
        text(5, 4, paste("MLE =", signif(sqrt(sum(e ^ 2) / (length(yhat) - 2)), 3)))
    })

    })