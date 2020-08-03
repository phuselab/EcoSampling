nu(1)=1; nu(2)=1; nu(3)=1;
theta = dirichlet_sample(nu, 1)

z = sample_discrete(theta,1,1)
%z = drawMultinom(theta,1)