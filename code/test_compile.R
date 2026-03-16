# Setup Rtools PATH - corregido con la ubicación correcta del compilador
Sys.setenv(PATH = paste("C:\\rtools43\\x86_64-w64-mingw32.static.posix\\bin;C:\\rtools43\\usr\\bin", Sys.getenv("PATH"), sep=";"))

library(rstan)

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

model_path <- "code/Longitudinal_Conf.stan"

cat("Compilando modelo Stan...\n")
mod <- stan_model(model_path)
cat("Modelo compilado correctamente.\n")