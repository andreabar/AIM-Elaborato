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


for i = 1:length(minimumIndex)-1
    im1 = imread(strcat(folderName,'/', sequences{1},'/',imgType{2},'/',num2str(minimumIndex(i)),'.png'));
    im2 = imread(strcat(folderName,'/', sequences{1},'/',imgType{2},'/',num2str(minimumIndex(i + 1)),'.png'));
    [planarKeyPoints1, planarDescriptors1] = getRobustKeypoints(im1,keypointVector, descriptorsVector, i);
    [planarKeyPoints2, planarDescriptors2] = getRobustKeypoints(im2,keypointVector, descriptorsVector, i + 1);
    [H, X1, X2] = ransacMatching(planarKeyPoints1, planarDescriptors1, planarKeyPoints2, planarDescriptors2);
    %Per ZUGO: X1aligned e X2 è normale che non abbiano punti esattamente
    %coincidenti, ci sono alcuni gruppi di punti che sono molto vicini tra
    %loro, altri sono diversi, ma dobbiamo comunque considerare lo
    %spostamento dell'immagine, rumore, ecc...
    X1translated = X1 * H;
    [R, T] = icp(X2', X1translated');
    X1aligned = R*X1translated' + repmat(T,1,length(X1translated'));
    X1aligned = X1aligned';
    %PLOT robustKeypoint
%     im1RGB = imread(strcat(folderName,'/', sequences{1},'/',imgType{1},'/',num2str(minimumIndex(2)),'.png'));
%     imagesc(im1RGB);
%     hold on;
%     for k = 1:length(planarKeyPoints)
%         plot(planarKeyPoints1{1,k}(2,1),planarKeyPoints1{1,k}(1,1),'o');
%         hold on;
%     end
    
end



%Ransac l'ho commentato tutto
% for i=1:length(minimumIndex)-1
%     H = ransacMatching(strongKeypointVector{i}, strongDescriptorsVector{i}, strongKeypointVector{i+1}, strongDescriptorsVector{i+1});
%     
%     im1 = imread(strcat(folderName,'/', sequences{1},'/',imgType{2},'/',num2str(minimumIndex(i)),'.png'));
%     im2 = imread(strcat(folderName,'/', sequences{1},'/',imgType{2},'/',num2str(minimumIndex(i + 1)),'.png'));
%     TstrongKeyPoint{i} = H*strongKeypointVector{i};
%     
%     tform = maketform('projective', H');
%     imt = imtransform(im1, tform);
%     imagesc(imt);
    
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
    

%end

% imshow(im1);
% hold on;
% plot(TstrongKeyPoint);




