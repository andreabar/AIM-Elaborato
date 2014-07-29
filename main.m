clear
folderName = 'DroppedObjects';
sequences = {'Seq1', 'Seq2', 'Seq3'};
imgType = {'RGB', 'depth'};
imgNumber = [358, 464, 529];

% der = cmpFrames(folderName, sequences{1}, imgType{1}, imgNumber(1));
% threshold = calculateThreshold(der);
% lowMotionIndex = lowMotionFrames(der, threshold);
% minimumIndex = getMinimumIndexPerRegion(lowMotionIndex, der);
minimumIndex = [112, 294];
[keypointVector, descriptorsVector] = getFrameKeypoint(folderName, sequences{1}, imgType{1}, minimumIndex);
[strongKeypointVector, strongDescriptorsVector] = extractStrongKeypoint(folderName, sequences{1}, imgType{2}, minimumIndex, keypointVector, descriptorsVector);
clear keypointVector descriptorsVector;

for i=1:length(minimumIndex)-1
    H = ransacMatching(strongKeypointVector{i}, strongDescriptorsVector{i}, strongKeypointVector{i+1}, strongDescriptorsVector{i+1});
    
    im1 = imread(strcat(folderName,'/', sequences{1},'/',imgType{2},'/',num2str(minimumIndex(i)),'.png'));
    im2 = imread(strcat(folderName,'/', sequences{1},'/',imgType{2},'/',num2str(minimumIndex(i + 1)),'.png'));
    
    tform = maketform('projective', H');
    imt = imtransform(im1, tform);
    imagesc(imt);
    
%     box2 = [1  size(im2,2) size(im2,2)  1 ;
%         1  1           size(im2,1)  size(im2,1) ;
%         1  1           1            1 ] ;
%     box2_ = inv(H) * box2 ;
%     box2_(1,:) = box2_(1,:) ./ box2_(3,:) ;
%     box2_(2,:) = box2_(2,:) ./ box2_(3,:) ;
%     ur = min([1 box2_(1,:)]):max([size(im1,2) box2_(1,:)]) ;
%     vr = min([1 box2_(2,:)]):max([size(im1,1) box2_(2,:)]) ;
%     
%     [u,v] = meshgrid(ur,vr) ;
%     im1_ = vl_imwbackward(im2double(im1),u,v) ;
%     
%     z_ = H(3,1) * u + H(3,2) * v + H(3,3) ;
%     u_ = (H(1,1) * u + H(1,2) * v + H(1,3)) ./ z_ ;
%     v_ = (H(2,1) * u + H(2,2) * v + H(2,3)) ./ z_ ;
%     im2_ = vl_imwbackward(im2double(im2),u_,v_) ;
%     
%     mass = ~isnan(im1_) + ~isnan(im2_) ;
%     im1_(isnan(im1_)) = 0 ;
%     im2_(isnan(im2_)) = 0 ;
%     mosaic = (im1_ + im2_) ./ mass ;
%     
%     figure(2) ; clf ;
%     imagesc(mosaic) ; axis image off ;
%     title('Mosaic') ;
%     
%     if nargout == 0, clear mosaic ; end
    
end



