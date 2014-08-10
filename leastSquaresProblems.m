function [ residuo x] = leastSquaresProblems( A,b )%%b vettore colonna!

m=size(A,1);
n=size(A,2);

x=(A'*A)\(A'*b(:));
f=A*x-b(:);
residuo = norm(f);


end



