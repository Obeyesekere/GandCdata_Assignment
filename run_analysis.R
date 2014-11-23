features <- read.table(file="features.txt", header=F, stringsAsFactors=F)

#load in test data and combine them into one dataframe
y_test <- read.table(file="y_test.txt", header=F, col.names = "activity_name")
x_test <- read.table(file="X_test.txt", header=F)
colnames(x_test) <- features$V2
subject_test <- read.table(file="subject_test.txt", header=F, col.names="student_ID")
test_data <- cbind(subject_test, y_test, x_test)

#load in train data and combine them into one dataframe
y_train <- read.table(file="y_train.txt", header=F, col.names="activity_name")
x_train <- read.table(file="X_train.txt", header=F)
colnames(x_train) <- features$V2
subject_train <- read.table(file="subject_train.txt", header=F, col.names="student_ID")
train_data <- cbind(subject_train, y_train, x_train)

#combine the test and train dataframes 
data <- rbind(test_data,train_data)

#Use descriptive activity names to name the activities in the data set
activities <- read.table(file="activity_labels.txt",header=F,stringsAsFactors=F)
for (i in 1:6){
      data$activity_name[data$activity_name == i] <- activities[i,2]
}

#Extract only the measurements on the mean and standard deviation for each measurement.
#Note: I've interpreted this as requiring variables that have the parentheses: eg mean() and std()
#instead of any column name that includes 'mean' or 'std'. 
data <- data[,grep("student_ID|activity_name|mean\\(\\)|std\\(\\)", colnames(data))]

#create a new empty dataframe
newdata <- as.data.frame(setNames(replicate(68,numeric(0), simplify = F), letters[1:68]))
colnames(newdata) <- colnames(data) #give the new dataframe the appropriate column headings 
row_counter <- as.integer(0) #this counter will keep track of row number when storing data in the loop

for (j in 1:30){
      stu_data <- data[data$student_ID == j,] # get all records for a given student ID
      
      for (k in activities$V2){
            row_counter <- row_counter + 1
            stu_act_data <- stu_data[stu_data$activity_name == k,]  # get all records for a given activity
            
            columnMeans <- colMeans(stu_act_data[,3:68]) #get the corresponding averages for all measurements 
            newdata[row_counter,3:68] <- columnMeans #store these in the new dataset
            newdata[row_counter,1] <- j #also store the student_ID
            newdata[row_counter,2] <- k #also store the activity_name            
      }
}

write.table(newdata, "newdata.txt", row.name=FALSE)
