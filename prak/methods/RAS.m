function result = RAS(Az, u, v, variant = 1, epsilon = 0.01, maxim = 10000)
% PURPOSE: estimate a new matrix X on the base of X0 with exogenously
% given row and column totals.
% -------------------------------------------------------------------------
% USAGE: X = RAS(X0,u,v) with or without epsilon and maxim
% included as the five argument, where
% INPUT:
% -> Az = benchmark (base) matrix, not necessarily square
% -> u = row vector of row totals
% -> v = column vector of column totals
% -> variant = variant of method, always 1
% -> epsilon = convergence tolerance level; if empty, the default threshold
% is 0.01
% -> maxim = maximum itterations before algorithm stops, if empty, the default
% limit is 10.000 itterations
% OUTPUT:
% -> result = estimated/adjusted/updated matrix

  
itt = 0;
Az(Az == 0) = 0.01;
  
  do
    
    if (rem(itt, 2) == 0); # on even itterations multiply matrix rows
      udot = sum(Az, 2);
      R = diag(u ./ udot);
      R(or(isinf(R), isnan(R))) = 0; # Inf and NaN occasions
      Az = R * Az;
    else
      vdot = sum(Az, 1); # on odd itterations multiply matrix columns
      S = diag(v ./ vdot);
      S(or(isinf(S), isnan(S))) = 0; # Inf and NaN occasions
      Az = Az * S;
    endif
    
    itt += 1; # increasing itterations counter
    
    unow = sum(Az, 2);
    vnow = sum(Az, 1);
    diffU = abs(u .- unow); # differenses between curent row/colums sums and base
    diffV = abs(v .- vnow);
    
  until(or(
        and(all(diffU < epsilon),
            all(diffV < epsilon)),
        itt > maxim)) # working until both columns and rows differenses are less than epsilon, or limit is reached
  
  result = Az;
  
endfunction