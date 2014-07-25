
% il codice è molto di prova: 
% input: una stringa che corrisponderà al nome della cartella 
% in cui compara i frames (ovvero 'RGB' o 'depth').
% funzionamento: legge 2 frames consecutivi alla volta, 
% ne calcola la differenza e poi somma tutti i valori di tali elementi,
% infine stampa un grafico in cui si vede come varia la differenza tra un frame e l'atro


function der = cmpFrames(folder, seq, strg, n)
der = zeros(1,n);
% frame0 = imread(strcat(folder,'/', seq,'/',strg,'/',num2str(0),'.png'));
% [m, p, k] = size(frame0);
% frameVector = zeros(m, p, k, n + 1);
for i = 1:n
frame0 = imread(strcat(folder,'/', seq,'/',strg,'/',num2str(i-1),'.png'));
frame1 = imread(strcat(folder,'/', seq,'/',strg,'/',num2str(i),'.png'));
normFrame0 = colorMean(frame0);
normFrame1 = colorMean(frame1);

%frameVector(:, :, :, i) = frame0;
[m, p, k] = size(frame0);
d(:,:,:) = abs(normFrame0 - normFrame1);
der(i) = sum(sum(sum(d)))/(m*p*k);
end
%frameVector(:, : , :, n + 1) = frame1;
plot((1:n),der);

end
