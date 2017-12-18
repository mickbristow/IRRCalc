library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Internal Rate of Return (IRR) - Calculation"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       helpText("This app calculates IRR ands compares it to value based on graphical interpolation"),
       numericInput("intial_invest", label = h6("Enter the initial investment (in $)"), value = 1000),
       numericInput("y1_amount", label = h6("Enter the year 1 cashflow (in $)"), value = 100),
       numericInput("y2_amount", label = h6("Enter the year 2 cashflow (in $)"), value = 200),
       numericInput("y3_amount", label = h6("Enter the year 3 cashflow (in $)"), value = 300),
       numericInput("y4_amount", label = h6("Enter the year 4 cashflow (in $)"), value = 400),
       numericInput("y5_amount", label = h6("Enter the year 5 cashflow (in $)"), value = 500),
       sliderInput("df1",
                   "First discount factor",
                   min = 1,
                   max = 20,
                   value = 1),
         sliderInput("df2",
                     "Second discount factor",
                     min = 1,
                     max = 20,
                     value = 20)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Calculated IRR"),
      textOutput("calc_IRR"),
      h3("Initial NPV"),
      textOutput("calc_NPV1"),
      h3("Second NPV"),
      textOutput("calc_NPV2"),
      #h3("IRR via extrapolation"),
      plotlyOutput("extrapolatelot")
      

    )
  )
))
