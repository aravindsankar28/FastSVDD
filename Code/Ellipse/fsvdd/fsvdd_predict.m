function predictedY = fsvdd_predict(tstX,ker,c_prime,gamma,gamma_f,x_hat)
% fsvdd_predict Calculate FSVDD Outputs
%
%  Usage: predictedY = fsvdd_predict(tstX,ker,c_prime,gamma,gamma_f,x_hat)
%
%  Parameters: 
%              tstX   - Test inputs
%              ker    - kernel function
%              c_prime- the constant which occurs in the disc. function of
%              fsvdd
%              gamma  - rbf kernel function parameter
%              gamma_f- the constant factor used in f-svdd - check
%              formulation
%              x_hat  - Preimage of the agent of center
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
