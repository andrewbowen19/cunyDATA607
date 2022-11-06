
# Script to extract data from our .rda files and write to csvs that our RMarkdown notebook can 
library(glue)

book_names <- c("philosophers_stone" = philosophers_stone, 
                "Chamber of Secrets" = chamber_of_secrets,
                "Prisoner of Azkaban" = prisoner_of_azkaban,
                "Goblet of Fire" = goblet_of_fire,
                "Order of the Phoenix" = order_of_the_phoenix,
                "Half Blood Prince" = half_blood_prince,
                "Deathly Hallows" = deathly_hallows)

for (i in seq(1, length(book_names))){
  book_data <- book_names[i]
  title <- names(book_names)[i]
  text_df <- tibble(chapter = seq_along(book_data),
                    text = book_data) %>%
                    unnest_tokens(word, text) %>%
                    mutate(book = title) %>%
                    inner_join(j_lexicon) %>%
                    count(word, score,  sort = TRUE) %>%
                    ungroup()
  
  write.csv(text_df, file=glue("~/CUNY/cunyDATA607/data/harrypotter/{title}.csv"))
  
}

