#### CODE TO WEBSCRAPE NFL STANDINGS (WINS) FOR 2017 AND THEN GRAPH USING GGPLOT2 ####

# Loading the rvest package
library('rvest')

# Specifying the url for desired website to be scrapped
url <- "https://www.pro-football-reference.com/years/1992/#all_AFC"

# Reading the HTML code from the website
webpage <- read_html(url)

# Using CSS selectors to scrape the afc and nfc team names:
team_name_afc_data_html <- html_nodes(webpage, '#AFC tbody th')
team_name_nfc_data_html <- html_nodes(webpage, '#NFC tbody th')

# Converting the afc and nfc team names data to text:
team_name_afc_data <- html_text(team_name_afc_data_html)
team_name_nfc_data <- html_text(team_name_nfc_data_html)

# Combine afc and nfc team names into one list
team_name_data <- c(team_name_afc_data, team_name_nfc_data)

# Data-Preprocessing: removing special characters from names * or + using brackets [*+]
team_name_data <- gsub("[*+]", "", team_name_data)

# View all team names
team_name_data

#### Repeat the above steps for wins ####

# Using CSS selectors to scrape the afc team wins
wins_afc_data_html <- html_nodes(webpage, '#AFC .left+ .right')
wins_nfc_data_html <- html_nodes(webpage, '#NFC .left+ .right')

# Converting the afc team names data to text
wins_afc_data <- html_text(wins_afc_data_html)
wins_nfc_data <- html_text(wins_nfc_data_html)

# Data-Preprocessing: Converting wins to numerical
wins_afc_data <- as.numeric(wins_afc_data)
wins_nfc_data <- as.numeric(wins_nfc_data)

# Combine afc and nfc team wins into one list
wins_data <- c(wins_afc_data, wins_nfc_data)

# View all team names
wins_data

#### COMBINE TEAM NAMES AND WINS INTO A DATA FRAME ####

# Combining all teh lists to form a data frame
nfl_standings_2017_df <- data.frame(Team = team_name_data, Wins = wins_data)

# View structure of the data frame
str(nfl_standings_2017_df)

# View dataframe
nfl_standings_2017_df


#### PLOT WINS WITH GGPLOT2 ####

# Load ggplot2
library(ggplot2)

ggplot(nfl_standings_2017_df, aes(reorder(Team, Wins), Wins, fill = Wins)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "WINS BY NFL TEAMS IN 2017"
  ) +
  xlab("Team Name") +
  theme(legend.position = "none") +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 16))



