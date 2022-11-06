
# Script to extract data from our .rda files and write to csvs that our RMarkdown notebook can 
library(glue)

book_names <- c("philosophers_stone" = philosophers_stone, 
                "chamber_of_secrets" = chamber_of_secrets,
                "prisoner_of_azkaban" = prisoner_of_azkaban,
                "goblet_of_fire" = goblet_of_fire,
                "order_of_the_phoenix" = order_of_the_phoenix,
                "half_blood_prince" = half_blood_prince,
                "deathly_hallows" = deathly_hallows)

for (i in seq(1, length(book_names))){
  book_data <- book_names[i]
  title <- names(book_names)[i]
  text_df <- tibble(chapter = seq_along(book_data),
                    text = book_data) %>%
                    unnest_tokens(word, text) %>%
                    mutate(book = title) %>%
                    inner_join(j_lexicon) %>%
                    count(word, score,  sort = TRUE) %>%
                    ungroup()  %>%
                    left_join(j_lexicon) %>%
                    count(book, index = c(1:nrow(df)), score)
  
  write.csv(text_df, file=glue("~/CUNY/cunyDATA607/data/harrypotter/{title}.csv"))
  
}

