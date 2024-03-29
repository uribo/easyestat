dl_stat_mesharea <- function(tbl_code, meshcode, exdir = ".", dest = TRUE) {
  x <-
    glue::glue("https://www.e-stat.go.jp/gis/statmap-search/data?statsId={tbl_code}&code={meshcode}&downloadType=2")
  destfile <-
    glue::glue(
      "{exdir}/tbl{tbl_code}H{meshcode}.zip")
  utils::download.file(url = x,
                       destfile = destfile)
  if (dest == TRUE)
    utils::unzip(
      zipfile = destfile,
      exdir = exdir
    )
}

download_stat_data <- function(code, exdir = ".", .stats_id = "T000846") {
  x <-
    glue::glue("https://www.e-stat.go.jp/gis/statmap-search/data?statsId={.stats_id}&code={code}&downloadType=2")
  qry <- purrr::pluck(httr::parse_url(x), "query")
  destfile <- glue::glue("{exdir}/{qry$statsId}{qry$code}.zip")
  utils::download.file(url = x, destfile = destfile)
  utils::unzip(zipfile = destfile,
               exdir = exdir)
  unlink(destfile)
}

list_tbl_code <-
  c(`small_area` = "T000848",
    `1km` = "T000846",
    `500m` = "T000847",
    `250m` = "T000876")

available_stats_meshcode80km <-
  c("3622", "3623", "3624", "3653", "3724", "3725", "3741", "3831",
    "3926", "3927", "3928", "3942", "4027", "4028", "4042", "4128",
    "4129", "4229", "4230", "4329", "4429", "4530", "4531", "4629",
    "4630", "4631", "4729", "4730", "4731", "4828", "4829", "4830",
    "4831", "4839", "4928", "4929", "4930", "4931", "4932", "4933",
    "4934", "4939", "5029", "5030", "5031", "5032", "5033", "5034",
    "5035", "5036", "5039", "5129", "5130", "5131", "5132", "5133",
    "5134", "5135", "5136", "5137", "5138", "5139", "5229", "5231",
    "5232", "5233", "5234", "5235", "5236", "5237", "5238", "5239",
    "5240", "5332", "5333", "5334", "5335", "5336", "5337", "5338",
    "5339", "5340", "5432", "5433", "5435", "5436", "5437", "5438",
    "5439", "5440", "5536", "5537", "5538", "5539", "5540", "5541",
    "5636", "5637", "5638", "5639", "5640", "5641", "5738", "5739",
    "5740", "5741", "5839", "5840", "5841", "5939", "5940", "5941",
    "5942", "6039", "6040", "6041", "6139", "6140", "6141", "6239",
    "6240", "6241", "6243", "6339", "6340", "6341", "6342", "6343",
    "6439", "6440", "6441", "6442", "6443", "6444", "6445", "6540",
    "6541", "6542", "6543", "6544", "6545", "6641", "6642", "6643",
    "6644", "6645", "6741", "6742", "6840", "6841", "6842")
