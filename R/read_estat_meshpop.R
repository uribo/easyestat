#' Read e-Stat mesh population census data
#' @param file Path to downloaded e-Stat text file
#' @param mesh_size Currently, only 0.5 (500m mesh)
#' @export
read_estat_meshpop <- function(file, mesh_size = 0.5) {
  d <-
    utils::read.csv(file, fileEncoding = "cp932", stringsAsFactors = FALSE)
  col_vars <-
    d[1,] %>%
    purrr::modify(
      ~ stringr::str_trim(.x, side = "left") %>%
        stringr::str_replace("[[:space:]]", "_") %>%
        stringr::str_replace(" ", "_") %>%
        stringi::stri_trans_nfkc())
  d %>%
    tibble::as_tibble() %>%
    dplyr::slice(-1) %>%
    purrr::set_names(c(names(col_vars[seq.int(4)]),
                       purrr::flatten_chr(col_vars[seq.int(5, length(col_vars))]))) %>%
    dplyr::mutate_all(~ na_if(., "*")) %>%
    dplyr::mutate_all(~ na_if(., "")) %>%
    utils::type.convert() %>%
    dplyr::mutate_at(dplyr::vars(seq.int(3)), as.character)
}