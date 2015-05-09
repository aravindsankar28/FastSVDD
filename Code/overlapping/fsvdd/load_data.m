class1_train = load('../../../Data/overlapping/class1_train.txt');
class2_train = load('../../../Data/overlapping/class2_train.txt');
class3_train = load('../../../Data/overlapping/class3_train.txt');
class4_train = load('../../../Data/overlapping/class4_train.txt');

class1_val = load('../../../Data/overlapping/class1_val.txt');
class2_val = load('../../../Data/overlapping/class2_val.txt');
class3_val = load('../../../Data/overlapping/class3_val.txt');
class4_val = load('../../../Data/overlapping/class4_val.txt');

class1_test = load('../../../Data/overlapping/class1_test.txt');
class2_test = load('../../../Data/overlapping/class2_test.txt');
class3_test = load('../../../Data/overlapping/class3_test.txt');
class4_test = load('../../../Data/overlapping/class4_test.txt');

% Class 1 as target class.
% train = class1_train;
% target_train = ones(length(class1_train),1);
% 
% val = [class1_val; class2_val ; class3_val;  class4_val ];
% target_val = [ones(length(class1_val),1); ones(length(class2_val),1)*(-1); ones(length(class3_val),1)*(-1);ones(length(class4_val),1)*(-1);];
% 
% 
% test = [class1_test;    class2_test ; class3_test;  class4_test ];
% target_test = [ones(length(class1_test),1); ones(length(class2_test),1)*(-1); ones(length(class3_test),1)*(-1);ones(length(class4_test),1)*(-1);];
% 
% train_rest = [class2_train; class3_train; class4_train];

% Class 2 as target class.
% train = class2_train;
% target_train = ones(length(class2_train),1);
% 
% val = [class1_val; class2_val ; class3_val;  class4_val ];
% target_val = [ones(length(class1_val),1)*(-1); ones(length(class2_val),1); ones(length(class3_val),1)*(-1);ones(length(class4_val),1)*(-1);];
% 
% 
% test = [class1_test;    class2_test ; class3_test;  class4_test ];
% target_test = [ones(length(class1_test),1)*(-1); ones(length(class2_test),1); ones(length(class3_test),1)*(-1);ones(length(class4_test),1)*(-1);];
% train_rest = [class1_train; class3_train; class4_train];

% Class 3 as target class.
% train = class3_train;
% target_train = ones(length(class3_train),1);
% 
% val = [class1_val; class2_val ; class3_val;  class4_val ];
% target_val = [ones(length(class1_val),1)*(-1); ones(length(class2_val),1)*(-1); ones(length(class3_val),1);ones(length(class4_val),1)*(-1);];
% 
% 
% test = [class1_test;    class2_test ; class3_test;  class4_test ];
% target_test = [ones(length(class1_test),1)*(-1); ones(length(class2_test),1)*(-1); ones(length(class3_test),1);ones(length(class4_test),1)*(-1);];
% train_rest = [class1_train; class2_train; class4_train];
% 
% % Class 4 as target class.
train = class4_train;
target_train = ones(length(class4_train),1);

val = [class1_val; class2_val ; class3_val;  class4_val ];
target_val = [ones(length(class1_val),1)*(-1); ones(length(class2_val),1)*(-1); ones(length(class3_val),1)*(-1);ones(length(class4_val),1);];


test = [class1_test;    class2_test ; class3_test;  class4_test ];
target_test = [ones(length(class1_test),1)*(-1); ones(length(class2_test),1)*(-1); ones(length(class3_test),1)*(-1); ones(length(class4_test),1);];
train_rest = [class1_train; class2_train; class3_train];

train_unscaled = train;
val_unscaled = val;
test_unscaled = test;

% Scale data

min_coord = zeros(size(train,2),1);
max_coord = zeros(size(train,2),1);	

for i=1:size(train,2)
    min_val = min(val(:,i));
    max_val = max(val(:,i));
    
    min_coord(i) = min_val;
    max_coord(i) = max_val;
    
    train(:,i) = (train(:,i)-min_val)/(max_val-min_val);
    val(:,i) = (val(:,i)-min_val)/(max_val-min_val);
    test(:,i) = (test(:,i)-min_val)/(max_val-min_val);
end

class1 = [class1_train;class1_test;class1_val];
class2 = [class2_train;class2_test;class2_val];
class3 = [class3_train;class3_test;class3_val];
class4 = [class4_train;class4_test;class4_val];

plot(class1(:,1),class1(:,2),'b.',class2(:,1),class2(:,2),'r.',class3(:,1),class3(:,2),'m.',class4(:,1),class4(:,2),'g.');
title('bivariate 4 class data');
xlabel('x');
ylabel('y');