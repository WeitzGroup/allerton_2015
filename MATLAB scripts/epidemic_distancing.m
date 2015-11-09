function [total_infections,temp_util,betas] = epidemic_distancing(beta,delta,alpha,A_C,A_I,T,state)
% Exact Markov chain model of awareness model
%%%%%%%%% Inputs %%%%%%%%%
% beta,delta,alpha - epidemic and awareness parameters
% A_C, A_I - adjacency matrices of contact and info networks (n by n)
% T - run-time (positive integer)
% state - initial infected state vector (n by 1)
%%%%%%%%% Outputs %%%%%%%%%
% total_infections - total infected at each time instant (1 by T)
% temp_util - value of J metric (eq 13) over one sample run
% betas - agents' interaction values over time (n by T)

n = length(A_C);
betas = zeros(n,T);
temp_util = 0;
for t = 1 : T
    rand_sample = rand(n,1);
    prob_action = zeros(n,1);
    for i = 1 : n 
        M_i = [(1/sum(A_C(i,:)))*A_C(i,:); (1/sum(A_I(i,:)))*A_I(i,:);  (1/n)*ones(1,n)];
        betas(i,t) = beta*(1 - alpha*M_i*state(:,t));

        infected_neighs = A_C(i,:)*state(:,t);
        if state(i,t) == 1 % Probability of recovery
            prob_action(i) = 1 - delta;
        else % Probability of infection
            prob_action(i) = 1 - (1 - betas(i,t))^(infected_neighs);
        end
        
        prob_infect = 1 - (1 - betas(i,t))^(infected_neighs);
        score0 = (1 - state(i,t))*((1 - prob_infect)*betas(i,t) + (beta - betas(i,t))*prob_infect);
        score1 = state(i,t)*(delta*betas(i,t) + (beta - betas(i,t))*(1-delta));
        temp_util = temp_util + (1/beta)*(score0 + score1);
    end
    if t < T
        % Disease Dynamics with behavior
        state(:,t+1) = (rand_sample < prob_action); 
    end
end

total_infections = sum(state,1);
temp_util = temp_util/(n*T);

end