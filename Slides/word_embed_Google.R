# install.packages("devtools")  # if not already installed
# devtools::install_github("bmschmidt/wordVectors")
# install.packages("text2vec")  # optional

library(wordVectors)
library(ggplot2)

# Path to your binary file
model_path <- "D:/GoogleNews/GoogleNews-vectors-negative300.bin"

# Load the model (may take ~30 seconds)
model <- read.vectors(model_path, binary = TRUE)

# List of economics words
econ_words <- c("inflation", "interest", "growth", "unemployment",
                "investment", "demand", "supply", "crisis", "deficit")

# Filter words that exist in the model
valid_words <- econ_words[econ_words %in% rownames(model)]

# Extract vectors for these words
econ_vectors <- model[valid_words, ]

# Reduce to 2D using PCA
econ_pca <- prcomp(econ_vectors, center = TRUE, scale. = TRUE)
df <- as.data.frame(econ_pca$x[, 1:2])
df$word <- rownames(df)

# Plot
ggplot(df, aes(x = PC1, y = PC2, label = word)) +
  geom_point(color = "darkred", size = 3) +
  geom_text(vjust = -0.5, hjust = 0.5, size = 5) +
  theme_minimal() +
  ggtitle("Economics Words in Word2Vec Space (Google News)")


###
# simulated word analogy

library(tibble)
library(ggplot2)
library(ggrepel)

# Manually define 2D vectors to simulate word relationships
word_vectors <- tibble::tibble(
  word = c("king", "man", "woman", "queen"),
  dim1 = c(2, 1, 1, 2),
  dim2 = c(2, 1, 2, 3)
)

# Compute the analogy vector: king - man + woman
analogy <- word_vectors[word_vectors$word == "king", 2:3] -
  word_vectors[word_vectors$word == "man", 2:3] +
  word_vectors[word_vectors$word == "woman", 2:3]

# Add the result as a new point ("predicted_queen")
predicted_queen <- tibble::tibble(
  word = "king - man + woman",
  dim1 = analogy$dim1,
  dim2 = analogy$dim2
)

# Combine for plotting
plot_data <- bind_rows(word_vectors, predicted_queen)

# Plot
ggplot(plot_data, aes(x = dim1, y = dim2, label = word)) +
  geom_point(size = 3, color = ifelse(plot_data$word == "king - man + woman", "red", "steelblue")) +
  geom_text_repel(size = 5, max.overlaps = Inf) +
  geom_hline(yintercept = 0, color = "gray80") +
  geom_vline(xintercept = 0, color = "gray80") +
  coord_fixed(xlim = c(0, 3), ylim = c(0, 4)) +
  theme_minimal(base_size = 14) +
  labs(title = "Simulated Word Analogy: king - man + woman ≈ queen",
       x = "Dimension 1", y = "Dimension 2")


