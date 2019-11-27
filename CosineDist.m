function [columns] = CosineDist(query, A)
    %Calculate the cosine similarity between a column vector q and several,
    %or one, columns vectors A
    columns = (query'*full(A))./(vecnorm(full(A)) .* norm(query));
end

