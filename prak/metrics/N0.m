function result = N0(Xtrue, X) # Number of zero elements in X, whose corresponding elements are nonzero in Xtrue
  #inds = find(~X);
  #result = size(find(~Xtrue(inds)),1);
  
  #Number of elements which are zero in one matrix and nonzero in the other
  errors = xor(Xtrue == 0, X == 0);
  result = sum(errors(:));
  
endfunction