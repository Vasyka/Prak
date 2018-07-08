function psi = PsiStat(Xtrue, X) # Psi statistic
  s = (Xtrue + X) / 2;

  inf1 = Xtrue ./ s;
  loged1 = log(inf1);
  loged1(isnan(loged1))=0; # 0/0 occasions
  loged1(isinf(loged1))=0; # 1/0 occasions 
  left = Xtrue .* loged1;

  inf2 = X ./ s;
  loged2 = log(inf2);
  loged2(isnan(loged2))=0; # 0/0 occasions
  loged2(isinf(loged2))=0; # 1/0 occasions 
  right = X .* loged2;

  inform = sum(sum(left + right));
  summ = sum(sum(Xtrue));
  psi = inform / summ;
endfunction