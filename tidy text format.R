library(janeaustenr) #Jane Austen’s 6 completed published novels
library(dplyr) #grammar of data manipulation
library(stringr) #character manipulation
library(tidytext)

original_books <- austen_books() %>% 
  group_by(book) %>% 
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",
                                                 ignore_case = TRUE)))) %>% 
  ungroup()

original_books

tidy_books <- original_books %>% 
  unnest_tokens(word, text)

tidy_books

# Removing stop words

tidy_books <- tidy_books %>% 
  anti_join(stop_words)

# Using dplyr to count

tidy_books %>% 
  count(word, sort = TRUE)