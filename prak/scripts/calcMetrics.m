function result = calcMetrics(year, metrics_names, A, B)  res(1) = 2000 + year;  for t = 2:7    res(t) = eval([metrics_names{t},'(A,B)']);  endfor  result = num2cell(res);  endfunction