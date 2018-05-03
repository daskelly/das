#' Peek at an object of any type
#'
#' This is an ugly function that I have found useful for looking at
#' objects of various types
#' @param obj The object you wish to explore
#' @param n_row_to_show Number of rows to show, defaults to 3
#' @param n_col_to_show Number of cols to show, defaults to 4
#' @export
#' @examples
#' peek(matrix(1:12, nrow=3), n_row=2, n_col=2)
peek <- function(obj, n_row_to_show = 3, n_col_to_show = 4) {
################################################################################
    # peek at a matrix, vector, data.frame, or list S3 objects are treated
    # as normal lists (I think, see randomForest object as an example)
    d <- dim(obj)
    len <- length(obj)
    if (!is.null(d) && length(d) > 2) {
        cat("Peeking at an object with >2 dimensions. I'm punting!\n")
        return()
    }
    if (typeof(obj) == "S4") {
        print(obj)  # use the S4 object's (hopefully) existing print method
    } else if (typeof(obj) == "list" && !is.data.frame(obj)) {
        # peek at the first n_row_to_show elements of the list
        n_row_to_show <- min(n_row_to_show, len)
        for (i in 1:n_row_to_show) {
            if (is.null(names(obj))) {
                name <- sprintf("element %d", i)
            } else {
                name <- names(obj)[i]
            }
            cat(sprintf("%s:\n", name))
            peek(obj[[i]], n_row = n_row_to_show, n_col = n_col_to_show)
            cat("\n")
        }
        if (len - n_row_to_show > 0) {
            cat(sprintf("... showing %d/%d elements of the list\n",
                n_row_to_show, len))
        }
    } else if (is.null(nrow(obj))) {
        # obj is a vector
        if (len > n_row_to_show) {
            print(head(obj, n_row_to_show))
            cat(sprintf("... showing %d/%d values\n", n_row_to_show, len))
        } else {
            print(obj)
        }
    } else {
        # obj is a matrix or data.frame - treat those in the same way
        x <- min(n_row_to_show, nrow(obj))
        y <- min(n_col_to_show, ncol(obj))
        print(obj[1:x, 1:y])
        more_rows <- nrow(obj) - x
        more_cols <- ncol(obj) - y
        if (more_rows > 0 || more_cols > 0) {
            cat(sprintf("... showing %d/%d rows and %d/%d columns\n",
                n_row_to_show, nrow(obj), n_col_to_show, ncol(obj)))
        }
    }
}
