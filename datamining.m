%Authors: Adrian Andersson, Daniel Sahlin, Joel Paulsson
%TNA009: ComPutational Methods for Science and Engineering
%DescriPtion: Data Mining Project using LGK and K-Means clustering

%Load data: A is the abstracts, q is the queries, and dict is a dictionary.
%The terms are weighted.
load 'data/text-mining-medline_stemmed.mat';
numberDocs = 3;
%Plot(A(:,1:500), '.k')

%% Query Matching

tic

%Compute distances between query and documents
tol = 0.19;
Match = CosineDist(q(:,9), A);

%Find the 3 closest documents
[~, Docs] = maxk(Match, numberDocs);
time = toc;
fprintf('Query Matching executed in %4.4f seconds\n', time);
fprintf('Query Matching found the %i most relevant documents to be: ', numberDocs);
fprintf('%i ', Docs);
fprintf('\n');
%% K-Means clustering
%Should K be equal to the number of documents?

A_norm = normalize(full(A));

%Set amount of clusters
k = 50;

%Cluster, idx contains labels with cluster index, C contains centroids
[idx, C]= kmeans(A_norm', k);
C = normalize(C'); idx = idx';
%histogram(idx)

%Compute the thin-QR
[P_k, R] = qr(C,0);

tic
%Create G_k
G_k = P_k'*A_norm;

%Transform query
q_k = P_k'*q(:,9);

%Compute distances between query and documents
tol = 0.19;
Match = CosineDist(q_k, G_k);

%Find the 3 closest documents in new vector space
[~, Docs] = maxk(Match, numberDocs);
time = toc;
fprintf('K-Means executed in %4.4f seconds\n', time);
fprintf('K-Means found the %i most relevant documents to be: ', numberDocs);
fprintf('%i ', Docs);
fprintf('\n');
%% LGK
tic

k = 5;

%Initial conditions
beta(1) = norm(q(:,9));
P(:,1) = q(:,9)/beta(1);

%First iteration
Z(:,1) = A'*P(:,1);
alpha(1) = 1/norm(Z(:,1));
Z(:,1) = alpha(1)*Z(:,1);

P(:,2) = A*Z(:,1) - alpha(1)*P(:,1);
beta(2) = 1/norm(P(:,2));
P(:,2) = beta(2)*P(:,2);

%Following iterations
for i = 2:k
    Z(:,i) = A'*P(:,i)-beta(i)*Z(:,i-1); %Determine Z
    alpha(i) = 1/norm(Z(:,i)); %Determine alpha
    Z(:,i) = alpha(i)*Z(:,i); %Scale Z to unit length
    
    P(:,i+1) = A*Z(:,i) - alpha(i)*P(:,i); %Determine P
    beta(i+1) = 1/norm(P(:,i+1)); %Determine beta
    P(:,i+1) = beta(i+1)*P(:,i+1); %Scale P to unit length
end

%Create diagonal matrix B of alpha and beta
B = diag(beta(2:end), -1);
B(1:k,1:k) = B(1:k,1:k) + diag(alpha);
B = B(1:k+1,1:k);

%Perform  a QR decomposition of B
[Q, Bhat] = qr(B);

%Create W
o = zeros(size(P*Q));
o(1:k+1,1:k+1) = eye(k+1);
W = P*Q*o';

%Create qhat
qhat = W*W'*q(:,9);

%Find relevant documents
Match = CosineDist(qhat, A);
[~, Docs] = maxk(Match, numberDocs);

time = toc;
fprintf('LGK executed in %4.4f seconds\n', time);
fprintf('LGK found the %i most relevant documents to be: ', numberDocs);
fprintf('%i ', Docs);
fprintf('\n');
%% Etc

%Find text from query or doc

%Query
query_text = dict(find(q(:,9)),:)

%Doc
doc_text = dict(find(A(:,409)),:)
