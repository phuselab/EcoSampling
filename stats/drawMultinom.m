function x = drawMultinom(p)

% Draw size(p,2) samples from a multinomial distribution where the
% elements [1..size(p,1)] have probabilities p.  

for i = 1:length(p)
    % Calls sample_discrete() from KPMstats
    % SAMPLE_DISCRETE Like the built in 'rand', except we draw from a
    % non-uniform discrete distrib.
    % Example: sample_discrete([0.8 0.2], 1, 10) generates a row vector of 10 random integers from {1,2},
    % where the prob. of being 1 is 0.8 and the prob of being 2 is 0.2.
    x(i) = sample_discrete(p(:,i),1,1);
end