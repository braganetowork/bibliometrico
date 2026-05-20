library(plumber)

pr <- plumber::pr("/app/app.R")

plumber::pr_run(
  pr,
  host = "0.0.0.0",
  port = as.integer(Sys.getenv("PORT", "10000"))
)
