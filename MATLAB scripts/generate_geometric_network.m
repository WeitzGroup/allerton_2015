function [ graph,coordinates ] = generate_geometric_network( n,x_dim,y_dim,r )
% Generates a random geometric network
%%%%%%%%% Inputs %%%%%%%%%
% n = number of nodes
% x_dim and y_dim are dimensions of box
% r is the link distance threshold
%%%%%%%%% Outputs %%%%%%%%%
% graph is the n by n adjacency matrix (undirected)
% coordinates are the randomly placed (x,y) node coordinates (2 by n)

x_pos = x_dim*rand(1,n);
y_pos = y_dim*rand(1,n);
coordinates = [x_pos;y_pos];
distances = sqDistance(coordinates,coordinates);
graph = distances < r;
graph(1:n+1:end) = zeros(1,n);
end

