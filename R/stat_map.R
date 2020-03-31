#' Download Japan prefecture map from e-stat
#' @param prefcode The JIS-code for prefecture and city identifical number.
#' If prefecture, must be from 1 to 47.
#' @param dest If TRUE, to unzip downloaded files.
#' @inheritParams utils::unzip
#' @export
download_stat_map <- function(prefcode, exdir = ".", dest = TRUE, .survey_id = c("A002005212015")) {
  prefcode <-
    stringr::str_pad(prefcode, width = 2, pad = "0")
  rlang::arg_match(prefcode, values = stringr::str_pad(seq.int(47), width = 2, pad = "0"))
  x <-
    glue::glue(
      "https://www.e-stat.go.jp/gis/statmap-search/data?dlserveyId={.survey_id}&code={prefcode}&coordSys=1&format=shape&downloadType=5"
    )
  qry <-
    purrr::pluck(httr::parse_url(x), "query")
  destfile <-
    glue::glue(
      "{exdir}/{serveyId}{coordSys}{prefcode}.zip",
      serveyId = qry$dlserveyId,
      coordSys = dplyr::case_when(qry$coordSys == "1" ~ "DDSWC")
    )
  utils::download.file(url = x,
                       destfile = destfile)
  if (dest == TRUE) {
    utils::unzip(
      zipfile = destfile,
      exdir = glue::glue("{tools::file_path_sans_ext(destfile)}")
    )
  }
}
