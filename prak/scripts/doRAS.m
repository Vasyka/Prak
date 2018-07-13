function [matrices, result] = doRAS(
  A11, A12, A13, A14, A15, U12, V12, U13, V13, U14, V14, U15, V15, ep, maxim)

  result = reshape(1:48, 4, 6, 2);

#Calculate tables for assumption a(all from one) and assumption b(each from previous)
B12 = RAS(A11, U12, V12, ep, maxim,1);

B13 = RAS(A11, U13, V13, ep, maxim,2);

B14 = RAS(A11, U14, V14, ep, maxim,3);

B15 = RAS(A11, U15, V15, ep, maxim,4);


C13 = RAS(B12, U13, V13, ep, maxim,5);
C14 = RAS(C13, U14, V14, ep, maxim,6);
C15 = RAS(C14, U15, V15, ep, maxim,7);




#Calculate metrics
mA = [MAPE(A12, B12), MAPE(A13, B13), MAPE(A14, B14), MAPE(A15, B15)];
mB = [MAPE(A12, B12), MAPE(A13, C13), MAPE(A14, C14), MAPE(A15, C15)];

wA = [WAPE(A12, B12), WAPE(A13, B13), WAPE(A14, B14), WAPE(A15, B15)];
wB = [WAPE(A12, B12), WAPE(A13, C13), WAPE(A14, C14), WAPE(A15, C15)];

sA = [SWAD(A12, B12), SWAD(A13, B13), SWAD(A14, B14), SWAD(A15, B15)];
sB = [SWAD(A12, B12), SWAD(A13, C13), SWAD(A14, C14), SWAD(A15, C15)];

pA = [PsiStat(A12, B12), PsiStat(A13, B13), PsiStat(A14, B14), PsiStat(A15, B15)];
pB = [PsiStat(A12, B12), PsiStat(A13, C13), PsiStat(A14, C14), PsiStat(A15, C15)];

rA = [RSQ(A12, B12), RSQ(A13, B13), RSQ(A14, B14), RSQ(A15, B15)];
rB = [RSQ(A12, B12), RSQ(A13, C13), RSQ(A14, C14), RSQ(A15, C15)];

nA = [N0(A12, B12), N0(A13, B13), N0(A14, B14), N0(A15, B15)];
nB = [N0(A12, B12), N0(A13, C13), N0(A14, C14), N0(A15, C15)];


result(:, :, 1) = [mA; wA; sA; pA; rA; nA]';
result(:, :, 2) = [mB; wB; sB; pB; rB; nB]';

matrices = [B12, B13, B14, B15; B12, C13, C14, C15];

endfunction