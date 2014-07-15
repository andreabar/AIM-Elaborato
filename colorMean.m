function meanMatrix = colorMean(RGBmatrix)

Rmatrix = RGBmatrix(:, : , 1);
Gmatrix = RGBmatrix(:, : , 2);
Bmatrix = RGBmatrix(:, : , 3);

[n, m] = size(Rmatrix);
r = zeros(n,m);
g = zeros(n,m);
b = zeros(n,m);

meanR = mean2(Rmatrix);
meanG = mean2(Gmatrix);
meanB = mean2(Bmatrix);

for i = 1:n
    for j = 1:m
        R = Rmatrix(i, j);
        G = Gmatrix(i, j);
        B = Bmatrix(i, j);
        
        r(i,j) = R/meanR;
        g(i,j) = G/meanG;
        b(i,j) = B/meanB;
    end
end

meanMatrix(:, :, 1) = r;
meanMatrix(:, :, 2) = g;
meanMatrix(:, :, 3) = b;


end