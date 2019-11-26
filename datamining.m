%Authors: Adrian Andersson, Daniel Sahlin, Joel Paulsson
%TNA009: Computational Methods for Science and Engineering
%Description: Data Mining Project using LGK and K-Means clustering

load 'data/text-mining-medline_stemmed.mat'

A_norm = normalize(full(A));

k = 50;
[idx C]= kmeans(A_norm', k);

plot(idx,'.')

[Q R] = qr(C',0);

G_k = Q'*A_norm;


