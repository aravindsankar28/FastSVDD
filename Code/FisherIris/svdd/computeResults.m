%C = 0.42;
C = 0.3;
%g =    0.001953125000000;
g = 0.005153125000000;
%g = 9.765625000000000e-04;

ker = 'rbf';

avg_err_rate = 0;
avg_train_err = 0;
avg_val_err = 0;
avg_test_err = 0;

for i = 1:10
    
load_data;
K = computeKgm(train,ker,g);
[svi, alpha,c] = svdd_train(train,K,ker,C,g);

[pred_train] = svdd_predict(train,train,ker,alpha,svi,c,g);
[pred_val] = svdd_predict(train,val,ker,alpha,svi,c,g);
[pred_test] =svdd_predict(train,test,ker,alpha,svi,c,g);


pred_train(find(pred_train == -1)) = 0;
pred_val(find(pred_val == -1)) = 0;
pred_test(find(pred_test == -1)) = 0;

target_train(find(target_train == -1)) = 0;
target_val(find(target_val == -1)) = 0;
target_test(find(target_test == -1)) = 0;

%CP_tr = classperf(target_train,pred_train);
CP_v = classperf(target_val,pred_val);
CP_t = classperf(target_test,pred_test);

%avg_train_err = avg_train_err + CP_tr.ErrorRate;
avg_val_err = avg_val_err + CP_v.ErrorRate;
avg_test_err = avg_test_err + CP_t.ErrorRate;

x = round(CP_v.ErrorRate * CP_v.NumberOfObservations) + round(CP_t.ErrorRate * CP_t.NumberOfObservations);
avg_err_rate = avg_err_rate + x/125;

end


t = cputime;
for i = 1:10
    [svi, alpha,c] = svdd_train(train,K,ker,C,g);
end
e = cputime -t;
fprintf('Training time - %g \n',e/10);



t = cputime;
for i = 1:10
    [pred_test] =svdd_predict(train,test,ker,alpha,svi,c,g);
end
e = cputime -t;
fprintf('Testing time - %g \n',e/10);

fprintf('TAE = %g \n',avg_err_rate/10);

fprintf('Avg val error = %g \n',avg_val_err/10);

fprintf('Avg test error = %g \n',avg_test_err/10);
