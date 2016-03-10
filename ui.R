library("shiny")

source("topvar.R")

choices <- 1:ncol(mtcars)
names(choices) <- names(mtcars)

shinyUI(
    navbarPage(
        title = "Analysis of mpg", 
        
        tabPanel(
            title = "Explore",
            
            # sidebar panel
            sidebarLayout(
                
                # input panel
                sidebarPanel(
                    
                    # SelectInput widget for the selection of the variable
                    h3("Explore the dataset"),
                    selectInput(inputId = "var", "Select variable",
                                choices = choices,
                                selected = 1),
                    br(),
                    sliderInput("bins", "Select the number of BINs for histogram",
                                min = 2, max = 20, value = 10)
                    
                ),
                
                # output panel
                mainPanel(
                    tabsetPanel(
                        
                        tabPanel(p(icon("table"), "Summary"),
                                 h3("Distribution of the variable"),
                                 verbatimTextOutput("sum"),
                                 h3("Head of the variable"),
                                 verbatimTextOutput("str"),
                                 h3("Fitting of mpg vs. variable"),
                                 verbatimTextOutput("fit")
                        ),
                        
                        tabPanel(p(icon("table"), "Data"),
                                 h3("Dataset of selected variable"),
                                 tableOutput("data")
                        ),
                        
                        tabPanel(p(icon("line-chart"), "Visualize"),
                                 plotOutput("hist"),
                                 plotOutput("scat")
                        )
                    )
                )
            )
        ),
        
        tabPanel(title = "Predict",
                 
                 # Sidebar panel
                 sidebarLayout(
                     
                     # Input panel
                     sidebarPanel(
                         
                         h3("Prediction algorithm"),
                         sliderInput(inputId = "num", "Select number of variables",
                                     min = 1, max = ncol(mtcars) - 1, value = 3, step = 1)
                     ),
                     
                     # output panel
                     mainPanel(
                         tabsetPanel(
                             
                             tabPanel(p(icon("table"), "Summary"),
                                      h3("Summary for multivariate regression"),
                                      tableOutput("model")
                             ),

                             tabPanel(p(icon("table"), "p-values"),
                                      h3("p-values for univariate predictors"),
                                      tableOutput("pvalm")
                             ),

                             tabPanel(p(icon("line-chart"), "Visualize"),
                                      plotOutput("resid")
                             )
                         )
                     )
                 )
                 
        ),
        
        tabPanel(title = "About",
            
                 includeHTML("mtcars.html")
        )
        
    ))