function [svi, alpha,c_prime,gamma_f,x_hat] = fsvdd_train_fpt(X,K,C,gamma)
% Fast Support Vector Data Description - fixed point iteration
%
%  Usage: [svi, alpha,c_prime,gamma_f,x_hat] = fsvdd_train_fpt(X,K,C,gamma)
%
%  Note: Targets not required for training purposes.
%  Parameters: X      - Training inputs
%              K      - Precomputed kernel gram matrix
%              gamma  - rbf kernel's param. gamma
%              C      - upper bound (non-separable case)
%              svi    - support vectors indices
%              alpha  - Lagrange Multipliers
%              c_prime- the constant which occurs in the disc. function of
%              fsvdd
%              gamma_f- the constant factor used in f-svdd - check
%              formulation
%              x_hat  - preimage of the agent of center

%  Author: Aravind Sankar (!)

  if (nargin <3 || nargin>4) % check correct number of arguments
    help fsvdd_train_fpt
  else

    fprintf('Support Vector Data Desctiption\n')
    fprintf('_____________________________\n')
    n = size(X,1);
    if (nargin<3) C=Inf; end
    if (nargin<2) ker='linear'; end
    
    % tolerance for Support Vector Detection
    
    
    % Construct the Kernel matrix for gaussian kernel now
       
    H = K;
    

    % Add small amount of zero order regularisation to 
    % avoid problems when Hessian is badly conditioned. 
    
    H = H+1e-10*eye(size(H));
    
    % Set up the parameters for the Optimisation problem

    vlb = zeros(n,1);      % Set the bounds: alphas >= 0
    vub = C*ones(n,1);     %                 alphas <= C
    
    x0 = zeros(n,1);
    
    
    A = ones(n,1)';      % Set the constraint Ax = b
    b = 1;
    
    % Solve the Optimisation Problem
    
    fprintf('Optimising ...\n');
    st = cputime;
    
    
   
    
    [alpha, fval, exitflag, output] = quadprog(H,[],[],[],A,b,vlb,vub,x0,'Display','none','TolX',1e-14,'TolFun',1e-14,'TolCon',1e-14);
    
    
    %output
    fprintf('Execution time: %4.1f seconds\n',cputime - st);

    % Compute the number of Support Vectors
    %epsilon = svtol(C);
    epsilon = 0.01*C;
    
    svi = find( alpha > epsilon);
    nsv = length(svi);
    fprintf('Support Vectors : %d (%3.1f%%)\n',nsv,100*nsv/n);

    svii = find( alpha > epsilon & alpha < (C - epsilon));
    
    % Compute radius R and c for use later in prediction.
    
   
    k = svii(1);
        
    %c =0;
    R2 =1 + alpha'*K*alpha;

    avg_val = 0;
    
    for k = 1:length(svii)
        val = 0.0;
        for i = 1:length(svi)
            index = svi(i);
            val = val+ 2*alpha(index)* K(index,svii(k));
        end
        avg_val = avg_val +val;
    end
    avg_val = avg_val/length(svii);
    
    
    R2 = R2 - avg_val;
      
    %c = 1-R2 + alpha'*K*alpha;
    
    gamma_f = 1/sqrt(alpha'*K*alpha);
    c_prime = 1 - R2 + 1/(gamma_f*gamma_f);
    
    % computin x_hat here.
    min_coord_train = zeros(2,1);
    max_coord_train = zeros(2,1);
    
    min_coord_train(1) = min(X(:,1));
    min_coord_train(2) = min(X(:,2));
    
    max_coord_train(1) = max(X(:,1));
    max_coord_train(2) = max(X(:,2));
      
    s1 = (max_coord_train(1) - min_coord_train(1))*rand(10,1) + min_coord_train(1); 
    s2 = (max_coord_train(2) - min_coord_train(2))*rand(10,1) + min_coord_train(2);
  
    start_pts = [s1 s2];
   
    
    
    x_hat = start_pts(1,:);
    x_hat(1) = rand(1,1);
    x_hat(2) = rand(1,1);
    
    % iterate till a max of 1000 iterations. fpt method.
    for t = 1:1000
        num = 0;
        den = 0;
        x_hat_old = x_hat;
        for i = 1:n
            num = num + alpha(i)*svkernel_new('rbf',X(i,:),x_hat,gamma)*X(i,:);
            den = den + alpha(i)*svkernel_new('rbf',X(i,:),x_hat,gamma);
        end
        x_hat = num/den;
        if pdist2(x_hat_old,x_hat) <= 10^(-6)
            't' 
            t
            break
        end
    end
    
    x_hat = x_hat';
    
    x_hat
  end
 
    
