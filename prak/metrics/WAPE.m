function result = WAPE(Xtrue, X) # Weighted absolute percentage error
  
  diff = abs(Xtrue - X);
  s = sum(sum(Xtrue));
  result = sum(sum(diff / s * 100));
  
endfunction