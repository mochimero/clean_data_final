##It must be run AFTER the run_analysis R script
##It will use a data frame created in this previous step
##If you run before running run_analysis.R , it will give you an error message


activities<-unique(full_df[,1])
subjects<-1:30
subjects<-unique(full_df[,2])
dummy_rows<-data.frame()
dummy_row<-data.frame()
tidy_data<-data.frame()
j<-1
var_names<-names(full_df[,21:1172])
for(k in 1:length(activities)){

        for(i in 1:length(subjects)){
                dummy_rows<-filter(full_tbl,activity==activities[k],subject==i)
                dummy_row<-data.frame(c(activities[k],i,lapply(dummy_rows[,21:1172],mean)))
                names(dummy_row)<-c("activity","subject",var_names)
                
                if(j==1){
                        
                        tidy_data<-dummy_row
                        
                }
                else{
                        tidy_data<-rbind(tidy_data,dummy_row)
                        
                }

                j<-j+1
        }
}
print("the tidy_data data frame contains the tidy set where each column from 3 to 1154 is the mean of each variable")
rm(dummy_rows,dummy_row,activities,subjects,var_names,all_tidy_variable_names,i,j,k)