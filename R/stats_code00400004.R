
tidy_sc00400004_tbl95 <- function(df) {
  df %>%
    dplyr::select(!tidyselect::matches("tmp_col")) %>%
    purrr::modify_at(1, ~ stringr::str_remove_all(stringr::str_squish(.x), " "))
}

rec_sc00400004_tbl95 <- function(file) {
  stats_names$sc00400004_tbl95$sheet_range %>%
    purrr::flatten_chr() %>%
    purrr::map2(
      .y = purrr::map2(
        .x = seq.int(1, 3),
        .y = stats_names$sc00400004_tbl95$sheet_range %>%
          purrr::map_dbl(length),
        ~ rep(.x, .y)
      ) %>%
        purrr::flatten_dbl(),
      ~ readxl::read_xlsx(file,
                          sheet = .y,
                          range = .x,
                          col_names = stats_names$sc00400004_tbl95$col_name) %>%
        tidy_sc00400004_tbl95()
    ) %>%
    purrr::set_names(stats_names$sc00400004_tbl95$tbl_name %>%
                       purrr::flatten_chr())
}
