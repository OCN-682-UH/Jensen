# This is my shiny app

# Load libraries
library(shiny)
library(tidyverse)
library(rsconnect)

# Load data
monster_movie_genres <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-29/monster_movie_genres.csv')
monster_movies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-29/monster_movies.csv')

# Merge data
monster_genre <- left_join(monster_movies, monster_movie_genres, join_by("tconst"))

# Manipulate data
filtered_movies <- monster_genre %>%                                      ## Call data
  filter(genres.y == c("Horror", "Action", "Western", "Drama", "Animation")) %>%       ## Select only horror genre          
  filter(year %in% c("1975":"2025")) %>%                                  ## select years
  group_by(year, genres.y) %>%                                            ## group data by year and genre
  summarise(average_rating = mean(average_rating, na.rm = TRUE)) %>%      ## calculate average rating for each year
  ungroup() 

view(filtered_movies)

# Make shiny
ui <- fluidPage(
      selectInput(inputId = "selected_genre",
                  label = "Choose a Genre",
                  choices = unique(filtered_movies$genres.y),
                  selected = "Horror"),
      textInput(inputId = "plot_title",
                label = "Plot Title",
                value = "Line Plot of Movie Genre Ratings"),
      plotOutput("line_plot") 
    )
  
  
server <- function(input, output) {
  genre_data <- reactive({
    filtered_movies %>% filter(genres.y == input$selected_genre)
  })
  output$line_plot <- renderPlot({
    ggplot(genre_data(), aes(x = year, y = average_rating)) +
      geom_line(size = 1, color = "black") +
      geom_point(size = 2, color = "red") +
      labs(
        title = input$plot_title,
        x = "Year",
        y = "Average Rating"
      ) +
      theme_minimal()
  })
}


shinyApp(ui = ui, server = server)
