# GCD_Project
Project repo for Getting &amp; Cleaning Data

run_Analysis.R script is broken down into 10 phases

  Phase  1:  Verify all required packages are installed
  
  Phase  2:  Check for existing directory and create as needed
  
  Phase  3:  Download the data and unzip
  
  Phase  4:  Read in all required data sets -- initially split into test and train data sets
  
  Phase  5:  Apply activity labels to test and train data sets
  
  Phase  6:  Combine subject ID and activity ID to measurement test and train data sets
  
  Phase  7:  Append test and train data sets into a single table then apply column headers
  
  Phase  8:  Pare data set down to record identifiers and only attributes of interest (Means & STD's)
  
  Phase  9:  Aggregate Means & STDs by subject by activity by taking average of each variable
  
  Phase 10:  Write resulting tidy data set to text file
  
Each phase has comments preceding the associated code tracked to this readme file  
