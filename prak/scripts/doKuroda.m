function result = doKuroda(A11, A12, A13, A14, A15, U12, V12, U13, V13, U14, V14, U15, V15, sheetname)metrics_names = {'Year','MAPE','WAPE','SWAD','PsiStat','RSQ','N0'};metrics = metrics_names;# Calcs all tables by 2011 tablefor j = 1:4  # Save tables  k = num2str(j+11);  B = Kuroda(A11, eval(['U', k]), eval(['V', k]));  filename = ['resKuroda', k, '.xlsx'];  s = [sheetname,'_1'];  xlswrite(filename, B, s);    # Calc metrics  res(1) = 2000 + j + 11;  for t = 2:7    res(t) = eval([metrics_names{t},'(A',k,',B)']);  endfor  metrics = [metrics; num2cell(res)];  xlswrite('Metrics.xlsx', metrics, s);  endforendfunction