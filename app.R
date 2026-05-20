# ============================================================
# app.R — BiblioMerge API
# Endpoints: GET / (interface HTML) | POST /merge (processa)
# ============================================================

library(plumber)
library(bibliometrix)
library(openxlsx)

# ---- Filtro CORS (permite testes locais) ----
#* @filter cors
function(req, res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  res$setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
  res$setHeader("Access-Control-Allow-Headers", "Content-Type")
  if (req$REQUEST_METHOD == "OPTIONS") {
    res$status <- 200
    return(list())
  }
  forward()
}

# ---- GET / — Serve a página HTML ----
#* @get /
#* @html
function() {
  paste(readLines("/app/index.html", warn = FALSE), collapse = "\n")
}

# ---- GET /health — Health check para o Render ----
#* @get /health
function() {
  list(status = "ok")
}

# ---- POST /merge — Recebe dois arquivos e retorna XLSX ----
#* Merge Scopus CSV + Web of Science TXT em uma base única
#* @post /merge
#* @param csv_file:file Arquivo CSV exportado do Scopus
#* @param txt_file:file Arquivo savedrecs.txt exportado do Web of Science
#* @serializer contentType list(type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
function(csv_file, txt_file, res) {
  tryCatch({

    # 1) Converter Scopus CSV → data.frame bibliométrico
    A <- convert2df(
      file     = csv_file$datapath,
      dbsource = "scopus",
      format   = "csv"
    )

    # 2) Converter Web of Science TXT → data.frame bibliométrico
    B <- convert2df(
      file     = txt_file$datapath,
      dbsource = "wos",
      format   = "plaintext"
    )

    # 3) Mesclar e remover duplicatas
    Database <- mergeDbsources(A, B, remove.duplicated = TRUE)

    # 4) Gravar XLSX temporário
    outfile <- tempfile(fileext = ".xlsx")
    write.xlsx(Database, outfile)

    # 5) Retornar o arquivo para download
    res$setHeader(
      "Content-Disposition",
      'attachment; filename="dadosbiblio.xlsx"'
    )
    readBin(outfile, "raw", n = file.info(outfile)$size)

  }, error = function(e) {
    # Em caso de erro, retorna mensagem em texto puro
    res$status <- 400
    res$setHeader("Content-Type", "text/plain; charset=utf-8")
    paste0("Erro ao processar arquivos: ", e$message)
  })
}
