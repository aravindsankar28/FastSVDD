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
train_data = [ class1_train; ];
target_train = ones(length(class1_train),1);

val_data = [class1_val; class2_val ; class3_val;  class4_val ];
target_val = [ones(length(class1_val),1); zeros(length(class2_val),1)*(-1); zeros(length(class3_val),1)*(-1);zeros(length(class4_val),1)*(-1);];


test_data = [class1_test;    class2_test ; class3_test;  class4_test ];
target_test = [ones(length(class1_test),1); zeros(length(class2_test),1)*(-1); zeros(length(class3_test),1)*(-1);zeros(length(class4_test),1)*(-1);];


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

% Class 4 as target class.
% train = class4_train;
% target_train = ones(length(class4_train),1);
% 
% val = [class1_val; class2_val ; class3_val;  class4_val ];
% target_val = [ones(length(class1_val),1)*(-1); ones(length(class2_val),1)*(-1); ones(length(class3_val),1)*(-1);ones(length(class4_val),1);];
% 
% 
% test = [class1_test;    class2_test ; class3_test;  class4_test ];
% target_test = [ones(length(class1_test),1)*(-1); ones(length(class2_test),1)*(-1); ones(length(class3_test),1)*(-1); ones(length(class4_test),1);];
% 
% 
train_unscaled = train_data;
val_unscaled = val_data;
test_unscaled = test_data;

% Scale data

min_coord = zeros(size(train_data,2),1);
max_coord = zeros(size(train_data,2),1);	

for i=1:size(train_data,2)
    min_val = min(val_data(:,i));
    max_val = max(val_data(:,i));
    
    min_coord(i) = min_val;
    max_coord(i) = max_val;
    
    train_data(:,i) = (train_data(:,i)-min_val)/(max_val-min_val);
    val_data(:,i) = (val_data(:,i)-min_val)/(max_val-min_val);
    test_data(:,i) = (test_data(:,i)-min_val)/(max_val-min_val);
end

data_input = [train_data; val_data; test_data];
data_target = [target_train; target_val; target_test];

class1 = [class1_train;class1_test;class1_val];
class2 = [class2_train;class2_test;class2_val];
class3 = [class3_train;class3_test;class3_val];
class4 = [class4_train;class4_test;class4_val];
% 
% plot(class1(:,1),class1(:,2),'b.',class2(:,1),class2(:,2),'r.',class3(:,1),class3(:,2),'m.',class4(:,1),class4(:,2),'g.');
% title('bivariate 4 class data');
% xlabel('x');
% ylabel('y');