clear all;
addpath("./scripts");
addpath("./methods");
addpath("./metrics");
warning("off");
pkg load io;

mkdir("./results");
mkdir("./metrics-results");

sheetnames = {'ТР';'ТИцп';'ТИоц'};
for i = 1:3

  # Load data
  A11 = xlsread('data/2011aggr_ispr.xlsx', i, 'D5:BJ63');
  A12 = xlsread('data/tri-2012.xlsx', i+1, 'D5:BJ63');
  A13 = xlsread('data/tri-2013.xlsx', i+1, 'D5:BJ63');
  A14 = xlsread('data/tri-2014.xlsx', i, 'D5:BJ63');
  A15 = xlsread('data/tri-2015.xlsx', i+1, 'D5:BJ63');

  # Calculate row & column sums
  for j = 1:4
    k = num2str(j + 11);
    U(:,j) = sum(eval(['A', k]), 2);
    V(j,:) = sum(eval(['A', k]), 1);
  endfor

  # Execute all methods for each table sheet
  doAll(A11, A12, A13, A14, A15, U(:,1), V(1,:), U(:,2), V(2,:), U(:,3), V(3,:), U(:,4), V(4,:), sheetnames{i});

endfor
