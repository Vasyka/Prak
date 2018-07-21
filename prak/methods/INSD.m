function result = INSD (Az, u, v, epsilon = 0.01, maxim = 5000)
% PURPOSE: estimate a new matrix X on the base of X0 with exogenously
% given row and column totals.
% -------------------------------------------------------------------------
% USAGE: X = INSD(X0,u,v) with or without epsilon and maxim
% included as the five argument, where
% INPUT:
% -> Az = benchmark (base) matrix, not necessarily square
% -> u = row vector of row totals
% -> v = column vector of column totals
% -> epsilon = convergence tolerance level; if empty, the default threshold
% is 0.01
% -> maxim = maximum itterations before algorithm stops, if empty, the default
% limit is 10.000 itterations
% OUTPUT:
% -> result = estimated/adjusted/updated matrix

  itt = 0;
  Az(Az == 0) = 0.01;

  # Initialization
  k = length(Az);
  Z = eye(k);
  lambd = zeros(k, 1);
  tau = zeros(1, k);
  M = 1000000;

  # Sums of rows, columns
  u0 = sum(Az, 2);
  v0 = sum(Az, 1);
  u(u == 0) = k * 0.01;
  v(v == 0) = k * 0.01;
  
  do
    
    lambd0 = lambd;
    tau0 = tau;
  
    # Prevent negative numbers
    neg = M * Az .* min(0, Z);
    
    # Coefficients of the differences between real sums of rows/columns and estimated
    lambd = (u - u0 + sum(neg - tau .* Az, 2)) ./ u0;
    tau = (v - v0 + sum(neg - lambd .* Az, 1)) ./ v0;
    
    #Z
    Z = 1 + lambd .* ones(1, k) + tau .* ones(k, 1);
    Z(Az == 0) = 1;
    Z = ifelse(Z >= 0, Z, Z / (1 + M));
    
    # Calculate residual between coefficients of the columns and rows sums differenses
    diffLambd = abs(lambd .- lambd0);
    diffTau = abs(tau .- tau0);
    itt += 1;
    
  until(or(
        and(all(diffLambd < epsilon),
            all(diffTau < epsilon)),
        itt > maxim)) # working until both columns and rows coefficients are less than epsilon, or limit is reached
  
  # Get estimated matrix 
  X = Z .* Az;
  result = X;
endfunction
