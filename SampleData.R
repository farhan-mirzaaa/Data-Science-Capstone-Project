#Load the data from US dataset
fCon <- file("Data\\en_US.twitter.txt", "rb")
twitterData <- readLines(con = fCon, encoding = "UTF-8", skipNul=TRUE)
close(fCon)

fCon <- file("Data\\en_US.blogs.txt", "rb")
blogsData <- readLines(con = fCon, encoding = "UTF-8", skipNul=TRUE)
close(fCon)

fCon <- file("Data\\en_US.news.txt", "rb")
newsData <- readLines(con = fCon, encoding = "UTF-8", skipNul=TRUE)
close(fCon)

#set the seed to 2020 so that when excuted in future, gives same results
set.seed(2020)
percentage <- 0.05
# taking 5% data from all three US files, due to processing limitations
print(length(twitterData)*percentage)
print(length(blogsData)*percentage)
print(length(newsData)*percentage)

subTwitterData <- sample(twitterData, size = length(twitterData)*percentage, replace = T)
subBlogsData <- sample(blogsData, size = length(blogsData)*percentage, replace = T)
subNewsData <- sample(newsData, size = length(newsData)*percentage, replace = T)

#stitch the data from three files and store it in single container
sample <- c(subTwitterData, subBlogsData, subNewsData)

#store the sample data in the separate file so that one can easily use this file later
writeLines(sample, "Data\\en_US.sample.txt")

rm(fCon)
rm(percentage)
rm(twitterData)
rm(blogsData)
rm(newsData)
rm(subTwitterData)
rm(subBlogsData)
rm(subNewsData)
rm(sample)