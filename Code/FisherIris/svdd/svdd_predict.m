function predictedY = svdd_predict(trnX,tstX,ker,alpha,svi,c,gamma)
%svdd_predict Calculate SVDD Outputs
%
%  Usage: predictedY = svdd_predict(trnX,trnY,tstX,ker,alpha,bias,actfunc)
%
%  Parameters: trnX   - Training inputs
%              trnY   - Training targets
%              tstX   - Test inputs
%              ker    - kernel function
%              svi    - sv indices
%              beta   - Lagrange Multipliers             
%  Author: Aravind Sankar (!)
    
  if (nargin < 6 || nargin > 7) % check correct number of arguments
    help svdd_predict
  else
    n = size(trnX,1);
    m = size(tstX,1);
    H = zeros(m,size(svi,1));

    for i=1:m
      for j=1:length(svi)
        H(i,j) = svkernel_new(ker,tstX(i,:),trnX(svi(j),:),gamma);
      end
    end
    alpha = alpha(svi);
    
    predictedY = sign(2*H*alpha - c);
      
  end
  end
