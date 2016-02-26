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
#' @import ggplot2

library(extrafont)

hello <- function() {
  print("Hello, world!")
}

table_number <- function(label){
	if(exists("table_labels")){
		# figure_list does already exist
		if(!label%in%table_labels){
			cat("not assigned")
			# figure number not yet assigned
			table_labels[length(table_labels)+1] <<- label
		}
	} else {
		table_labels <<- c()
		table_labels[1] <<- label
	}
	which(table_labels==label)[1]
}

tr <- function(label){
	if(exists("table_labels")){
		# figure_list does already exist
		if(!label%in%table_labels){
			cat("not assigned")
			# figure number not yet assigned
			table_labels[length(table_labels)+1] <<- label
		}
	} else {
		table_labels <<- c()
		table_labels[1] <<- label
	}
	paste("Figure",which(figure_labels==label)[1])
}

figure_number <- function(label){
	if(exists("figure_labels")){
		# figure_list does already exist
		if(!label%in%figure_labels){
			cat("not assigned")
			# figure number not yet assigned
			figure_labels[length(figure_labels)+1] <<- label
		}
	} else {
		figure_labels <<- c()
		figure_labels[1] <<- label
	}
	which(figure_labels==label)[1]
}

fr <- function(label){
	if(exists("figure_labels")){
		# figure_list does already exist
		if(!label%in%figure_labels){
			cat("not assigned")
			# figure number not yet assigned
			figure_labels[length(figure_labels)+1] <<- label
		}
	} else {
		figure_labels <<- c()
		figure_labels[1] <<- label
	}
	paste("Figure",which(figure_labels==label)[1])
}

report <- function(toc = TRUE) {
	# get the locations of resource files located within the package
	css <- system.file("report/style.css", package = "JRformats")
	header <- system.file("report/header.html", package = "JRformats")
	knitr::opts_chunk$set(tidy=FALSE, warning=FALSE, message=FALSE, cache=FALSE,
								 comment=NA, verbose=TRUE, dpi=350,dev="png",wrap="main")
	knitr::knit_hooks$set(wrap = function(before, options, envir){
		if(options$wrap == "main_fig"){
			options$fig.width=4
			options$fig.height=3
			if (before){
				paste0('<div id="',options$label,'"  class="figure main_float"><p class="caption"><span class="figure_num"> Figure ',figure_number(options$label),'</span> ',options$fig.cap,'</p><div class="art">')
			} else {
				paste0('</div></div>')
			}
		} else if (options$wrap=="main_table") {
			if (before){
				paste0('<div id="',options$label,'" class="table main_float">
<p class="caption"><span class="figure_num"> Table ',table_number(options$label),'</span> ',options$fig.cap,'</p>
<div class="art">')
			} else {
				paste0('</div></div>')
			}

		} else if (options$wrap=="small_fig"){
			options$fig.width=2
			options$fig.height=1.5
			if (before){
				paste0('<div id="',options$label,'"  class="figure small_float"><p class="caption">',options$fig.cap,'</p><p class="art">')
			} else {
				paste0('</p></div>')
			}
		} else {
			if (before){
				paste0('<', options$wrap, '>')
			} else {
				paste0('</', options$wrap, '>')
			}
		}
	})

	# call the base html_document function
	rmarkdown::html_document(toc = toc,
													 fig_width = 6.5,
													 fig_height = 4,
													 fig.show='asis',
													 theme = NULL,
													 extra_dependencies = list(html_dependency_report(),
													 													 rmarkdown:::html_dependency_jquery()),
													 self_contained = F)
}


html_dependency_report <- function() {
	htmltools::htmlDependency(name = "report",
														version = "0.1",
														src = system.file("report", package="JRformats"),
														head = "<link href='https://fonts.googleapis.com/css?family=Gentium+Basic:400,400italic|Kreon:400,300' rel='stylesheet' type='text/css'>
",
														stylesheet = "style.css")
}


standard_theme <- function(){ggplot2::theme(plot.background = ggplot2::element_rect(fill = "#F3F3F3",size=0),
																 legend.background = ggplot2::element_rect(fill = "#F3F3F3"),
																 legend.key = ggplot2::element_rect(fill = "#FFFFFF"),
																 plot.margin = grid::unit(c(1,1,1,1), "mm"),
																 legend.position="bottom",
																 text=ggplot2::element_text(family="Gentium Plus"))}


