library(ggplot2)
replicate(3, 1 + 1)
replicate(10, roll())
rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)

roll <- function() {
  die <- 1:6
  dice<- sample(die, size = 2, replace = TRUE,
    prob = c(1/8, 1/8, 1/8, 1/8, 1/8, 3/8))
  sum(dice)
}

rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)
