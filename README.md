The attached R script uses two data sets (train and test) from Samsung data which measures the activity
of the studied persons either walking or walking upstairs or walking downstairs.

The data on means and standard deviations measurements only were subsetted.

Then, the two sets were merged to create one data set after adding the appropriate column names based on
the description included with the data set.

Finally, the mean for each subject and each variable were calculated and stored in a new tidy data set.
The columns name of the new data set were changed to be more descriptive (see the code book below).

The tidy data set was printed out on a .txt file to be used in other purposes.

##CODE BOOK...

The tidy data set consists of 6 rows each represent a studied person coded using numbers from 1 to 6.
Moreover, it contains 87 rows each of them represent a variable. The variable names were created based on the following rules:
1. ID -> represents the studied subject number.
2. X -> means the activity measurement in the WALKING state.
3. Y -> means the activity measurement in the WALKING UPSTAIRS or WALIKNG DOWNSTAIRS state.
4. Z -> means the activity measurement in the sitting, STANDING, or LAYING state.
5. Transformes -> means that the values of these variables comes from a Fast Fourier Transform.
6. Angle -> means that the values of these variables comes from the angle between the two stated vectors.