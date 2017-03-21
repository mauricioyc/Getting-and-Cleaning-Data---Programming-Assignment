### Getting and Cleaning Data - Programming Assingnment

This is the project from the Getting and Cleaning data course. The purpose off this project is to get the raw data from this experiment:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

clean this dataset and present a final manipulated independent dataset. All this process is done through the ```sh run_analysis.R ``` program as follows:

1) The program download the dataset
2) Reads the data from the train and test experiments and merge them
3) Select only the features that represent mean and standard deviation
4) Create a tidy dataset with the mean of each feature grouped by subject and activity

You need the dply package installed for the ```sh run_analysis.R ```  to work.