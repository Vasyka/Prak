function doAll(A11, A12, A13, A14, A15, U12, V12, U13, V13, U14, V14, U15, V15, sheetname)
% PURPOSE: execute methods of matrix projection for 2012 - 2015 years from 2011 table using two approaches,
% count different metrics between calculated and real matrixes and output all results in xlsx files
% -------------------------------------------------------------------------
% USAGE: just calling doAll(A11, A12, A13, A14, A15, U12, V12, U13, V13, U14, V14, U15, V15, sheetname)
% INPUT:
% -> A11...A15 = real input-output matrixes (I quadrant) for 2011...2015 years
% -> U11...U15 = row vectors of row sums for 2011...2015 years
% -> V11...V15 = column vectors of column sums for 2011...2015 years
% -> sheetname = name of current sheet of input-output table
% OUTPUT:
% -> xlsx file for each calculated table
% -> xlsx file with calculated metrix for each method
% -> xlsx file with calculated DiffMetric


metrics_names = {'Year','MAPE','WAPE','SWAD','PsiStat','RSQ','N0', 'DiffMetric'};
methods_names = {'RAS','INSD','Kuroda1','Kuroda2','Kuroda3'}; #'RAS','INSD','Kuroda' 
diffMetric = {'Year';
              'app1 and app2';
              '2013'; 
              '2014';
              '2015';
              'app1 and app3';
              '2013'; 
              '2014';
              '2015';
              'app2 and app3';
              '2013'; 
              '2014';
              '2015'};

for m = 1:length(methods_names) # cycle for each method of projection
  
  curr_method = methods_names{m};
  if strcmp(curr_method(1:end-1),"Kuroda") # catching variants of Kuroda method
    variant = curr_method(end);
    curr_method_name = curr_method(1:end-1);
  else
    variant = "1";
    curr_method_name = curr_method;
  endif
  
  itt = 1;
  Bs = reshape(1:59*59*10, 59, 59, 10); # vector of matrixes 59x59 for result matrixes
  metrics = metrics_names;
  s = [sheetname,'_1'];
  
  # Calcs all tables by 2011 table (app1)
  for j = 12:15

    # Calc & save tables
    k = num2str(j);
    printf("app1 %d %s %s \n", 2000 + j, curr_method, sheetname);
    Bs(:,:,itt) = eval([curr_method_name,'(A11, ', 'U', k, ', ' , 'V', k, ', ', variant, ')']);
    filename = ['./results/res_', curr_method, k, '.xlsx'];
  
    xlswrite(filename, Bs(:,:,itt), s);
  
    # Calc metrics
    curr = calcMetrics(j, metrics_names, eval(['A', k]), Bs(:,:,itt));
    metrics = [metrics; curr];
  
    # Save table for 2012 year as it is calculated in the same way for app1 and app2
    if (j == 12)
      C = Bs(:,:,itt);
      res12 = curr;
    endif
  
  itt+=1;
  endfor
  # Save metrics
  xlswrite(['./metrics-results/Metrics_',curr_method,'.xlsx'], metrics, s);


  # One by one calculating (2012 -> 2013; 2013 -> 2014; ...) (app2)
  metrics = [metrics_names; res12];
  s = [sheetname,'_2'];
  
  for j = 13:15

    # Calc & save tables
    k = num2str(j);
    printf("app2 %d %s %s \n", 2000 + j, curr_method, sheetname);
    Bs(:,:,itt) = eval([curr_method_name, '(C, ', 'U', k, ', ' , 'V', k, ', ', variant,')']);
    filename = ['./results/res_', curr_method, k, '.xlsx'];
    xlswrite(filename, Bs(:,:,itt), s);
    C = Bs(:,:,itt);
   
    # Calc metrics
    metrics = [metrics; calcMetrics(j, metrics_names, eval(['A', k]), Bs(:,:,itt))];
  itt+=1;
  endfor
  xlswrite(['./metrics-results/Metrics_',curr_method,'.xlsx'], metrics, s);
  
  
  
  
  
  
  # One by one calculating  from static tables (A's) (2012 -> 2013; 2013 -> 2014; ...) (app3)
  metrics = [metrics_names; res12];
  s = [sheetname,'_3'];
  
  for j = 13:15

    # Calc & save tables
    k = num2str(j);
    k1 = num2str(j-1);
    printf("app3 %d %s %s \n", 2000 + j, curr_method, sheetname);
    Bs(:,:,itt) = eval([curr_method_name, '(A', k1, ', ', 'U', k, ', ' , 'V', k, ', ', variant, ')']);
    filename = ['./results/res_', curr_method, k, '.xlsx'];
    xlswrite(filename, Bs(:,:,itt), s);
   
    # Calc metrics
    metrics = [metrics; calcMetrics(j, metrics_names, eval(['A', k]), Bs(:,:,itt))];
  itt+=1;
  endfor
  xlswrite(['./metrics-results/Metrics_',curr_method,'.xlsx'], metrics, s);
  
  

  
  
  
  
  # Calculating DiffMetric between all approaches (1 and 2 ; 1 and 3 ; 2 and 3) for each year
  difference = 0.5;
  cd13 = DiffMetric(Bs(:,:,2), Bs(:,:,5), difference);
  cd14 = DiffMetric(Bs(:,:,3), Bs(:,:,6), difference);
  cd15 = DiffMetric(Bs(:,:,4), Bs(:,:,7), difference);
  
  dd13 = DiffMetric(Bs(:,:,2), Bs(:,:,8), difference);
  dd14 = DiffMetric(Bs(:,:,3), Bs(:,:,9), difference);
  dd15 = DiffMetric(Bs(:,:,4), Bs(:,:,10), difference);
  
  ed13 = DiffMetric(Bs(:,:,5), Bs(:,:,8), difference);
  ed14 = DiffMetric(Bs(:,:,6), Bs(:,:,9), difference);
  ed15 = DiffMetric(Bs(:,:,7), Bs(:,:,10), difference);
  

  
  diffMetric = [diffMetric, {curr_method; {}; cd13; cd14; cd15; {}; dd13; dd14; dd15; {}; ed13; ed14; ed15}];
  
endfor

# Save results of DiffMetrics
xlswrite('./metrics-results/DiffMetric.xlsx', diffMetric, sheetname);

endfunction

