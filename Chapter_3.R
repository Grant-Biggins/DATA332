#Chapter 3 Exercises
3 > 4 
##FALSE
logic <- c(TRUE, FALSE, TRUE)
logic
typeof(logic)
typeof(F)

comp <- c(1 +1i, 1+2i, 1 + 3i)
comp
typeof(comp)

raw(3)

typeof(raw(3))

hand <- c("ace","king","queen","jack","ten")
hand
typeof(hand1)
hand1 <- c("ace","king","queen","jack","ten","spades", "spades", "spades", "spades","spades")

matrix(hand1, nrow = 5)
matrix(hand1 , ncol = 2)
dim(hand1) <- c(5,2)

hand2 <- c("ace","spades", "king", "spades","queen","spades", "jack", "spades", "ten", "spades")


matrix(hand2, nrow = 5, byrow = TRUE)
matrix(hand2, nrow = 5, byrow = TRUE)

card <- c("ace", "hearts",1)
card

card <- list("ace", "hearts", 1)
card

