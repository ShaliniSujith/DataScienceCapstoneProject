library(shiny)
library(dplyr)
library(stringr)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  tags$div(
    h2(HTML("<font color=\"#44508d\"><b>Word Prediction Application</b></font>"), align = "center")
  ),
  tags$div(
    h3(HTML("<font color=\"#44508d\"><b>How to use?</b></font>"), align = "center")
  ),
  tags$div(
    h5(HTML("<font color=\"#44668d\">Welcome! </br>
            If you are looking for an application that can predict the next word for your text input, may it be a word or a phrase.<br/>Here, you can easily input the word/phrase you want to predict the next word to and three predicted words will display below.<br/><br/> Just click the button of your desired predicted word and it will add up to the text you have entered. Afterwhich, it will predict again the next word to the new phrase created after clicking the button.</font>"), align = "left"),
  br(),
    h5(HTML("<font color = \"#8c448d\"> Note: words or phrases beyond the scope of the application will be unable to predict the next word hence displaying 'NA's for all buttons.</font>"), align = 'center')),
  sidebarLayout(position = "left", 
    sidebarPanel(
      h4("Enter word/phrase"),
      textInput("inputString", "", value = ""), width = 15, align = "center",
      h4(HTML("<center>Predicted Next Word</center>")),
      uiOutput("show")),
    mainPanel(
      )
)
)
)




