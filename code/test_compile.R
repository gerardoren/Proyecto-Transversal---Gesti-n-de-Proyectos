library(rstan)

rstan_options(auto_write = TRUE)
options(mc.cores = 1)

model_path <- "code/Longitudinal_Conf.stan"

cat("Compilando modelo Stan...\n")
mod <- stan_model(model_path)
cat("Modelo compilado correctamente.\n")