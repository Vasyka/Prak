function result = INSD (Az, u, v, epsilon = 0.01, maxim = 5000)
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
    
    #Lambdas
    lambd = (u - u0 + sum(neg - tau .* Az, 2)) ./ u0;
    
    #Taus
    tau = (v - v0 + sum(neg - lambd .* Az, 1)) ./ v0;
    
    #Z
    Z = 1 + lambd .* ones(1, k) + tau .* ones(k, 1);
    Z(Az == 0) = 1;
    Z = ifelse(Z >= 0, Z, Z / (1 + M));
    
    diffLambd = abs(lambd .- lambd0);
    diffTau = abs(tau .- tau0);
    itt += 1;
    
  until(or(
        and(all(diffLambd < epsilon),
            all(diffTau < epsilon)),
        itt > maxim))
  
  X = Z .* Az;
  result = round(X);
endfunction
