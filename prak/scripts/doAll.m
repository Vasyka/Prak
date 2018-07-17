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


metrics_names = {'Year','MAPE','WAPE','SWAD','PsiStat','RSQ','N0'};
methods_names = {'RAS'};
diffMetric = {'Year';
              '2013'; 
              '2014';
              '2015'};

for m = 1:length(methods_names) # cycle for each method of projection
  
  itt = 1;
  Bs = reshape(1:59*59*7, 59, 59, 7); # vector of matrixes 59x59 for result matrixes
  metrics = metrics_names;
  s = [sheetname,'_1'];
  
  # Calcs all tables by 2011 table (app1)
  for j = 12:15

    # Calc & save tables
    k = num2str(j);
    Bs(:,:,itt) = eval([methods_names{m}, '(A11, ', 'U', k, ', ' , 'V', k, ')']);
    filename = ['res_', methods_names{m}, k, '.xlsx'];
  
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
  #save metrics
  xlswrite(['Metrics_',methods_names{m},'.xlsx'], metrics, s);


  # One by one calculating (2011 -> 2012; 2012 -> 2013; ...) (app2)
  metrics = [metrics_names; res12];
  s = [sheetname,'_2'];
  
  for j = 13:15

    # Calc & save tables
    k = num2str(j);
    Bs(:,:,itt) = eval([methods_names{m}, '(C, ', 'U', k, ', ' , 'V', k, ')']);
    filename = ['res_', methods_names{m}, k, '.xlsx'];
    xlswrite(filename, Bs(:,:,itt), s);
    C = Bs(:,:,itt);
   
    # Calc metrics 2013
    metrics = [metrics; calcMetrics(j, metrics_names, eval(['A', k]), Bs(:,:,itt))];
  itt+=1;
  endfor
  xlswrite(['Metrics_',methods_names{m},'.xlsx'], metrics, s);
  
  #Calculating DiffMetric between two approaches (app1 and app2) for each year
  difference = 0.5;
  cd13 = DiffMetric(Bs(:,:,2), Bs(:,:,5), difference);
  cd14 = DiffMetric(Bs(:,:,3), Bs(:,:,6), difference);
  cd15 = DiffMetric(Bs(:,:,4), Bs(:,:,7), difference);
  

  
  diffMetric = [diffMetric, {methods_names{m}; cd13; cd14; cd15}];
  
endfor

#Save results of DiffMetrics
xlswrite('DiffMetric.xlsx', diffMetric, sheetname);

endfunction

