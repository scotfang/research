%%%%% Fatom_prb.m
%%%%% compute the probability of each atomic event

function atom_prb = Fatom_prb(x,Grammar)

N = size(Grammar,2);
atom_prb = zeros(N,1);
D = size(x,1);
twopi = 1/((2*pi)^(D/2));
for i = 1:N
    mu = Grammar(i).mu;
    S = Grammar(i).sigma;
    atom_prb(i) = twopi*(1/sqrt(det(S)))*exp(-0.5*(x-mu)'*inv(S)*(x-mu));
end

atom_prb = atom_prb/sum(atom_prb);

