# install.R — Instalação de dependências com tratamento de erros

options(repos = c(CRAN = "https://cloud.r-project.org"))
options(Ncpus = 4)

cat(">>> Instalando plumber...\n")
install.packages("plumber")

cat(">>> Instalando openxlsx...\n")
install.packages("openxlsx")

cat(">>> Instalando bibliometrix (pode demorar)...\n")
install.packages("bibliometrix")

cat(">>> Verificando instalações...\n")
stopifnot(requireNamespace("plumber", quietly = TRUE))
stopifnot(requireNamespace("openxlsx", quietly = TRUE))
stopifnot(requireNamespace("bibliometrix", quietly = TRUE))

cat(">>> Todos os pacotes instalados com sucesso!\n")
