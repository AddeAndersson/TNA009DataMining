%Authors: Adrian Andersson, Daniel Sahlin, Joel Paulsson
%TNA009: Computational Methods for Science and Engineering
%Description: Data Mining Project using LGK and K-Means clustering

%Load data: A is the abstracts, q is the queries, and dict is a dictionary.
%The terms are weighted.
load 'data/text-mining-medline_stemmed.mat';

%plot(A(:,1:500), '.k')

%% Query Matching
clc

tol = 0.0001;
Match = CosineDist(q(:,9), A, tol)

%% K-Means clustering
%Should K be equal to the number of documents?




%% LGK