function result = doAll(A11, A12, A13, A14, A15, U12, V12, U13, V13, U14, V14, U15, V15, sheetname)

metrics_names = {'Year','MAPE','WAPE','SWAD','PsiStat','RSQ','N0'};
methods_names = {'RAS', 'Kuroda'};
metrics = metrics_names;


for m = 1:2

s = [sheetname,'_1'];
  # Calcs all tables by 2011 table
  for j = 12:15

    # Calc & save tables
    k = num2str(j);
    B = eval([methods_names{m}, '(A11, ', 'U', k, ', ' , 'V', k, ')']);
    filename = ['res_', methods_names{m}, k, '.xlsx'];
  
    xlswrite(filename, B, s);
  
    # Calc metrics
    curr = calcMetrics(j, metrics_names, eval(['A', k]), B);
    metrics = [metrics; curr];
  
    if (j == 12)
      C = B;
      res12 = curr;
    endif
  
  endfor
  xlswrite(['Metrics_',methods_names{m},'.xlsx'], metrics, s);


  # One by one calculating
  metrics = [metrics_names; res12];
  s = [sheetname,'_2'];
  
  for j = 13:15

    # Calc & save tables
    k = num2str(j);
    B = eval([methods_names{m}, '(A11, ', 'U', k, ', ' , 'V', k, ')']);
    filename = ['res_', methods_names{m}, k, '.xlsx'];
    xlswrite(filename, B, s);
    C = B;
   
    # Calc metrics 2013
    metrics = [metrics; calcMetrics(j, metrics_names, eval(['A', k]), B)];

  endfor
  xlswrite(['Metrics_',methods_names{m},'.xlsx'], metrics, s);
  
endfor

endfunction

