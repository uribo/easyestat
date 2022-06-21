## code to prepare `stats_names` dataset goes here
stats_names <-
  list(sc00400004_tbl95 = list(
    col_name = c("区分", "tmp_col1", "計",
                 paste0(c("総合", "科学", "歴史", "美術", "野外"), "博物館"),
                 "動物園", "植物園", "動植物園", "水族館"),
    tbl_name = list(sheet1 = paste("95 種類別博物館数(3-1)",
                                   paste0(rep(c("1 計_", "2_登録博物館"), each = 2),
                                          rep(c("設置者別", "都道府県別"), times = 2))),
                    sheet2 = paste("95 種類別博物館数(3-2)",
                                   c(paste0("3 博物館相当施設_",
                                            c("設置者別", "都道府県別")),
                                     "4_計のうち公立")),
                    sheet3 = "95 種類別博物館数(3-3) 5_計のうち私立"),
    sheet_range = list(sheet1 = c("B6:M16",
                                  "B19:M66",
                                  "O6:Z16",
                                  "O19:Z66"),
                       sheet2 = c("B6:M16",
                                  "B19:M66",
                                  "AO6:AZ53"),
                       sheet3 = "B6:M53")
  ))

usethis::use_data(stats_names, overwrite = TRUE, internal = TRUE)
