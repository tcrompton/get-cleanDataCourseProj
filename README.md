This README document describes the actions that the code in run_analysis.R performs

A temporary file is created. 
The data is downloaded and saved in the temp file,  the temp file is unzipped and saved in the current working directory. 

Creating the data frame: 
All the train data is read into R using read.table. The three tables are combined using cbind to form one large train dataset. this dataset contains 7352 rows and 563 cols. 
This process is reapeated for the test data. The test data has 2947 rows and 563 cols. 

The train and test data frames are coerced into one single data frame called "total".

Appropriately labelling the columns:
The column names of the total data frame are renamed according to the names used in the "features.txt". The first two columns of the data frame are "Subject" and "Activity" respectively. These columns are coerced into factors. At this stage, the total df contains all the measurement columns.

Extracting the mean & std columns:
The grep function was used to extract the columns from the total df that contained "mean()" or "std()". The outcome of these two grep functions as well as "Subject" and "Activity" are used to create the new df. The total df now contains 68 columns. 

Renaming the "Activity" factor levels:
The levels of the "Activity" variable in the total df were numbers and are changed to their actual meanings by using the indicator in the "activity_lables.txt" file. 

Calculating the mean of variables for each case:
The "reshape2" packages is installed and loaded. A melt df is created from the total df. the id columns are "Subject" and "Activity". the rest of the columns are the variable columns. 

The resulting melted df was passed in the dcast function. the dcast function calculates the mean for each of the variables for each of the different cases of the id variables. 

The resulting dcast table is written to a text file. 

