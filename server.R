library(shiny)
library(dplyr)
library(stringr)

# Server logic to draw a histogram
shinyServer(function(input, output, session) {
  
  uni_words <- readRDS("uni_words.rds")
  bi_words <- readRDS("bi_words.rds")
  tri_words <- readRDS("tri_words.rds")
  
  # function to return highly probable previous word given two successive words
  triWords <- function(w1, w2, n = 5) {
    pwords <- tri_words[.(w1, w2)][order(-Prob)]
    if (any(is.na(pwords)))
      return(biWords(w2, n))
    if (nrow(pwords) > n)
      return(pwords[1:n, word_3])
    count <- nrow(pwords)
    bwords <- biWords(w2, n)[1:(n - count)]
    return(c(pwords[, word_3], bwords))
  }
  
  # function to return highly probable previous word given a word
  biWords <- function(w1, n = 5) {
    pwords <- bi_words[w1][order(-Prob)]
    if (any(is.na(pwords)))
      return(uniWords(n))
    if (nrow(pwords) > n)
      return(pwords[1:n, word_2])
    count <- nrow(pwords)
    unWords <- uniWords(n)[1:(n - count)]
    return(c(pwords[, word_2], unWords))
  }
  
  # function to return random words from unigrams
  uniWords <- function(n = 5) {  
    return(sample(uni_words[, word_1], size = n))
  }
  
  # The prediction app
  pred_words <- function(str){
    if (str == ""){
      list_word <- list(first = "",
                        second = "",
                        third = "")
    }
    else{
      require(quanteda)
      length_word = str_count(str,"\\w+")
      length_word
      tokens <- quanteda::tokens(x = char_tolower(str))
      quanteda::tokens_wordstem(tokens)
      if(length_word!=1){tokens <- quanteda::char_wordstem(rev(rev(tokens[[1]])[1:2]), language = "english")}
      else{tokens <- quanteda::char_wordstem(rev(rev(tokens[[1]])), language = "english")}
      if(length_word == 1){
        predicted <- bi_words %>% filter(One_Word == tokens[1]) %>% arrange(desc(Frequency))
        i = 2
      }
      else if(length_word >= 2){
        predicted <- tri_words %>% filter(One_Word == tokens[1], Two_Words == tokens[2]) %>% arrange(desc(Frequency))
        i = 3
      }
      list_word <- list(first = predicted[1, i],
                        second = predicted[2, i],
                        third = predicted[3, i])
    }
    return(list_word)
  }

  pbutton <- reactive({
    pb1 = pred_words(input$inputString)
    pb1
  })
  
  output$show <- renderUI({
    tags$div(
      actionButton("predict1", label = pbutton()$first), 
      actionButton("predict2", label = pbutton()$second),
      actionButton("predict3", label = pbutton()$third))
  })
  
  observeEvent(input$predict1, {
    updateTextInput(session, "inputString", value = paste(input$inputString, pbutton()$first))
  }) 
  observeEvent(input$predict2, {
    updateTextInput(session, "inputString", value = paste(input$inputString, pbutton()$second))
  }) 
  observeEvent(input$predict3, {
    updateTextInput(session, "inputString", value = paste(input$inputString, pbutton()$third))
  }) 
  
})
