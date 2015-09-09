rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.

# ---- load_sources ----
#Load any source files that contain/define functions, but that don't load any other types of variables
#   into memory.  Avoid side effects and don't pollute the global environment.
# source("./SomethingSomething.R")
# browser()

# ---- load_packages ----
# library(xtable)
library(knitr) #devtools::install_github("yihui/knitr")
library(scales) #For formating values in graphs
library(RColorBrewer)
# library(reshape2) #For converting wide to long
library(ggplot2) #For graphing
# library(mgcv, quietly=TRUE) #For the Generalized Additive Model that smooths the longitudinal graphs.

# ---- declare_globals ----
options(show.signif.stars=F) #Turn off the annotations on p-values

pathInput <- "./data_phi_free/raw/house.csv"
# pathInput <- "/home/wibeasley/GitHub/HousePrediction/data_phi_free/raw/house.csv"
pathInput <- "D:/Users/Will/Documents/GitHub/HousePrediction/data_phi_free/raw/house.csv"

HistogramDiscrete <- function(
  dsObserved,
  variableName,
  levelsToExclude    = character(0),
  mainTitle          = variableName,
  xTitle             = NULL,
  yTitle             = "Number of Included Records",
  textSizePercentage = 6,
  binWidth           = 1L) {

  if( !base::is.factor(dsObserved[, variableName]) )
    dsObserved[, variableName] <- base::factor(dsObserved[, variableName])

  dsObserved$IV <- base::ordered(dsObserved[, variableName], levels=rev(levels(dsObserved[, variableName])))

  dsCount <- plyr::count(dsObserved, vars=c("IV"))
#   if( base::length(levelsToExclude)>0 ) {
  dsCount <- dsCount[!(dsCount$IV %in% levelsToExclude), ]

  dsSummary <- plyr::ddply(dsCount, .variables=NULL, transform, Count=freq, Proportion = freq/sum(freq) )
  dsSummary$Percentage <- base::paste0(base::round(dsSummary$Proportion*100), "%")

  yTitle <- base::paste0(yTitle, " (n=", scales::comma(base::sum(dsSummary$freq)), ")")

  g <- ggplot2::ggplot(dsSummary, ggplot2::aes_string(x="IV", y="Count", fill="IV", label="Percentage"))
  g <- g + ggplot2::geom_bar(stat="identity")
  g <- g + ggplot2::geom_text(stat="identity", size=textSizePercentage, hjust=.8)
  g <- g + ggplot2::scale_y_continuous(labels=scales::comma_format())
  g <- g + ggplot2::labs(title=mainTitle, x=xTitle, y=yTitle)
  g <- g + ggplot2::coord_flip()

  g <- g + ggplot2::theme_bw(base_size=14)
  g <- g + ggplot2::theme(legend.position = "none")
  g <- g + ggplot2::theme(axis.text.x=ggplot2::element_text(colour="gray40"))
  g <- g + ggplot2::theme(axis.title.x=ggplot2::element_text(colour="gray40"))
  g <- g + ggplot2::theme(axis.text.y=ggplot2::element_text(size=14))
  g <- g + ggplot2::theme(panel.border = ggplot2::element_rect(colour="gray80"))
  g <- g + ggplot2::theme(axis.ticks.length = grid::unit(0, "cm"))

  return( g )
}
HistogramContinuous <- function(
  dsObserved,
  variableName,
  binWidth      = NULL,
  mainTitle     = variableName,
  xTitle        = paste0(variableName, " (each bin is ", scales::comma(binWidth), " units wide)"),
  yTitle        = "Frequency",
  roundedDigits = 0L
  ) {

  dsObserved <- dsObserved[!base::is.na(dsObserved[, variableName]), ]

  ds_mid_points <- base::data.frame(label=c("italic(X)[50]", "bar(italic(X))"), stringsAsFactors=FALSE)
  ds_mid_points$value <- c(stats::median(dsObserved[, variableName]), base::mean(dsObserved[, variableName]))
  ds_mid_points$value_rounded <- base::round(ds_mid_points$value, roundedDigits)

  g <- ggplot2::ggplot(dsObserved, ggplot2::aes_string(x=variableName))
  g <- g + ggplot2::geom_bar(stat="bin", binwidth=binWidth, fill="gray70", color="gray90", position=ggplot2::position_identity())
  g <- g + ggplot2::geom_vline(xintercept=ds_mid_points$value, color="gray30")
  g <- g + ggplot2::geom_text(data=ds_mid_points, ggplot2::aes_string(x="value", y=0, label="value_rounded"), color="tomato", hjust=c(1, 0), vjust=.5)
  g <- g + ggplot2::scale_x_continuous(labels=scales::comma_format())
  g <- g + ggplot2::scale_y_continuous(labels=scales::comma_format())
  g <- g + ggplot2::labs(title=mainTitle, x=xTitle, y=yTitle)
  g <- g + ggplot2::theme_bw()

  ds_mid_points$top <- stats::quantile(ggplot2::ggplot_build(g)$panel$ranges[[1]]$y.range, .8)
  g <- g + ggplot2::geom_text(data=ds_mid_points, ggplot2::aes_string(x="value", y="top", label="label"), color="tomato", hjust=c(1, 0), parse=TRUE)
  return( g )
}

# ---- load_data ----
ds <- read.csv(pathInput, stringsAsFactors=T) # 'ds' stands for 'datasets'

# ---- tweak_data ----
ds$PriceMissing <- is.na(ds$PriceSold)

# ---- marginals ----
HistogramContinuous(dsObserved=ds, variableName="HouseSqFt", binWidth=400, roundedDigits=0) +
  geom_vline(x=ds$HouseSqFt[ds$PriceMissing], linetype=3)

HistogramContinuous(dsObserved=ds, variableName="LandSqFt", binWidth=5000, roundedDigits=0) +
  geom_vline(x=ds$LandSqFt[ds$PriceMissing], linetype=3)

HistogramContinuous(dsObserved=ds, variableName="PriceSold", binWidth=50000, roundedDigits=0)

# HistogramDiscrete(dsObserved=ds, variableName="ForwardGearCountF")

# ---- scatterplots ----
g1 <- ggplot(ds, aes(x=HouseSqFt, y=PriceSold, color=NULL, shape=NULL)) +
  geom_smooth(method="loess", span=2, na.rm=T) +
  geom_point(na.rm=T) +
  scale_color_brewer(palette = "Dark2") +
  theme_bw()
g1 + geom_vline(x=ds$HouseSqFt[ds$PriceMissing], linetype=3)

g1 %+% aes(x=LandSqFt) +
  geom_vline(x=ds$LandSqFt[ds$PriceMissing], linetype=3)

g1 %+% aes(x=HouseSqFt, y=LandSqFt, color=PriceMissing, shape=PriceMissing) +
  theme(legend.position=c(.7,1), legend.justification=c(1,1))

# ---- models ----

cat("============= Simple model that's just an intercept. =============")
m0 <- lm(PriceSold ~ 1 + HouseSqFt + LandSqFt, data=ds)
summary(m0)
predict.lm(m0, ds[ds$PriceMissing, ])

m1 <- lm(PriceSold ~ 1 + HouseSqFt*LandSqFt, data=ds)
summary(m1)
predict.lm(m1, ds[ds$PriceMissing, ])

library(scatterplot3d)
s3d <- scatterplot3d(
  ds$HouseSqFt, ds$LandSqFt, ds$PriceSold,
  pch=16, highlight.3d=TRUE, type="h",
  angle=-31,
  # angle=80,
  main="3D Scatterplot"
)
s3d$plane3d(m0)
# **Note 1**: The current report covers `r nrow(ds)` houses.
