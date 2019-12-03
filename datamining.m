%Authors: Adrian Andersson, Daniel Sahlin, Joel Paulsson
%TNA009: ComPutational Methods for Science and Engineering
%DescriPtion: Data Mining Project using LGK and K-Means clustering

%Load data: A is the abstracts, q is the queries, and dict is a dictionary.
%The terms are weighted.
load 'data/text-mining-medline_stemmed.mat';
load 'data/MED.REL';

%Create a matrix with relevant documents in each row corresponding to a
%query
RelDocs = zeros(39,30);
for i = 1:30
    len = length(find(MED(:,1) == i));
    RelDocs(1:len,i) = MED(find(MED(:,1) == i),3);
end

numberDocs = 3;
%% Query Matching
tic
Docs = query_match(q(:,9), A, numberDocs);
time = toc;

fprintf('Query Matching executed in %4.4f seconds\n', time);
fprintf('Query Matching found the %i most relevant documents to be: ', numberDocs);
fprintf('%i ', Docs);
fprintf('\n');
%% K-Means clustering
%Should K be equal to the number of documents?

[Docs, time] = cluster_match(q(:,9), A, numberDocs);
fprintf('K-Means executed in %4.4f seconds\n', time);
fprintf('K-Means found the %i most relevant documents to be: ', numberDocs);
fprintf('%i ', Docs);
fprintf('\n');
%% LGK
tic
Docs = lgk_match(q(:,9), A, numberDocs);
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
