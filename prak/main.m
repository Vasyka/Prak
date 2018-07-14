clear all;
addpath("./metrics");
addpath("./methods");
addpath("./scripts");
pkg load io;


resultsRAS = reshape(1:144, 4, 6, 2, 3);

for i = 1:3

# Load data
A11 = xlsread('data/2011aggr_ispr.xlsx', i, 'D5:BJ63');
A12 = xlsread('data/tri-2012.xlsx', i+1, 'D5:BJ63');
A13 = xlsread('data/tri-2013.xlsx', i+1, 'D5:BJ63');
A14 = xlsread('data/tri-2014.xlsx', i, 'D5:BJ63');
A15 = xlsread('data/tri-2015.xlsx', i+1, 'D5:BJ63');

#Load row sums
U12 = xlsread('data/tri-2012.xlsx', i+1, 'BK5:BK63');
U13 = xlsread('data/tri-2013.xlsx', i+1, 'BK5:BK63');
U14 = xlsread('data/tri-2014.xlsx', i, 'BK5:BK63');
U15 = xlsread('data/tri-2015.xlsx', i+1, 'BK5:BK63');

#Load column sums
if (i == 1)#Cuz different sheets have their column sums on different rows
  V12 = xlsread('data/tri-2012.xlsx', i+1, 'D66:BJ66');
  V13 = xlsread('data/tri-2013.xlsx', i+1, 'D66:BJ66');
  V14 = xlsread('data/tri-2014.xlsx', i, 'D66:BJ66');
  V15 = xlsread('data/tri-2015.xlsx', i+1, 'D66:BJ66');
elseif (i == 2)
  V12 = xlsread('data/tri-2012.xlsx', i+1, 'D67:BJ67');
  V13 = xlsread('data/tri-2013.xlsx', i+1, 'D67:BJ67');
  V14 = xlsread('data/tri-2014.xlsx', i, 'D67:BJ67');
  V15 = xlsread('data/tri-2015.xlsx', i+1, 'D67:BJ67');
else
  V12 = xlsread('data/tri-2012.xlsx', i+1, 'D68:BJ68');
  V13 = xlsread('data/tri-2013.xlsx', i+1, 'D68:BJ68');
  V14 = xlsread('data/tri-2014.xlsx', i, 'D68:BJ68');
  V15 = xlsread('data/tri-2015.xlsx', i+1, 'D68:BJ68');
endif

#Execute RAS method on each table type
#[matrices, resultsRAS(:, :, :, i)] = doRAS(A11, A12, A13, A14, A15, U12, V12, U13, V13, U14, V14, U15, V15, 0.000000001, 2000);

#Kuroda method
sheetnames = {'ТР';'ТИцп';'ТИоц'};
doKuroda(A11, A12, A13, A14, A15, U12, V12, U13, V13, U14, V14, U15, V15, sheetnames{i});



end
