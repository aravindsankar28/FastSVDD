The code in each of the folders contains 3 algorithms, svdd, fsvdd-1 and fsvdd-2 (fpt)

svdd_train is used to train the SVDD basic model.
fsvdd_train is used to train the F-SVDD-1 model with direct pre-image finding method.
fsvdd_train_fpt is used to train the F-SVDD-2 model with fixed point iteration method.

svdd_predict is used for prediction using basic SVDD model.
fsvdd_predict is used for prediction using basic F-SVDD model.(common for F-SVDD-1 and F-SVDD-2)

There are a few helper functions which are :

svkernel_new - computes kernel function given u,v and the rbf kernel param.
computeKgm - returns the kernel gram matrix for rbf kernel given the param and dataset X.
svtol - returns tolerance value for detecting support vectors.


load_data is a file which is different across the datasets, which is used to create train, val , test matrices etc.


Use the help <file_name> to determine what needs to be passed to these functions.


The remaining files are scripts which have been used for the purpose of testing and hence haven't been commented and do not have a help.

