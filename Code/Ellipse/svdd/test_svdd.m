% Set c = 0.03 and g = 2

load_data;

ker = 'rbf';

bestcv =0;
best_C =0;
best_g =0;

%figure, imshow(mat2gray(K));
for log2g = -1:0.2:3
    K = computeKgm(train,ker,2^log2g);    
    for C = 0.2:0.02:0.4
    %for C = 0.008:0.004:0.06
    [svi, alpha,c] = svdd_train(train,K,ker,C,2^log2g); 
    [pred_train] = svdd_predict(train,train,ker,alpha,svi,c,2^log2g);
    [pred_test] = svdd_predict(train,test,ker,alpha,svi,c,2^log2g);
    
    ac_tr = sum(target_train == pred_train)/size(target_train,1);
    ac = sum(target_test == pred_test)/size(target_test,1);
    
    if (ac+ac_tr > bestcv),
          bestcv = ac+ac_tr; best_C = C; best_g = 2^log2g; 
    end
    fprintf('C=%g log2g=%g acc=%g (best C=%g, g=%g, acc=%g) \n', C, log2g, ac, best_C, best_g, bestcv);
    end
end


K = computeKgm(train,ker,best_g);
[svi, alpha,c] = svdd_train(train,K,ker,best_C,best_g);

[pred_train] = svdd_predict(train,train,ker,alpha,svi,c,best_g);
[pred_test] =svdd_predict(train,test,ker,alpha,svi,c,best_g);

fprintf('Train confusion matrix')
[C_train,order1] = confusionmat(target_train,pred_train);
C_train

fprintf('Train accuracy %g  \n',sum(target_train == pred_train)/size(target_train,1));


fprintf('Test confusion matrix')
[C_test,order3] = confusionmat(target_test,pred_test);

C_test


fprintf('Test accuracy %g  \n',sum(target_test == pred_test)/size(target_test,1));


best_C
best_g

xrange = [-1 1.5];
yrange = [-1 1.5];

inc = 0.01;
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2)); 
image_size = size(x); 
xy = [x(:) y(:)]; % make (x,y) pairs as a bunch of row vectors.

%Scale xy
% for i=1:size(xy,2)
%     xy(:,i) = (xy(:,i)-min_coord(i))/(max_coord(i)-min_coord(i));
% end

pred = svdd_predict(train,xy,ker,alpha,svi,c,best_g);


figure;
decisionmap = reshape(pred, image_size);
imagesc(xrange,yrange,decisionmap);
hold on;
set(gca,'ydir','normal');
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1; 0.6 0.7 1];
colormap(cmap);



plot(class1_data(:,1),class1_data(:,2),'b.');
hold on;
plot(class2_data(:,1),class2_data(:,2),'r.');


a = xlabel('$x_1$');
b = ylabel('$x_2$');
set(a,'Interpreter','latex');
set(b,'Interpreter','latex');
title('Decision region plot showing boundary between normal and abnormal classes for C-SVDD');


epsilon = svtol(best_C);
%epsilon = 10^-4;

svii = find( alpha > epsilon & alpha < (best_C - epsilon));
hold on;
%plot(train(svii,1),train(svii,2),'k.');

svi_bdd = find(alpha > best_C-epsilon & alpha < best_C+epsilon);
%plot(train(svi_bdd,1),train(svi_bdd,2),'g.');
hold on;
legend('Class 1','Class 2');
%legend('Non SVs','Unbounded SVs','Bounded SVs');
