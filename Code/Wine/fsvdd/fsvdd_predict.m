function predictedY = fsvdd_predict(tstX,ker,c_prime,gamma,gamma_f,x_hat)
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
    
    m = size(tstX,1);
    H = zeros(m,1);

    for i=1:m
        H(i) = 2*svkernel_new(ker,tstX(i,:),x_hat',gamma)/gamma_f;
    end
    %alpha = alpha(svi);
    
    predictedY = sign(H - c_prime);
      
  end
  end
