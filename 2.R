x <- read.table("pytorch.delta.gz", sep=";", comment.char="", quote="", col.names=c("prj", "v","tree","parent","an","cn","ae","ce","nadd","at","ct", "f","msg"), colClasses=c(rep("character",12)))
# x
x$at <- as.numeric(x$at)
x$ct <- as.numeric(x$ct)
# x
x$y <- floor(x$at/3600/24/365.25+1970)
x$q <- floor(x$at/3600/24/365.25*4)/4+1970
x$m <- floor(x$at/3600/24/365.25*12)/12+1970
# x
x$f <- as.character(x$f)
x$ff <- sub(".*/", "", x$f, perl=TRUE, useBytes=TRUE)
x$ext <- tolower(sub(".*\\.", "", x$ff, perl=TRUE, useBytes=TRUE))

tmp <- x$f
tmp1 <- sub("/.*", "", as.character(tmp), perl=TRUE, useBytes=TRUE)
x$mod <- tmp1
x$ty <- x$at/3600/24/365.25+1970
x$l <- as.character(x$an)

delta <- x
delta$accum <- rep(0, dim(delta)[1])
for (h in names(table(delta$l))) {
   ii <- delta$l == h
   o <- order(delta$at[ii])
   delta$accum[ii][o] <- 1:(sum(ii))
}

tmin <- tapply(delta$ty, delta$an, min, na.rm=TRUE)
delta$frC <- NA
for(nn in names(tmin)) {
   id <- delta$l == nn
   delta$frC[id] <- tmin[nn]
}

delta$tenure <- delta$ty - delta$frC
c(mean(delta$tenure), median(delta$tenure))

# delta_filtered <- delta[!grepl("bot", tolower(delta$an)), ]
# delta_filtered <- delta_filtered[!grepl("onnxbot", tolower(delta$an)), ]
# delta_filtered <- delta_filtered[!grepl("pytorchmergebot", tolower(delta$an)), ]
# delta_filtered <- delta_filtered[!grepl("facebook-github-bot", tolower(delta$an)), ]
# delta_filtered <- delta_filtered[!grepl("pytorch-bot[bot]", tolower(delta$an)), ]
# delta_filtered <- delta_filtered[!grepl("pytorchbot", tolower(delta$an)), ]
# delta_filtered <- delta_filtered[!grepl("pytorchupdatebot", tolower(delta$an)), ]
# delta_filtered <- delta_filtered[!grepl("dependabot[bot]", tolower(delta$an)), ]

bots <- c("pytorchmergebot", "onnxbot", "facebook-github-bot","PyTorch UpdateBot","Facebook Community Bot","CodemodService Bot","Open Source Bot","Facebook GitHub Bot","CodemodService FBSourceBuckFormatLinterBot", "CodemodService FBSourceClangFormatLinterBot", "CodemodService FBSourceGoogleJavaFormatLinterBot", "CodemodService FBSourceBlackLinterBot", "pytorch-bot[bot]", "pytorchbot", "pytorchupdatebot", "dependabot[bot]")
delta_filtered <- delta[!(tolower(delta$an) %in% tolower(bots)), ]


name <- as.factor(names(table(delta_filtered$an)))
dvpr <- data.frame(name)

# 使用过滤后的delta_filtered来计算其它统计
dvpr$fr <- tapply(delta_filtered$frC, delta_filtered$an, min, na.rm=TRUE)
dvpr$to <- tapply(delta_filtered$ty, delta_filtered$an, max, na.rm=TRUE)
dvpr$accum <- tapply(delta_filtered$accum, delta_filtered$an, max, na.rm=TRUE)
dvpr$tenure <- dvpr$to - dvpr$fr
dvpr$nm <- floor(dvpr$tenure*12) + 1

# 显示结果
# dvpr

# 如果你想查看排名前5的贡献者基于tenure
head(dvpr[order(-dvpr$tenure), ], 5)

head(dvpr[order(-dvpr$accum), ], 5)
if(!require(ggplot2)){
  install.packages("ggplot2")
  require(ggplot2)
}

ggplot(dvpr, aes(x = tenure)) +
  geom_histogram(binwidth = 2, fill = "blue", color = "blue") +
  scale_y_log10() +  # This will transform the y-axis to a log scale
  labs(x = "Developer Tenure (months)", y = "Frequency", title = "Histogram of Developer Tenure") +
  theme_minimal()

ggplot(dvpr, aes(x = accum)) +
  geom_histogram(binwidth = 2, fill = "blue", color = "blue") +
  scale_y_log10() +  # This will transform the y-axis to a log scale
  labs(x = "Developer Commits (months)", y = "Frequency", title = "Histogram of Developer Commits") +
  theme_minimal()