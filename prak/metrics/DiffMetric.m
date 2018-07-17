function result = DiffMetric(Xtrue, X, eps) # Counts elements between matrixes, which differense is greater than eps 
  
  diff = abs(Xtrue - X);
  bol = (diff > eps);
  result = sum(bol(:));
  
endfunction