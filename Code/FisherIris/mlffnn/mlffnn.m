load_data;

threshold  = 0.9;
inputs = data_input';
targets = data_target';
bestcv_tr = 0;
bestcv_val = 0;

for n = 1:30
    net = patternnet(n);
    
    net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
    net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};

    net.divideFcn = 'divideblock';  % Divide blockwise
    net.divideParam.trainRatio = 1/6;
    net.divideParam.valRatio = 0.2;
    net.divideParam.testRatio = 1.9/3;



    net.trainFcn = 'trainlm';
    net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
      'plotregression', 'plotfit','plotconfusion'};
    net.layers{2}.transferFcn = 'logsig';

    [net,tr] = train(net,inputs,targets);
    outputs = net(inputs);

    trainTargets = targets .* tr.trainMask{1};
    valTargets = targets  .* tr.valMask{1};
    testTargets = targets  .* tr.testMask{1};
    trainPerformance = perform(net,trainTargets,outputs);
    valPerformance = perform(net,valTargets,outputs);
    testPerformance = perform(net,testTargets,outputs);

    trainOut = outputs .* tr.trainMask{1};
    testOut = outputs .* tr.testMask{1};
    valOut = outputs .* tr.valMask{1};
    
    
    outputs = outputs';
    train_labels = double(trainOut >threshold);
    %train_labels = double(outputs(1:250,:) > threshold);
    
    ac_tr = sum(train_labels == trainTargets)/size(train_data,1)
    
    val_labels = double(valOut >threshold);
    %val_labels = double(outputs(251:850,:) > threshold);
    
    ac_val = sum(val_labels == valTargets)/size(val_data,1)
    
    
    test_labels = double(testOut >threshold);
    %test_labels = double(outputs(851:1250,:) > threshold);
    
    ac_test = sum(test_labels == testTargets)/size(test_data,1)
    
    
    if ac_val > bestcv_val 
    %if ac_val > bestcv_val & ac_tr > bestcv_tr
        best_n = n;
        bestcv_val =  ac_val;
        bestcv_tr = ac_tr;
    end
    
   

end


    
    net = patternnet(best_n);
    
    net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
    net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};

  net.divideFcn = 'divideblock';  % Divide blockwise
  net.divideParam.trainRatio = 1/6;
  net.divideParam.valRatio = 0.2;
  net.divideParam.testRatio = 1.9/3;

    net.trainFcn = 'trainlm';
    net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
      'plotregression', 'plotfit','plotconfusion'};
    net.layers{2}.transferFcn = 'logsig';

    [net,tr] = train(net,inputs,targets);
    outputs = net(inputs);
    trainOut = outputs .* tr.trainMask{1};
    testOut = outputs .* tr.testMask{1};
    valOut = outputs .* tr.valMask{1};
    trainTargets = targets .* tr.trainMask{1};
    valTargets = targets  .* tr.valMask{1};
    testTargets = targets  .* tr.testMask{1};  
    
    train_labels = double(trainOut >threshold);
    ac_tr = sum(train_labels == trainTargets)/size(train_data,1)
    
    val_labels = double(valOut >threshold);
    ac_val = sum(val_labels == valTargets)/size(val_data,1)
    confusionmat(val_labels,valTargets)
    
    test_labels = double(testOut >threshold);
    ac_test = sum(test_labels == testTargets)/size(test_data,1)
    
    

% xrange = [-8 12];
% yrange = [-8 12];
% inc = 0.1;
% [x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2)); 
% image_size = size(x); 
% xy = [x(:) y(:)]; % make (x,y) pairs as a bunch of row vectors.
% 
% for i=1:size(xy,2)
%     xy(:,i) = (xy(:,i)-min_coord(i))/(max_coord(i)-min_coord(i));
% end
% 
% 
% outputs = net(xy');
% outputs = outputs';
% idx = double(outputs> threshold);
% 
% %probs  = [outputs(:,1), outputs(:,2), outputs(:,3), outputs(:,4)];   
% %[~,idx]  = max(probs,[],2);                          
% 
% figure;
% decisionmap = reshape(idx, image_size);
% imagesc(xrange,yrange,decisionmap);
% hold on;
% set(gca,'ydir','normal');
% cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1; 0.6 0.7 1];
% colormap(cmap);
% 
% plot(class1_val(:,1),class1_val(:,2),'b.',class2_val(:,1),class2_val(:,2),'r.',class3_val(:,1),class3_val(:,2),'m.',class4_val(:,1),class4_val(:,2),'g.');
% title('bivariate 4 class data');

