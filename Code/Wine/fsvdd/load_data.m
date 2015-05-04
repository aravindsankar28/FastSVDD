data = load('../../../Data/Wine/wine.data');

X = data(:,2:14);
labels = data(:,1);

class1_data = data(find(labels == 1),:);
class2_data = data(find(labels == 2),:);
class3_data = data(find(labels == 3),:);

% retain 50 % of data  as train.
train_indices = crossvalind('HoldOut',size(class1_data,1),0.51);
class1_train = class1_data(train_indices,:);
class1_rest = class1_data(~train_indices,:);
class1_val_ind = crossvalind('HoldOut',size(class1_rest,1),0.5);
class1_val = class1_rest(class1_val_ind,:);
class1_test = class1_rest(~class1_val_ind,:);


train_indices = crossvalind('HoldOut',size(class2_data,1),0.51);
class2_train = class2_data(train_indices,:);
class2_rest = class2_data(~train_indices,:);
class2_val_ind = crossvalind('HoldOut',size(class2_rest,1),0.5);
class2_val = class2_rest(class2_val_ind,:);
class2_test = class2_rest(~class2_val_ind,:);


train_indices = crossvalind('HoldOut',size(class3_data,1),0.5);
class3_train = class3_data(train_indices,:);
class3_rest = class3_data(~train_indices,:);
class3_val_ind = crossvalind('HoldOut',size(class3_rest,1),0.5);
class3_val = class3_rest(class3_val_ind,:);
class3_test = class3_rest(~class3_val_ind,:);

% Created train, test, val splits for each class.

%save('data.mat');

%load('data.mat');

% Creating train, val and test - for target class as class 1 

train = class1_train;
target_train = ones(length(class1_train),1);

val = [class1_val; class2_val ; class3_val;];
target_val = [ones(size(class1_val,1),1); ones(size(class2_val,1),1)*(-1); ones(size(class3_val,1),1)*(-1);];

test = [class1_test; class2_train; class2_test ; class3_train; class3_test; ];
target_test = [ones(size(class1_test,1),1); ones(size(class2_train,1),1)*(-1); ones(length(class2_test),1)*(-1); ones(length(class3_train),1)*(-1); ones(size(class3_test,1),1)*(-1);];

% target class - 2
% 
% train = class2_train;
% target_train = ones(length(class2_train),1);
% 
% val = [class1_val; class2_val ; class3_val;];
% target_val = [ones(size(class1_val,1),1)*(-1); ones(size(class2_val,1),1); ones(size(class3_val,1),1)*(-1);];
% 
% test = [class1_train; class1_test; class2_test ; class3_train; class3_test; ];
% target_test = [ones(size(class1_train,1),1)*(-1); ones(size(class1_test,1),1)*(-1);  ones(length(class2_test),1); ones(length(class3_train),1)*(-1); ones(size(class3_test,1),1)*(-1);];


% target class - 3

% train = class3_train;
% target_train = ones(length(class3_train),1);
% 
% val = [class1_val; class2_val ; class3_val;];
% target_val = [ones(size(class1_val,1),1)*(-1); ones(size(class2_val,1),1)*(-1); ones(size(class3_val,1),1);];
% 
% test = [class1_train ; class1_test; class2_train; class2_test ;class3_test; ];
% target_test = [ones(size(class1_train,1),1)*(-1); ones(size(class1_test,1),1)*(-1); ones(size(class2_train,1),1)*(-1); ones(length(class2_test),1)*(-1);  ones(size(class3_test,1),1);];
