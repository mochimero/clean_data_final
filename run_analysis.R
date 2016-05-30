old_dir<-getwd()
print("You should set the working directory as path")
library(stringr)



##Load the activity labels first
##they are stored in the activity_labels.txt file
# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING

activity_labels<-read.csv("activity_labels.txt",header=FALSE,sep='',stringsAsFactors = TRUE)


##Read the feature names, a 561 string list
##The 2nd column is the useful vector
## it extracts the names of the mean and standard deviation variables for body 
##acceleration XYZ, body Gyro XYZ and Gravity Acc XYZ

feature_names<-read.csv("features.txt",header=FALSE,sep='')
important_feature_names<-gsub("-","",feature_names[c(1,2,3,4,5,6,121,122,123,124,125,126,41,42,43,44,45,46),2])

##this removes the brackets or parenthesis in the names of the features
for(k in 1:length(important_feature_names)){
      vnd<-important_feature_names[k]
      vnd<-paste0(substr(vnd,1,nchar(vnd)-3),substr(vnd,nchar(vnd),nchar(vnd)))
      important_feature_names[k]<-vnd
        
}


folders<-c("train","test")

##creates 2 data frames to hold both sub sets 

train_df<-data.frame()
test_df<-data.frame()

for(i in 1:length(folders)){
        ##Reads the feature data, it contains the mean and std for 9 variables, 
        ##it stores the important features in features_stats
        setwd(folders[i])
        file_name<-paste0("X_",folders[i],".txt")
        data_features<-read.csv(file_name,sep='',header=FALSE)
        
        features_stats<-cbind(data_features[,1:6],data_features[,121:126],data_features[,41:46])
        
        ##Read the subjects file, a file with integers from 1 to 30 that act as labels
        ##for each of the subjects in the measurements
        file_name<-paste0("subject_",folders[i],".txt")
        data_subjects<-read.csv(file_name,sep='',header=FALSE)
        
        ##Read the activity labels for each measurement. It will be transformed into a
        ##data frame with strings substitutiing the integer label. The strings come from
        ##activity_labels data frame
        file_name<-paste0("y_",folders[i],".txt")
        data_activity<-read.csv(file_name,sep='',header=FALSE)
        
        ##changes the working directory and read the actual measurements
        ##contained in 9 files with 128 columns each
        setwd("Inertial Signals")
        files_to_load<-dir()
        dummy_df<-read.csv(files_to_load[1],sep='',header=FALSE)
        for(j in 2:length(files_to_load)){
                dummy_df<-cbind(dummy_df,read.csv(files_to_load[j],sep='',header=FALSE))
        }
        ##changes the integer for each activity for a string that describes the name 
        ##of the variable
        data_labels_as_factors<-data.frame()
        for(k in 1:dim(data_activity)[1]){
                data_labels_as_factors[k,1]<-tolower(sub("_","",activity_labels[data_activity[k,1],2]))
        }
        
        if(i==1){
                ## First pass with the train data set
              train_df<-cbind(data_labels_as_factors,data_subjects,features_stats,dummy_df)
              

        }
        
        if(i==2){
                ## Second loop pass with the test data set
                test_df<-cbind(data_labels_as_factors,data_subjects,features_stats,dummy_df)
                for(l in 1:length(files_to_load)){
                        files_to_load[l]<-substr(files_to_load[l],1,nchar(files_to_load[l])-9)
                        files_to_load[l]<-gsub("-","",files_to_load[l])
                }
               

        }
        
        
        setwd(old_dir)

}

##Setting the names of the final data frame full_df
measurement_names<-vector()
j<-1
for(k in 1:length(files_to_load)){
        for(i in 1:128){
                measurement_names[j]<-gsub("_","",paste0(files_to_load[k],as.character(i)))
                j<-j+1
        }
        
}

library(data.table)
all_tidy_variable_names<-c("activity","subject",important_feature_names,measurement_names)
full_df<-data.frame()
full_df<-rbind(train_df,test_df)
names(full_df)<-all_tidy_variable_names


##an extra data table is created
full_tbl<-tbl_df(full_df)


##all the objects are removed, except, of course, the data frame and the data table
rm(train_df,test_df,activity_labels,data_activity)
rm(data_labels_as_factors,dummy_df,feature_names)
rm(data_subjects,data_features,features_stats,measurement_names,files_to_load)
rm(important_feature_names,j,i,l,vnd,file_name,folders,k,old_dir)







