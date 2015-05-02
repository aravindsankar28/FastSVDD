function K = computeKgm(X,ker,gamma)

  if nargin < 1
      'Sorry to say'
  else
      switch lower(ker)
           case 'linear'
               K = zeros(size(X,1),size(X,1));
           case 'rbf'
%                 A = sum(X .* X, 2);
%                 B = -2 * (X * X');
%                 K = bsxfun(@plus, A, B);
%                 K = bsxfun(@plus, K, A');
%                 K = exp(-K*gamma);
                
                K = exp(-gamma*pdist2(X,X).^2);
              
          otherwise
               K = zeros(size(X,1),size(X,1));
      end
  end
end
      