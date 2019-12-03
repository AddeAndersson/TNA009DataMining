function Docs = lgk_match(q, A, numberDocs)
    k = 5;

    %Initial conditions
    beta(1) = norm(q);
    P(:,1) = q/beta(1);

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
    qhat = W*W'*q;

    %Find relevant documents
    Match = CosineDist(qhat, A);
    [~, Docs] = maxk(Match, numberDocs);

end

