README

run_analysis.R combines subject and activity data to each of the X_train and X_test data files. Variable names are recreated such that there are no duplicates. It then merges x_train and x_test data files into a single file. The activity code is replaced by activity name, and the variables that contain "mean" and "std" are retrieved. The mean is then calculated for each variable for each activity for each subject and creates a text file. 
