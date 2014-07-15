
% il codice è molto di prova: 
% input: una stringa che corrisponderà al nome della cartella 
% in cui compara i frames (ovvero 'RGB' o 'depth').
% funzionamento: legge 2 frames consecutivi alla volta, 
% ne calcola la differenza e poi somma tutti i valori di tali elementi,
% infine stampa un grafico in cui si vede come varia la differenza tra un frame e l'atro


function cmpFrames(strg)
t = cputime;
n = 464;
der = zeros(1,n);
for i = 1:n
frame0 = imread(strcat('DroppedObjects/Seq2/',strg,'/',num2str(i-1),'.png'));
frame1 = imread(strcat('DroppedObjects/Seq2/',strg,'/',num2str(i),'.png'));
normFrame0 = colorMean(frame0);
normFrame1 = colorMean(frame1);

[m, p] = size(frame0);
d(:,:,:) = abs(normFrame0 - normFrame1);
der(1,i) = sum(sum(sum(d)))/(m*p);
end
e = cputime - t
plot([1:n],der);

end
