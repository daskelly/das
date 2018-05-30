#' A Function to Write Excel Spreadsheets
#'
#' Write a data.frame or list of them to an Excel spreadsheet
#' Auto-widen columns for easy browsing.
#' @param x data.frame or list of data.frames to write to file
#' @param xlfile path to Excel file you want to write
#' @export
#' @examples
#' write_excel()
write_excel <- function(x, xlfile) {
  writexl::write_xlsx(x, path=xlfile)
  wb <- xlsx::loadWorkbook(xlfile)
  sheets <- xlsx::getSheets(wb)
  N <- ifelse(is.data.frame(x[[1]]), ncol(x[[1]]), ncol(x))
  for (i in 1:length(sheets)) {
    xlsx::autoSizeColumn(sheets[[i]], colIndex=1:N)
  }
  xlsx::saveWorkbook(wb, path.expand(xlfile))
}
