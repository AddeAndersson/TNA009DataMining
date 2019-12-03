function [Docs] = query_match(q, A, numberDocs)
    Match = CosineDist(q, A);

    %Find the 3 closest documents
    [~, Docs] = maxk(Match, numberDocs);
end

