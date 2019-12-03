function [prec, recall]= precision_recall(RetDocs, RelDocs)

    amountRel = sum(RelDocs > 0);
    amountRet = sum(RetDocs > 0);
    inter = sum(intersect(RetDocs, RelDocs) > 0);
    
    prec = inter/amountRet;
    recall = inter/amountRel;
end

