function result = SWAD(Xtrue, X) # Standardized weighted absolute difference
  
  diff = abs(Xtrue - X);
  mult = Xtrue .* diff;
  sqr = Xtrue .* Xtrue;
  s = sum(sum(sqr));
  result = sum(sum(mult)) / s;
  
endfunction