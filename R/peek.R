#' Peek at an object of any type
#'
#' This is an ugly function that I have found useful for looking at
#' objects of various types
#' @param obj The object you wish to explore
#' @param nrowToShow Number of rows to show, defaults to 3
#' @param ncolToShow Number of cols to show, defaults to 4
#' @export
#' @examples
#' peek(matrix(1:12, nrow=3), nrow=2, ncol=2)
peek <- function(obj, nrowToShow=3, ncolToShow=4) {
    # peek at a matrix, vector, data.frame, or list
    # S3 objects are treated as normal lists (I think, see randomForest object as an example)
    d <- dim(obj)
    if (!is.null(d) && length(d) > 2) {
        cat("You are    trying to look at an object with >2 dimensions. I'm going to punt.\n")
        return()
    }
    if (typeof(obj) == "S4") {
        print(obj)  # use the S4 object's (hopefully) existing print method
    } else if (typeof(obj) == "list" && ! is.data.frame(obj)) {
        # peek at the first nrowToShow elements of the list
        nrowToShow <- min(nrowToShow, length(obj))
        for (i in 1:nrowToShow) {
            name <- ifelse(is.null(names(obj)), sprintf("element %d", i), names(obj)[i])
            cat(sprintf("%s:\n", name))
            peek(obj[[i]], nrowToShow=nrowToShow, ncolToShow=ncolToShow)
            cat("\n")
        }
        if (length(obj) - nrowToShow > 0) {
            cat(sprintf("... showing %d/%d elements of the list\n", nrowToShow, length(obj)))
        }
    } else if (is.null(nrow(obj))) {
        # obj is a vector
        if (length(obj) > nrowToShow) {
            print(head(obj, nrowToShow))
            cat(sprintf("... showing %d/%d values\n", nrowToShow, length(obj)))
        } else {
            print(obj)
        }
    } else {
        # obj is a matrix or data.frame - treat those in the same way
        x <- min(nrowToShow, nrow(obj))
        y <- min(ncolToShow, ncol(obj))
        print(obj[1:x, 1:y])
        moreRows <- nrow(obj) - x
        moreCols <- ncol(obj) - y
        if (moreRows > 0 || moreCols > 0) {
            cat(sprintf("... showing %d/%d rows and %d/%d columns\n",
                nrowToShow, nrow(obj), ncolToShow, ncol(obj)))
        }
    }
}
