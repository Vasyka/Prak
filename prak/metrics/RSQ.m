function Rsqr = RSQ(Xtrue, X) # Coefficient of determination
  
  var = Xtrue - mean(mean(Xtrue));
  TSS = sum(sum(var .* var));
  e = Xtrue - X;
  ESS = sum(sum(e .* e));
  Rsqr = 1 - ESS/TSS;
  
endfunction