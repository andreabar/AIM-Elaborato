function normMatrix = colorNorm(RGBmatrix)

Rmatrix = RGBmatrix(:, : , 1);
Gmatrix = RGBmatrix(:, : , 2);
Bmatrix = RGBmatrix(:, : , 3);

[n, m] = size(Rmatrix);
r = zeros(n,m);
g = zeros(n,m);
b = zeros(n,m);

for i = 1:n
    for j = 1:m
        R = Rmatrix(i, j);
        G = Gmatrix(i, j);
        B = Bmatrix(i, j);
        r(i, j) = R/(R+G+B);
        g(i, j) = G/(R+G+B);
        b(i, j) = B/(R+G+B);
    end
end

normMatrix(:, :, 1) = r;
normMatrix(:, :, 2) = g;
normMatrix(:, :, 3) = b;

end