function [prec, recall]= precision_recall(RetDocs, RelDocs)
    prec = length(union(RetDocs, RelDocs))/length(RetDocs);
    recall = length(union(RetDocs, RelDocs))/length(Relevant);
end

