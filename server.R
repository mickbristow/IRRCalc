library(shiny)
library(FinancialMath)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
   vals <- reactiveValues()
   observe({
     investment <- (input$intial_invest * -1)
     y1 <- input$y1_amount
     y2 <- input$y2_amount
     y3 <- input$y3_amount
     y4 <- input$y4_amount
     y5 <- input$y5_amount
     df1 <- (input$df1 / 100)
     df2 <- (input$df2 / 100)
     
     
    
    calIRR <- IRR(cf0=investment,cf=c(y1,y2,y3,y4,y5),times=c(1,2,3,4,5))
    calIRR <- round(calIRR *100, 2)
    output$calc_IRR <- renderText({paste("Calculated IRR = ", calIRR, '%')
    })
    
    npv1 <- NPV(cf0=investment,cf=c(y1,y2,y3,y4,y5),times=c(1,2,3,4,5),df1)
    npv1 <- round(npv1, 2)
    output$calc_NPV1 <- renderText({paste("Calculated NPV = ", npv1)
    })
    
    npv2 <- NPV(cf0=investment,cf=c(y1,y2,y3,y4,y5),times=c(1,2,3,4,5),df2)
    npv2 <- round(npv2, 2)
    output$calc_NPV2 <- renderText({paste("Calculated NPV = ", npv2)
    })
  
    
    df <- data.frame(c(df1 * 100,df2 * 100),c(npv1,npv2))
    colnames(df) <- c("x","y")
    
    a <- list(
      x = calIRR,
      y = 0,
      text = "Calculated IRR",
      xref = "x",
      yref = "y",
      showarrow = TRUE,
      arrowhead = 7,
      ax = 40,
      ay = -40
    )
    
    output$extrapolatelot <- renderPlotly({
    plot_ly(df, x = ~x, y = ~y, type = 'scatter', mode = 'lines')  %>% 
      #  layout(title="IRR Calculation", xaxis=list(title="Discount Factor", range = c(0, 20)),
      layout(title="IRR via extrapolation", xaxis=list(title="Discount Factor"), 
             yaxis=list(title="NPV (+/-)"), annotations = a)
    })
    
    })  
    
  
})
