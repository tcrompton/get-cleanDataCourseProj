temp <- tempfile()
#downloading the data
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
#unzipping the temp file and saving it in the current working directory
#unzip(temp)

################1.Creating the data frame #######################

#reading in the train data
#reading in the X_train data
trainX <- read.table("UCI HAR Dataset/train/X_train.txt")
#reading in the Y_train data
trainY <- read.table("UCI HAR Dataset/train/y_train.txt")
#reading in the subject train data
subj_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

#combining the three tables into one train data frame
train <- cbind(subj_train, trainY, trainX)

#reading in the test data
#reading in the X_test data
testX <- read.table("UCI HAR Dataset/test/X_test.txt")
#reading in the Y_test data
testY <- read.table("UCI HAR Dataset/test/y_test.txt")
#reading in the subject test data
subj_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

#combining the three tables into one test data frame
test <- cbind(subj_test, testY, testX)

##combining the train and test data frames
total <- rbind(train,test)

#reading in the features
feat <- read.table("UCI HAR Dataset/features.txt")

#renaming the columns of the total data frame
names(total) = c("Subject", "Activity", as.character(feat[,2]))

#converting the "Subject" and "Acticvity" columns to factors
total$Subject = as.factor(total$Subject)
total$Activity = as.factor(total$Activity)

################2.Extracting mean & std columns#########################
#columns that contain a mean calculation
mean_col <- grep("mean()",colnames(total), fixed=TRUE)
#columns that contain std calculation
std_col <- grep("std()", colnames(total))
#create a vector of only columns needed
cols_reqd <- c(1, 2, mean_col, std_col)
#trimming the total data frame to only columns of interest
total <- total[, cols_reqd]

###########3. Renaming the factor levels ###############

levels(total$Activity) <- c("1"="WALKING", "2"="WALKING_UPSTAIRS", 
                            "3"="WALKING_DOWNSTAIRS", "4"="SITTING", "5"="STANDING",
                            "6"="LAYING")

############4. Describing Variable Names###########


##########5. Calculating the mean of variables for each case ##########
library(reshape2)
totalMelt <- melt(total, id=c("Subject", "Activity"), 
                  measure.vars=colnames(total)[-c(1,2)])
totalDCast <- dcast(totalMelt, Subject + Activity ~ variable, mean)
write.table(totalDCast, "q5TidyTable.txt", row.names=FALSE)
