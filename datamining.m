%Authors: Adrian Andersson, Daniel Sahlin, Joel Paulsson
%TNA009: Computational Methods for Science and Engineering
%Description: Data Mining Project using LGK and K-Means clustering

%Load data: A is the abstracts, q is the queries, and dict is a dictionary.
%The terms are weighted.
load 'data/text-mining-medline_stemmed.mat';

%plot(A(:,1:500), '.k')

%% Query Matching
clc

tol = 0.19;
Match = CosineDist(q(:,9), A) > tol;
Docs = find(Match > 0);
%% K-Means clustering
%Should K be equal to the number of documents?
A_norm = normalize(full(A));

%Set amount of clusters
k = 50;

%Cluster, idx contains labels with cluster index, C contains centroids
[idx, C]= kmeans(A_norm', k);
C = normalize(C'); idx = idx';

%Compute the thin-QR
[Q, R] = qr(C,0);

%Create G_k
G_k = Q'*A_norm;

%Transform query
q_k = Q'*q(:,9);

%Find closest cluster(?) in new vector space
Match = CosineDist(q_k, G_k)  > tol;
Docs = find(Match > 0);

%% LGK

