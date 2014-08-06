function isFlat = isLocalPlane(keypoint,im)
    isFlat = false;
   x = round(keypoint(1));
   y = round(keypoint(2));
   %x
   %y
   z = im(y,x); %la depth del keypoint
   radius = round(keypoint(3)); % è il 'raggio' del keypoint
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
               b(count) = im(j,i); %im(i,j) è la z_i
               A(count,1) = i;
               A(count,2) = j;           
               count = count + 1;
       end
   end
   [res,x] = leastSquaresProblems(A,b);
   res
   %res è la norma2 di Ax-b
   % se il rapporto fra la norma e z (la depth del keypoint)
   % è inferiore a 0.01, allora si può ritenere il keypoint localmente
   % piano
   if res/z < 0.01
       isFlat = true;
   end
end