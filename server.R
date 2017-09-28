calculateMonthlyAnnuity <- function(loan, interest, period) 
    1/12*loan * ((1+(interest/100))^period*(interest/100))/((1+(interest/100))^period-1)
calculateAnnuity <- function(loan, interest, period) 
    loan * ((1+(interest/100))^period*(interest/100))/((1+(interest/100))^period-1)
endofLoan <- function(startdate, period) as.numeric(substring((as.Date(startdate)) + (365 * period),1,4))
numberofmonths <- function(period) period*12
projection <- function(loan, interest, period) {
    prob1 <- function(loan){  
        for(i in 2:(period+1)) 
            loan[i] <- loan * ((1+(interest/100))^period*(interest/100))/((1+(interest/100))^period-1)
        return(loan)
    }
    x <- prob1(loan)
    x[1] <- 0
    x <- cumsum(x)
    return(x)
}

shinyServer(
    function(input, output) {
        output$inputValue1 <- renderPrint({input$loan})
        output$inputValue2 <- renderPrint({input$interest})
        output$inputValue3 <- renderPrint({input$period})
        output$prediction  <- renderPrint({calculateMonthlyAnnuity(input$loan,input$interest,input$period)})
        output$predictionyear <- renderPrint({calculateAnnuity(input$loan,input$interest,input$period)})
        output$endofLoan <- renderPrint({endofLoan(input$startdate,input$period)})
        output$numberofmonths <- renderPrint({numberofmonths(input$period)})
        output$projection <- renderPrint({projection(input$loan,input$interest,input$period)})
        output$projectionplot <- renderPlot({barplot(projection(input$loan,input$interest,input$period),
                                                     type = "h", 
                                                     main = "Payment Pattern",
                                                     ylab = "Accumulated Annuities",
                                                     xlab = "Years",
                                                     col = "lightblue",
                                                     ylim = c(min(projection(input$loan,input$interest,input$period)),
                                                              1.3*max(projection(input$loan,input$interest,input$period)))
                                                     )})
        

    }
)

#Darlehenssumme - loan
#Zinssatz - interest rate
#Laufzeit - credit period