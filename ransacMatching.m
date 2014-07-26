function H = ransacMatching(keypoints1, descriptors1, keypoints2, descriptors2)

[matches, scores] = vl_ubcmatch(descriptors1, descriptors2);

X1 = keypoints1(1:2,matches(1,:)) ; X1(3,:) = 1 ;
X2 = keypoints2(1:2,matches(2,:)) ; X2(3,:) = 1 ;

numMatches = size(matches,2) ;

for t = 1:100
  % estimate homograpyh
  subset = vl_colsubset(1:numMatches, 4) ;
  A = [] ;
  for i = subset
    A = cat(1, A, kron(X1(:,i)', vl_hat(X2(:,i)))) ;
  end
  [U,S,V] = svd(A) ;
  H{t} = reshape(V(:,9),3,3) ;

  % score homography
  X2_ = H{t} * X1 ;
  du = X2_(1,:)./X2_(3,:) - X2(1,:)./X2(3,:) ;
  dv = X2_(2,:)./X2_(3,:) - X2(2,:)./X2(3,:) ;
  ok{t} = (du.*du + dv.*dv) < 6*6 ;
  score(t) = sum(ok{t}) ;
end

[score, best] = max(score) ;
H = H{best} ;

end