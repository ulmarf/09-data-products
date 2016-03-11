Purpose
-------

The Shiny app was developed to find predictors for the Miles per Gallon
(mpg) consumption of automobiles. An internal function runs an
univariate regression of mpg on each predictor in the data set and
calculates a p-value indicating the significance of the association. The
final set of m predictors is taken from the m smalles p-values.

Local installation
------------------

1.  Install the package "shiny" in RStudio

2.  Download the files: ui.R, server.R, mtcars.html, topvar.R

3.  Setting your working directory in RStudio to the file download
    directory and run the Shiny app by typing the command runApp()

Running the app in the web
--------------------------

The shiny app can be run under:

<https://ulmarf.shinyapps.io/09-data-products/>

The RStudioPresentation will be found under:

<http://rpubs.com/ulmarf/160035>
