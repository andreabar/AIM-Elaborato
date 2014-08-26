function [X1, X2] = getPoints(k1, k2)
X1 = k1([1,2], :);
X2 = k2([1,2], :);
X1(3,:) = 1 ;
X2(3,:) = 1 ;

X1 = X1';
X2 = X2';

end

