## Capstone: Coursera Data Science
## Final Project

library(shiny)
library(markdown)
library(shinythemes)

## SHINY UI
shinyUI(fluidPage(
  theme = shinytheme("cyborg"),
  titlePanel(
    "Final Project Submission - Coursera Data Science Capstone: Natural Language Processing (NLP) for Word Prediction"
  ),
  sidebarLayout(
    sidebarPanel(
      helpText(
        "Please enter a word or sentence to test the word prediction algorithm that uses tokenized n-grams."
      ),
      hr(),
      textInput("inputText", "Please enter your text here", value = ""),
      hr(),
      helpText(
        "WHAT IS HAPPENING UNDER THE HOOD?",
        hr(),
        "Data from HC Corpora (blogs, news, twitter) was downloaded.
        After creating a data sample (5.000 records) from the data, this sample was cleaned (removing punctuation and whitespaces etc.).
        This data sample was then tokenized into so-called n-grams (e.g. bigrams with 2 words, trigrams with 3 words).
        The n-gram tables are then used as frequency dictionaries and basis for predicting the next word.
        ",
        hr(),
        "Johannes Spiess 2018"
      )
    ),
    mainPanel(
      h3("This is the predicted next word:"),
      verbatimTextOutput("prediction"),
      strong("You entered:"),
      strong(code(textOutput('sentence1'))),
      br(),
      strong("Word prediction result:"),
      strong(code(textOutput('sentence2'))),
      hr()
    )
  )
  ))
