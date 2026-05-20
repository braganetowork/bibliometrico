# run.R — Inicializa o servidor Plumber

# Garante que os pacotes estão carregados
if (!requireNamespace("plumber", quietly = TRUE)) {
  stop("Pacote 'plumber' não encontrado. Verifique a instalação.")
}

library(plumber)

cat(">>> Iniciando BiblioMerge na porta", Sys.getenv("PORT", "10000"), "\n")

pr <- plumber::pr("app.R")

plumber::pr_run(
  pr,
  host = "0.0.0.0",
  port = as.integer(Sys.getenv("PORT", "10000"))
)

