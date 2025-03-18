create_deck <- function() {
  suits <- c("Hearts", "Diamonds", "Clubs", "Spades")
  faces <- c("2", "3", "4", "5", "6", "7", "8", "9", "10", 
             "Jack", "Queen", "King", "Ace")
  values <- c(2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11)  # Blackjack values
  
  deck <- data.frame(
    face = rep(faces, times = 4),  # Each face repeats for all four suits
    suit = rep(suits, each = 13),  # Each suit appears 13 times
    value = rep(values, times = 4), # Assign card values
    stringsAsFactors = FALSE
  )
  
  return(deck)
}

# Example usage
deck <- create_deck()
print(deck)



deal <- function(cards)
  
  deal(deck)

shuffle <- function(cards){
  random <- sample(1:52, size = 52)
  cards[random, ]
   } 
  