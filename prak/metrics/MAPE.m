function result = MAPE(Xtrue, X) # Mean absolute percentage error
  
  diff = abs(Xtrue - X);
  errors = diff ./ Xtrue;
  errors(isnan(errors))=0; # 0/0 occasions
  errors(isinf(errors))=0; # 1/0 occasions 
  result = sum(sum(errors)) / (columns(Xtrue)*rows(Xtrue)) * 100;
  
endfunction