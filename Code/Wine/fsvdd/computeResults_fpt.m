C = 0.35;
%g = 2.629394531250000e-6;
%g =1.5259e-05;
 g = 0.0052;
ker = 'rbf';

avg_err_rate = 0;
avg_train_err = 0;
avg_val_err = 0;
avg_test_err = 0;

for i = 1:20
    
load_data;
K = computeKgm(train,ker,g);
[svi, alpha,c_prime,gamma_f,x_hat] = fsvdd_train_fpt(train,K,C,g); 

[pred_train] =fsvdd_predict(train,ker,c_prime,g,gamma_f,x_hat);
[pred_val] = fsvdd_predict(val,ker,c_prime,g,gamma_f,x_hat);
[pred_test] =fsvdd_predict(test,ker,c_prime,g,gamma_f,x_hat);

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


fprintf('TAE = %g \n',avg_err_rate/20);

fprintf('Avg val error = %g \n',avg_val_err/20);

fprintf('Avg test error = %g \n',avg_test_err/20);

