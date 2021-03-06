function isFlat = isLocalPlane(keypoint,im)
    isFlat = false;
    
    R = [ 9.9984628826577793e-01, 1.2635359098409581e-03, -1.7487233004436643e-02; -1.4779096108364480e-03, 9.9992385683542895e-01, -1.2251380107679535e-02;
    1.7470421412464927e-02, 1.2275341476520762e-02, 9.9977202419716948e-01 ];

    T =[ 1.9985242312092553e-02, -7.4423738761617583e-04,-1.0916736334336222e-02 ]';
%    x = round(keypoint(1));
%    y = round(keypoint(2));
   x_y_coords = R*[keypoint(1),keypoint(2),1]' + T;
   x = round(x_y_coords(1));
   y = round(x_y_coords(2));
   z = im(y,x); %la depth del keypoint
   radius = round(keypoint(3)); % � il 'raggio' del keypoint
   lowIntervalx = max(x - radius,1);
   uppIntervalx = min(x + radius,640);
   lowIntervaly = max(y - radius,1);
   uppIntervaly = min(y + radius,480);
   len = (2*((uppIntervalx - lowIntervalx)+1)*2*((uppIntervalx - lowIntervalx)+1));
   A = ones(len , 3);
   b = zeros(len , 1);
   count = 1;

   for i = lowIntervalx : uppIntervalx
       for j = lowIntervaly : uppIntervaly
           x_y_coords = R*[i,j,1]' + T;
            if (x_y_coords(1) >= 1) && (x_y_coords(2) >= 1)
               b(count) = avgDepth(round(x_y_coords(2)),round(x_y_coords(1)),im); %im(i,j) � la z_i
               A(count,1) = x_y_coords(1);
               A(count,2) = x_y_coords(2);           
               count = count + 1;
            else
                A(count,:) = [];
                b(count) =  [];
            end
       end
   end
%    for i = lowIntervalx : uppIntervalx
%        for j = lowIntervaly : uppIntervaly
%                b(count) = im(j,i); %im(i,j) � la z_i
%                A(count,1) = i;
%                A(count,2) = j;           
%                count = count + 1;
%        end
%    end
% Vecchio metodo

   [res,x] = leastSquaresProblems(A,b);
   %res
   %res � la norma2 di Ax-b
   % se il rapporto fra la norma e z (la depth del keypoint)
   % � inferiore a 0.01, allora si pu� ritenere il keypoint localmente
   % piano
   if res/z < 0.01
       isFlat = true;
   end
end


function [avg_z] = avgDepth(x,y,img)
 resto_x = x - floor(x);
 resto_y = y - floor(y);
 
 avg_z = (((1 - resto_x) + (1 - resto_y))*img(floor(x),floor(y))) + ((resto_x + resto_y)*img(ceil(x),ceil(y))) ;
 avg_z = avg_z/2;


end