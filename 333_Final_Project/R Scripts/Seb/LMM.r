# Author: Sebastiano
# Date last updated: Dec 14th, 2025
# Description: Linear Mixed effect model analysis of the datasets aspirated K tokens, along with residual plots


library(tidyverse)
library(lme4)
library(lmerTest)

df <- read.csv(r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\drvot sanitised data\drvotsanitised.csv)")
head(df)
df_k <- df %>%
  filter(phone %in% c("k", "K"))

df_k$speaker <- factor(df_k$speaker)
df_k$language <- factor(df_k$language)
df_k$language <- relevel(df_k$language, ref = "E")

# If the model converges:
model <- lmer(vot_ms ~ language + (1 + language | speaker), data = df_k)
summary(model)


df_plot <- df_k %>%
  group_by(speaker, language) %>%
  summarise(mean_vot = mean(vot_ms), .groups = "drop")

windows();
ggplot(df_plot, aes(x = language, y = mean_vot, group = speaker, color = speaker)) +
  geom_line(alpha = 0.8) +
  geom_point(size = 2) +
  theme_minimal() +
  labs(title = "Within-Speaker Recorded VOT Means: English vs Cantonese",
       x = "Language",
       y = "Mean VOT (ms)") +
  theme(legend.position = "none")

# Plot residuals vs. fitted values
windows();
plot(fitted(model), residuals(model))
abline(h = 0, col = 'red', lwd = 2)

# Q-Q plot
windows();
qqnorm(residuals(model))
qqline(residuals(model), col = "red", lwd = 2)

# Histogram
windows();
hist(residuals(model),
breaks = 30,
main = "Histogram of Residuals",
xlab = "Residuals",
col = "lightblue")

#Extract random effects (speaker intercepts)
random_effects <- ranef(model)$speaker
# Q-Q plot of random effects
qqnorm(random_effects$`(Intercept)`,
main = "Q-Q Plot: Random Effects (Speaker)")
qqline(random_effects$`(Intercept)`, col = "red", lwd = 2)


ranef_speaker <- ranef(model)$speaker %>%
  rownames_to_column("speaker") %>%
  rename(
    intercept = `(Intercept)`,
    slope_C_minus_E = languageC
  )

head(ranef_speaker)

fixed_slope <- fixef(model)["languageC"]
ranef_speaker <- ranef_speaker %>%
  mutate(actual_slope = fixed_slope + slope_C_minus_E)

n_cantonese_longer <- sum(ranef_speaker$actual_slope > 0)
n_english_longer   <- sum(ranef_speaker$actual_slope < 0)

cat("Speakers with Cantonese > English VOT:", n_cantonese_longer, "\n")
cat("Speakers with English > Cantonese VOT:", n_english_longer, "\n")


# Predicted English and Cantonese VOT per speaker
plot_data <- ranef_speaker %>%
  mutate(
    English = fixef(model)["(Intercept)"] + intercept,
    Cantonese = English + actual_slope
  ) %>%
  select(speaker, English, Cantonese) %>%
  pivot_longer(cols = c("English", "Cantonese"), 
               names_to = "language", values_to = "vot_ms") %>%
  mutate(language = factor(language, levels = c("English", "Cantonese")))

# Plot
windows();
ggplot(plot_data, aes(x = language, y = vot_ms, group = speaker, color = speaker)) +
  geom_line(alpha = 0.8) +
  geom_point(size = 2) +
  theme_minimal() +
  labs(title = "Within-Speaker LMM Predicted VOT: English vs Cantonese",
       x = "Language",
       y = "Predicted VOT (ms)") +
  theme(legend.position = "none")