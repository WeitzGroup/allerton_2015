function total_infections = epidemic_homogeneous(beta,delta,A_C,T,state)
% Exact Markov chain model of homogeneous model
%%%%%%%%% Inputs %%%%%%%%%
% beta,delta,alpha - epidemic and awareness parameters
% A_C, A_I - adjacency matrices of contact and info networks (n by n)
% T - run-time (positive integer)
% state - initial infected state vector (n by 1)
%%%%%%%%% Outputs %%%%%%%%%
% total_infections - total infected at each time instant (1 by T)

n = length(A_C);
for t = 1 : T
    rand_sample = rand(n,1);
    prob_no_action = zeros(n,1);
    for i = 1 : n         
        infected_neighs = A_C(i,:)*state(:,t);
        if state(i,t) == 1
            prob_no_action(i) = 1 - delta;
        else
            prob_no_action(i) = 1 - (1 - beta)^(infected_neighs);
        end
    end
    if t < T
        % Disease Dynamics without behavior
        state(:,t+1) = rand_sample < prob_no_action; 
    end
end
total_infections = sum(state,1);

end
