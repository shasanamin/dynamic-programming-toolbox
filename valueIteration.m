function [J, mu] = valueIteration(P,g,alpha,max_iter)
%valueIteration Generic value iteration solver with discounts
%   Input:
%`      - P: NxNxM transition probabilities matrix, where p(i,j,k) is the 
%       probability of transition from state i to state j on choosing action k
%       - g: NxM stage cost matrix, where g(i,j) is the cost/reward of 
%       using action j at state i
%       - alpha: discount factor (0 <= alpha < 1)
%       - max_iter: maximum number of iterations to terminate the algorithm
%   Output:
%       - J: costs associated with optimal policy
%       - mu: optimal policy

    num_states = size(P,1);
    
    % cost initialization
    J = zeros(1,num_states);
    J_new = zeros(1,num_states);

    % policy initialization
    mu = ones(1,num_states);

    for k=1:max_iter
        for i=1:num_states
            [J_new(i), mu(i)] = max(g(i,:) + alpha*J*squeeze(P(i,:,:)));
        end

        % Saving results over iterations (although not required per se)
        J_all_iter(k,:) = J_new;

        % Update cost
        J = J_new;
    end
end
