# Dynamic Programming Toolbox

This repository contains reference implementation of some popular algorithms that use or are relevant to dynamic programming. It is a work-in-progress towards a MATLAB toolbox of sorts, which can be used for solving specific problems, like Knapsack or TSP, but is not limited to the problems itself.

### Code explanation
- algorithm.m contains function for the particular algorithm.
- tutorial.m contains basic illustration for each of the algorithms in use.

### Functions
#### Minimum Cost Trajectory (optTrajectory.m)
Compute a minimum cost trajectory from a starting node to the terminal node, given cost from each node to every other node at each stage.

#### Label Correcting Algorithms (shortestPath.m)
Use label correcting algorithms (specific variants of which are Bellman-Ford, Depth-First Search, Dijkstra's) to compute route and cost in the shortest path problem, given cost from each node to every other node and the variant of label correcting algorithm to use.

#### Markov Chain Simulator (markovSim.m)
Simulate an n-state Markov Chain over T stages, given state transition probability matrix and probability of initial condition.

#### DP Solver for Finite-State Markov Chain (markovDP.m)
Use dynamic programming to find optimal cost-to-go and optimal control action at initial time, given state transition probability matrices under each control action, cost of using control action at each state for going to another state and the termination time.

#### Value Iteration (valueIteration.m)
Compute cost-to-go and optimal policy using value iteration even in discounted problem setup.

#### Policy Iteration (policyIteration.m)
Compute cost-to-go and optimal policy using policy iteration even in discounted problem setup.

#### Inventory Control (inventory.m)
Compute optimal inventory thresholds in a setup where demand only takes integer values.