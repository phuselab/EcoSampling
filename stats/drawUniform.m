function r=drawUniform(a,b,M,N)
    %Generate uniform values from the interval [a, b].
    r = a + (b-a).*rand(M,N);