function [ graph ] = generate_infoNetwork( A,frac,p )
% Generate an information network from a given geometric network A by
% rewiring a fraction frac of the links to every other node with
% independent probability p (as in ER random graphs)
%%%%%%%%% Outputs %%%%%%%%%
% graph is the n by n adjacency matrix

n = length(A);
inds = find(triu(A));
entry = zeros(n,2);

% get edgelist
for i = 1 : length(inds) 
    from = mod(inds(i),n);
    if from == 0
        from = n;
    end
    entry(i,:) = [from,ceil(inds(i)/n)];
end
selected = zeros(length(inds),1);

% Select which edges become rewired to other nodes
while(sum(selected) == 0)
    selected = find(rand(length(inds),1) < frac);
end

for i = 1 : length(selected)
    from = entry(selected(i),1); to = entry(selected(i),2);
    rewire_i = zeros(n,1);
    while sum(rewire_i) == 0
        rewire_i = rand(n,1) < p;
        rewire_i(i) = 0;
    end
    
    rewire_i = find(rewire_i);
    A(from,to) = 0; A(to,from) = 0;

    for j = 1 : length(rewire_i)
        A(from,rewire_i(j)) = 1; A(rewire_i(j),from) = 1;
    end
end
graph = A;
    
    



