load_data;

ker = 'rbf';

bestcv =0;
best_C =0;
best_g =0;

%figure, imshow(mat2gray(K));

% Fixing the values of C and gamma 

%for log2g = 2:1:2
for g = 4.4:1:4.4
    K = computeKgm(train,ker,g);    
    for C = 0.04:1:0.04
    %for C = 0.03:0.001:0.05
    
    %for C = 0.008:0.004:0.04
    [svi, alpha,c_prime,gamma_f,x_hat] = fsvdd_train_fpt(train,K,C,g); 
    [pred_val] = fsvdd_predict(val,ker,c_prime,g,gamma_f,x_hat);
    ac = sum(target_val == pred_val)/size(target_val,1);
    ac
    if (ac >= bestcv),
          bestcv = ac; best_C = C; best_g = g; 
    end
    fprintf('C=%g g=%g acc=%g (best C=%g, g=%g, acc=%g) \n', C, g, ac, best_C, best_g, bestcv);
    end
end


t= cputime;
K = computeKgm(train,ker,best_g);
[svi, alpha,c_prime,gamma_f,x_hat] = fsvdd_train_fpt(train,K,best_C,best_g); 
e = cputime-t;
fprintf('Training time - %g\n',e);




[pred_train] =fsvdd_predict(train,ker,c_prime,best_g,gamma_f,x_hat);
[pred_val] = fsvdd_predict(val,ker,c_prime,best_g,gamma_f,x_hat);

t = cputime;
for i = 1:10
    [pred_test] =fsvdd_predict(test,ker,c_prime,best_g,gamma_f,x_hat);
end
e = cputime-t;

fprintf('Testing time - %g\n',e/10);
fprintf('Train confusion matrix')
[C_train,order1] = confusionmat(target_train,pred_train);
C_train

fprintf('Train accuracy %g  \n',sum(target_train == pred_train)/size(target_train,1));
fprintf('Validation confusion matrix')
[C_val,order2] = confusionmat(target_val,pred_val);
C_val

fprintf('Val accuracy %g  \n',sum(target_val == pred_val)/size(target_val,1));
fprintf('Test confusion matrix')
[C_test,order3] = confusionmat(target_test,pred_test);

C_test
fprintf('Test accuracy %g  \n',sum(target_test == pred_test)/size(target_test,1));

best_C
best_g
% Decn. region.

xrange = [-6 12];
yrange = [-6 12];

inc = 0.1;
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2)); 
image_size = size(x); 
xy = [x(:) y(:)]; % make (x,y) pairs as a bunch of row vectors.

%Scale xy
for i=1:size(xy,2)
    xy(:,i) = (xy(:,i)-min_coord(i))/(max_coord(i)-min_coord(i));
end

pred = fsvdd_predict(xy,ker,c_prime,best_g,gamma_f,x_hat);


figure;
decisionmap = reshape(pred, image_size);
imagesc(xrange,yrange,decisionmap);
hold on;
set(gca,'ydir','normal');
cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1; 0.6 0.7 1];
colormap(cmap);


plot(train_unscaled(:,1),train_unscaled(:,2),'b.');

a = xlabel('$x_1$');
b = ylabel('$x_2$');
set(a,'Interpreter','latex');
set(b,'Interpreter','latex');
title('Decision region plot showing boundary between normal and abnormal classes for FSVDD - 2');


epsilon = svtol(best_C);
%epsilon = 10^-4;

svii = find( alpha > epsilon & alpha < (best_C - epsilon));
hold on;
plot(train_unscaled(svii,1),train_unscaled(svii,2),'k.');

svi_bdd = find(alpha > best_C-epsilon & alpha < best_C+epsilon);
plot(train_unscaled(svi_bdd,1),train_unscaled(svi_bdd,2),'g.');
hold on;
plot(x_hat(1)*(max_coord(1)-min_coord(1)) + min_coord(1),x_hat(2)*(max_coord(2)-min_coord(2)) + min_coord(2),'k*');
hold on;
plot(train_rest(:,1),train_rest(:,2),'r.');
legend('Non SVs','Unbounded SVs','Bounded SVs','Agent of center','Remaining points');

%svi_bdd