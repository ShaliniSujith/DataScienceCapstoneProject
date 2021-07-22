# DataScienceCapstoneProject

## Objective
The goal is to build a shiny application made using R to highlight the prediction algorithm that is built and to provide a user-friendly interface that can be accessed by others conveniently.

## Steps
Data cleanup - Removed unnecessary expression.
Seperated the text corpus
Created N-grams and Document Frequency Matrices from the corpus
Tokenized the group of words for better word count
Created functions to predict next word using the concept of n-gram and backoff modeling

### Limitations:

If the word or phrase entered in the text box is beyond the scope of the algorithm, it will display “NA"s for all buttons.
Words more than three will predict the next word only based on the last two words of the whole phrase or sentence.

## Building N-Grams
We will use N-grams, which are the combinations of 'N' number of words that appear in a sentence or, in this project, on the same line in the data. Note that as the number of words (N) increases, there are less combinations of the words available.

For example, consider the sentence “Exciting to learn DS”. Using n-grams, we obtain the counts and combinations:

1-gram: Count of 4; Combinations = “Exciting” and “to” and “learn” and “DS”;

2-gram: Count of 3; Combinations = i.e. “Exciting to”, “to learn” and “learn DS”;

3-gram: Count of 2; Combinations = “Exciting to learn” and “to learn DS”;

4-gram: Count of 1; Combinations = “Exciting to learn DS”.

For this project, I will use 1-grams through 3-grams to build combinations.

Sources
Shiny Application: https://kfpq8z-shalini-sujith.shinyapps.io/DataScienceCapstoneProject/

Github Repository: https://github.com/ShaliniSujith/DataScienceCapstoneProject

Dataset: https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip

