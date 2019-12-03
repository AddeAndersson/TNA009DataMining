function [Docs, time] = cluster_match(q, A, numberDocs)
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
    q_k = P_k'*q;

    %Compute distances between query and documents
    Match = CosineDist(q_k, G_k);

    %Find the 3 closest documents in new vector space
    [~, Docs] = maxk(Match, numberDocs);
    time = toc;
end

