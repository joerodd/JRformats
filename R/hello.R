# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

#' @export
#' @import rmarkdown
#' @import htmltools

hello <- function() {
  print("Hello, world!")
}


report <- function(toc = TRUE) {

	# get the locations of resource files located within the package
	css <- system.file("report/style.css", package = "JRformats")
	header <- system.file("report/header.html", package = "JRformats")

	# call the base html_document function
	rmarkdown::html_document(toc = toc,
													 fig_width = 6.5,
													 fig_height = 4,
													 theme = NULL,
													 css = css,
													 self_contained = F)
}
