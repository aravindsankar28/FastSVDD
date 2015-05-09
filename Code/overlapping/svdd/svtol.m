function tol = svtol(C)
%SVTOL Tolerance for Support Vectors
%
%  Usage: tol = svtol(C)
%
%  Parameters: C      - upper bound 
%



  if (nargin ~= 1) % check correct number of arguments
    help svtol
  else

    % tolerance for Support Vector Detection
    if C==Inf 
      tol = 1e-5;
    else
      %tol = C*1e-3;
      tol = 0.1*C;
      
    end
    
  end
