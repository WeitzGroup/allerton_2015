function D = sqDistance(X, Y)
%%%%%%%%% Inputs %%%%%%%%%
% X,Y - p by n matrices that specify n points in R^p
%%%%%%%%% Outputs %%%%%%%%%
% D - An n by n matrix whose ij entry is the 2-norm squared distance
% between point i in matrix X and point j in matrix Y

    D = sqrt(bsxfun(@plus,dot(X,X,1)',dot(Y,Y,1))-2*(X'*Y));
end