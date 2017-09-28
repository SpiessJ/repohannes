library(shinythemes)
shinyUI(
    fluidPage(theme = shinytheme("spacelab"),
        #Application title
        headerPanel("Loan Calculator"),
        sidebarPanel(
            numericInput('loan', 'Enter loan',100000, min= 0, max =10000000, step =1),
            helpText("This is the total amount of the loan"),
            numericInput('interest','Enter interest rate in percent',1, min = 0, max = 100, step=0.1),
            helpText("The (fixed) interest rate in percent for the loan"),
            numericInput('period', 'Enter credit period in years',10, min = 0, max = 100, step=1 ),
            helpText("In how many years the loan will be paid back"),
            dateInput("startdate", "Startdate of loan:"),
            helpText("Date the loan starts"),
            submitButton('Calculate')
        ),
        mainPanel(
            h2('Results'),
            h4('For a loan of'),
            verbatimTextOutput("inputValue1"),
            h4('at an interest rate of'),
            verbatimTextOutput("inputValue2"),
            h4('and a credit period of'),
            verbatimTextOutput("inputValue3"),
            h4("... your monthly annuity is"),
            h6("That is the amount you have to pay within a monthly payment plan"),
            verbatimTextOutput("prediction"),
            h4("This means your yearly annuity is"),
            h6("That is the annual equivalent of the monthly annuities"),
            verbatimTextOutput("predictionyear"),
            h4("With the parameters entered the loan will be paid by"),
            verbatimTextOutput("endofLoan"),
            h4("Total number of monthly annuities to be paid"),
            verbatimTextOutput("numberofmonths"),
            h4("Payment pattern"),
            h6("See how your back payments accumulate over time"),
            verbatimTextOutput("projection"),
            plotOutput("projectionplot")
            
        )
        
    )
)