#' Download Japan prefecture map from e-stat
#' @param prefcode The JIS-code for prefecture and city identical number.
#' If prefecture, must be from 1 to 47.
#' @param dest If *TRUE*, to unzip downloaded files.
#' @param .survey_id survey id (A00200521YYYY is small area,
#' D00200521YYYY is did area)
#' @inheritParams utils::unzip
#' @seealso [https://www.e-stat.go.jp/gis](https://www.e-stat.go.jp/gis)
#' @export
download_stat_map <- function(prefcode, exdir = ".", dest = TRUE, .survey_id = c("A002005212015")) {
  prefcode <-
    stringr::str_pad(prefcode, width = 2, pad = "0")
  rlang::arg_match(prefcode, values = stringr::str_pad(seq.int(47), width = 2, pad = "0"))
  .survey_id <-
    rlang::arg_match(
      .survey_id,
      c(paste0(rep(c("A00200521", "D00200521"), each = 2),
               rep(c(2015, 2010), 2)),
        "A002005212005",
        "A002005212000"))
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

#' Read e-stat aggregation unit boundary data
#' @description
#' The GIS data downloaded from e-stat is read and converted into an easy to process [sf::sf] format.
#' You can use [download_stat_map()] to download the data.
#' @param file Path to downloaded e-Stat shape file
#' @param type Currently, only "aggregate_unit" is used.
#' @param remove_cols Whether or not to remove redundant columns.
#' When *TRUE* (the default), the following columns are removed (See details).
#' These columns can be substituted or sought with values from other columns.
#'   * S_AREA
#'   * KAxx_, KAxx_id
#'   * KEN, KEN_NAME
#'   * DUMMY1
#'   * X_CODE, Y_CODE
#' @export
read_estat_map <- function(file, type = "aggregate_unit", remove_cols = TRUE) {
  x_code <- y_code <- s_area <- ken <- ken_name <- dummy1 <- NULL
  area <- perimeter <- menseki <- km2 <- m2 <- m <- NULL
  d <-
    sf::st_read(file,
            as_tibble = TRUE,
            stringsAsFactors = FALSE)
  d <-
    d %>%
    purrr::set_names(d %>%
                       names() %>%
                       tolower())

  if (utils::hasName(d, "area")) {
    d <-
      d %>%
      dplyr::mutate(area = units::set_units(area, m2),
                    perimeter = units::set_units(perimeter, m))
  }
  if (utils::hasName(d, "menseki")) {
    d <-
      d %>%
      dplyr::mutate(menseki = units::set_units(menseki, km2))
  }
  if (remove_cols == TRUE) {
    d <-
      d %>%
      dplyr::select(
        -x_code, -y_code,
        -s_area,
        -tidyselect::contains("kaxx_"),
        -ken, -ken_name, -dummy1)
  }
  d
}

# prefcode = "08"
# .survey_id = "A002005212010"
# https://www.e-stat.go.jp/gis/statmap-search?page=1&type=2&aggregateUnitForBoundary=A&toukeiCode=00200521&toukeiYear=2005&serveyId=A002005212005&prefCode=08&coordsys=1&format=shape
# x
# https://www.e-stat.go.jp/gis/statmap-search/data?dlserveyId=A002005212010&code=08&coordSys=1&format=shape&downloadType=5
