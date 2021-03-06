function RESULTS = nipals_decomp(Z,rows, cols, a, it, tol, LargeX)

% EIGENVALUES

  RESULTS.Eigenvalues = svd(Z,0).^2;
  RESULTS.Variance = RESULTS.Eigenvalues./sum(RESULTS.Eigenvalues)*100;
  
  % INIZIALIZATION

RESULTS.Scores = zeros(rows, a);
RESULTS.Loadings = zeros(cols, a);
nr = 0;

% NIPALS DECOMPOSITION

for h=1:a
   th = Z(:,LargeX);
   ende = false;
   
   while(~ende)
       nr = nr+1;
    th_old = th;
    ph = Z'*th/(th'*th);
    ph = normc(ph);
    th = Z*ph/(ph'*ph);
    prec = (th-th_old)'*(th-th_old);
    
    if prec <= tol^2;
        ende = true;
    elseif it <=nr
        ende = true;
        disp('Iterarion stops without convergence!')
    end
    
   end
   
   Z = Z-th*ph';
   RESULTS.Scores(:, h) = th;
   RESULTS.Loadings(:,h) = ph;
   nr = 0;
   
end

% RESIDUAL MATRIX
RESULTS.Residual_Matrix = Z;
% STATISTICS ON RESIDUAL MATRIX
RESULTS.Residual_Matrix_Stat = matrix_stat(Z);

RESULTS.Scores_Scaled = scaledata(RESULTS.Scores,-1,1);
RESULTS.Loadings_Scaled = scaledata(RESULTS.Loadings,-1,1);
  





