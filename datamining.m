%Authors: Adrian Andersson, Daniel Sahlin, Joel Paulsson
%TNA009: Computational Methods for Science and Engineering
%Description: Data Mining Project using LGK and K-Means clustering

%Load data: A is the abstracts, q is the queries, and dict is a dictionary.
%The terms are weighted.
load 'data/text-mining-medline_stemmed.mat';

%plot(A(:,1:500), '.k')

%% Query Matching
clc

%Compute distances between query and documents
tol = 0.19;
Match = CosineDist(q(:,9), A);

%Find the 3 closest documents
[~, Docs] = maxk(Match, 3);
%% K-Means clustering
%Should K be equal to the number of documents?
A_norm = normalize(full(A));

%Set amount of clusters
k = 50;

%Cluster, idx contains labels with cluster index, C contains centroids
[idx, C]= kmeans(A_norm', k);
C = normalize(C'); idx = idx';
histogram(idx)

%Compute the thin-QR
[P_k, R] = qr(C,0);

%Create G_k
G_k = P_k'*A_norm;

%Transform query
q_k = P_k'*q(:,9);

%Compute distances between query and documents
tol = 0.19;
Match = CosineDist(q_k, G_k);

%Find the 3 closest documents in new vector space
[~, Docs] = maxk(Match, 3);
%% LGK


%% Etc

%Find text from query or doc

%Query
dict(FIND(q(:,9)),:);

%Doc
dict(FIND(A(:,409)),:)
