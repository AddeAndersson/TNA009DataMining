function [columns] = CosineDist(query, A)
    columns = (query'*full(A))./(vecnorm(full(A)) .* norm(query));
    %columns = sparse(columns);
end

