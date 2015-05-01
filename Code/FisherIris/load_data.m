load iris.dat

class1 = iris((iris(:,5)==1),:);     
class1_labels = class1(:,5);
class1_data = class1(:,1:4);

class2 = iris((iris(:,5)==2),:);        
class2_labels = class2(:,5);
class2_data = class2(:,1:4);

class3 = iris((iris(:,5)==3),:);
class3_labels = class3(:,5);
class3_data = class3(:,1:4);


% Need to check if this split is fine.

train_indices = crossvalind('LeaveMOut',50,20);

class1_train = class1_data(train_indices,:);
class1_rest = class1_data(~train_indices,:);
class1_val = class1_rest(1:10,:);
class1_test = class1_rest(11:20,:);



train_indices = crossvalind('LeaveMOut',50,20);
class2_train = class2_data(train_indices,:);
class2_rest = class2_data(~train_indices,:);
class2_val = class2_rest(1:10,:);
class2_test = class2_rest(11:20,:);




train_indices = crossvalind('LeaveMOut',50,20);
class3_train = class3_data(train_indices,:);
class3_rest = class3_data(~train_indices,:);
class3_val = class3_rest(1:10,:);
class3_test = class3_rest(11:20,:);


% original way of doing.
% class1_train = class1_data(1:25,:);
% class1_val = class1_data(26:40,:);
% class1_test = class1_data(41:50,:);



train = class1_train;
target_train = ones(length(class1_train),1);

val = [class1_val; class2_val ; class3_val; ];
target_val = [ones(length(class1_val),1); ones(length(class2_val),1)*(-1); ones(length(class3_val),1)*(-1);];


test = [class1_test;    class2_test ; class3_test; ];
target_test = [ones(length(class1_test),1); ones(length(class2_test),1)*(-1); ones(length(class3_test),1)*(-1);];





train_unscaled = train;
val_unscaled = val;
test_unscaled = test;

% % Scale data
% 
% min_coord = zeros(size(train,2),1);
% max_coord = zeros(size(train,2),1);	
% 
% for i=1:size(train,2)
%     min_val = min(iris(:,i));
%     max_val = max(iris(:,i));
%     
%     min_coord(i) = min_val;
%     max_coord(i) = max_val;
%     
%     train(:,i) = (train(:,i)-min_val)/(max_val-min_val);
%     val(:,i) = (val(:,i)-min_val)/(max_val-min_val);
%     test(:,i) = (test(:,i)-min_val)/(max_val-min_val);
% end

class1 = [class1_train;class1_test;class1_val];
class2 = [class2_train;class2_test;class2_val];
class3 = [class3_train;class3_test;class3_val];

figure;
plot(class1(:,1),class1(:,2),'b.',class2(:,1),class2(:,2),'r.',class3(:,1),class3(:,2),'m.');
title('3 class Iris data');
xlabel('Sepal length');
ylabel('Sepal width');


figure;
plot(class1(:,3),class1(:,4),'b.',class2(:,1),class2(:,2),'r.',class3(:,1),class3(:,2),'m.');
title('3 class Iris data');
xlabel('Petal length');
ylabel('Petal width');
