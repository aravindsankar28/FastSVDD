function predictedY = svdd_predict(trnX,tstX,ker,alpha,svi,c,gamma)
%svdd_predict Calculate SVDD Outputs
%
%  Usage: predictedY = svdd_predict(trnX,tstX,ker,alpha,svi,c,gamma)
%
%  Parameters: trnX   -     Training inputs
%              tstX   -     Test inputs
%              ker    -     kernel function - use 'rbf'
%              svi    -     sv indices
%              alpha  -     Lagrange Multipliers             
%              c      -     constant which is a part of disc. function
%              gamma  -     rbf kernel's param. gamma - 1/(2*sigma^2)
%              predictedY - output labels for test dataset tstX
%  Author: Aravind Sankar (!)
    
  if (nargin < 6 || nargin > 7) % check correct number of arguments
    help svdd_predict
  else
    
    m = size(tstX,1);
    H = zeros(m,size(svi,1));

    for i=1:m
      for j=1:length(svi)
        H(i,j) = svkernel_new(ker,tstX(i,:),trnX(svi(j),:),gamma);
      end
    end
    alpha = alpha(svi);
    % check the formulation for disc. fn. - direct application.
    predictedY = sign(2*H*alpha - c);
      
  end
  end
