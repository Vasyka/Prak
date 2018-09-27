function result = DiffMetric(Xtrue, X, eps = 0.5) # Counts elements between matrixes, which differense is greater than eps 
  
  diff = abs(Xtrue - X);
  bol = (diff > eps);
  result = sum(bol(:));
  
endfunction