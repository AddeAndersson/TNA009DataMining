function [columns] = CosineDist(query, A, tol)
    columns = (query'*full(A))/(norm(full(A)) * norm(query)) > tol;
    columns = sparse(columns);
end

