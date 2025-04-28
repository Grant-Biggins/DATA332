#Chapter 10: Speed and Vectorization

# Create a long vector
long <- rep(c(-1, 1), 5000000)

# Slow manual loop for abs
abs_loop <- function(x) {
  result <- numeric(length(x))
  for (i in seq_along(x)) {
    if (x[i] < 0) {
      result[i] <- -x[i]
    } else {
      result[i] <- x[i]
    }
  }
  result
}

# Fast vectorized abs
abs_set <- function(x) {
  abs(x)
}

# Timing
system.time(abs_loop(long))
system.time(abs_set(long))

# --------------------------------------------------------

# Vectorize change_symbols function

# Slow original function
change_symbols <- function(vec) {
  for (i in 1:length(vec)) {
    if (vec[i] == "DD") {
      vec[i] <- "joker"
    } else if (vec[i] == "C") {
      vec[i] <- "ace"
    } else if (vec[i] == "7") {
      vec[i] <- "king"
    } else if (vec[i] == "B") {
      vec[i] <- "queen"
    } else if (vec[i] == "BB") {
      vec[i] <- "jack"
    } else if (vec[i] == "BBB") {
      vec[i] <- "ten"
    } else {
      vec[i] <- "nine"
    }
  }
  vec
}

# Fast vectorized function
change_symbols_vec <- function(vec) {
  vec[vec == "DD"] <- "joker"
  vec[vec == "C"] <- "ace"
  vec[vec == "7"] <- "king"
  vec[vec == "B"] <- "queen"
  vec[vec == "BB"] <- "jack"
  vec[vec == "BBB"] <- "ten"
  vec[!(vec %in% c("joker", "ace", "king", "queen", "jack", "ten"))] <- "nine"
  vec
}

# Compare speeds
vec <- c("DD", "C", "7", "B", "BB", "BBB", "0")
many <- rep(vec, 1000000)

system.time(change_symbols(many))
system.time(change_symbols_vec(many))

# --------------------------------------------------------

# Score many rows at once

# Example symbols matrix
symbols <- matrix(c("DD", "DD", "DD",
                    "C", "C", "C",
                    "7", "7", "7",
                    "B", "B", "B",
                    "BB", "BB", "BB",
                    "BBB", "BBB", "BBB"),
                  nrow = 6, byrow = TRUE)

# score() function needed (from earlier)

# Apply scoring to all rows
score_many <- function(symbols_matrix) {
  apply(symbols_matrix, 1, score)
}

# Run
score_many(symbols)
