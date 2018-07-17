function result = N0(Xtrue, X) # Number of elements which are zero in one matrix and nonzero in the other
  
  errors = xor(Xtrue == 0, X == 0);
  result = sum(errors(:));
  
endfunction