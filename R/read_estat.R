#' Read files downloaded from e-stat
#' @param file path
#' @param statsCode statsCode
#' @param id Not currently used.
#' @export
read_estat_file <- function(file, statsCode = "00400004", id = "") {
  statsCode <-
    dplyr::case_when(statsCode == "00400004" ~ "00400004_tbl95")
  rlang::exec(glue::glue("rec_sc{statsCode}"), !!!list(file = file))
}
