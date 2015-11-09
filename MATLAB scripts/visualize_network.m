function [  ] = visualize_network( A,coordinates,state,ptsize )
% Plots the network A and indicates the infected nodes given in the
% n-vector state. 
%%%%%%%%% Inputs %%%%%%%%%
% A - (n by n) adjacency matrix
% coordinates - location of each node in the (x,y) plane (2 by n)
% state - (n by 1) a vector in {0,1}^n indicating which nodes are infected
% ptsize - size in which to draw the nodes
%%%%%%%%% Outputs %%%%%%%%%
% No outputs


A = double(A > 0);
if ~issymmetric(A)
    disp('Adjacency matrix not symmetric')
    return
end
n = length(A);
x_pos = coordinates(1,:); y_pos = coordinates(2,:);    
inds = find(triu(A)); % Assuming A is symmetric, indices of edge set
active = find(state); nonactive = find(state == 0);
scatter(x_pos(active),y_pos(active),ptsize,'MarkerFaceColor',[1 0 0]); % infecteds are filled
hold on
scatter(x_pos(nonactive),y_pos(nonactive),ptsize,'MarkerEdgeColor',[0 .5 .5]); % susceptibles are not filled
for i = 1 : length(inds)
    from = mod(inds(i),n);
    if from == 0
        from = n;
    end
    entry = [from,ceil(inds(i)/n)];
    if A(entry(1),entry(2))
        plot([x_pos(entry(1)),x_pos(entry(2))],[y_pos(entry(1)),y_pos(entry(2))],...
            'Color', [0 .5 .5],'LineWidth',.5)
    end
end
set(gca,'visible','off')
set(gca, 'XTick', [], 'YTick', [])
hold off
end


