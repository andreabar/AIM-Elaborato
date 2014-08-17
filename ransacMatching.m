function [H, X1, X2,matches] = ransacMatching(keypoints1, descriptors1, keypoints2, descriptors2)

[matches, scores] = vl_ubcmatch(descriptors1, descriptors2);
X1 = keypoints1(1:2,matches(1,:)) ; 
X2 = keypoints2(1:2,matches(2,:)) ;
%keypoints2(:,matches(2,:)) = []

t = cp2tform(X1', X2', 'affine');
X1(3,:) = 1 ;
X2(3,:) = 1 ;
X1 = X1';
X2 = X2';
H = t.tdata.T;
end