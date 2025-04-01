# Logical test for "ace"
deck$face == "ace"

# Count "ace"
sum(deck$face == "ace")

# Find hearts
deck$suit == "hearts"

# Update values
deck$value[deck$suit == "hearts"] <- 1

# Find the queen of spades
queenOfSpades <- deck$face == "queen" & deck$suit == "spades"

# View current values
deck[queenOfSpades, ]

# Update value
deck$value[queenOfSpades] <- 13

# Provided values
x <- c(-1, 0, 1)
y <- c(5, 15)
z <- c("Monday", "Tuesday", "Friday")

# 1. Is x positive?
x > 0

# 2. Is x greater than 10 and less than 20?
x > 10 & x < 20

# 3. Is object y the word "February"?
y == "February"  # FALSE (numeric vs string)

# 4. Is every value in z a day of the week?
z %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
all(z %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))


