load('ellipse.mat');
class1_data = z(1:200,:);
class2_data = z(201:400,:);

class1_train = class1_data(1:150,:);

class1_test = class1_data(151:200,:);

train = class1_train;
target_train = ones(size(train,1),1);

test = [class1_test; class2_data];
target_test = [ones(size(class1_test,1),1) ; ones(size(class2_data,1),1)*(-1) ];


plot(class1_data(:,1),class1_data(:,2),'b.');
hold on;
plot(class2_data(:,1),class2_data(:,2),'r.');
xlabel('x');
ylabel('y');
title('Ellipse shaped 2 class data');


