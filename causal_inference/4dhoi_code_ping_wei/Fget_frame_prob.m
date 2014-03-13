function [ max_atom_prb, max_i, event_probs ] = Fget_frame_prob( x, grammar )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


N = size(grammar,2);
atom_prb = zeros(N,1);
D = size(x,1);
twopi = 1/((2*pi)^(D/2));
assert(mod(N,4) == 0);
event_probs = zeros(N/4, 1);
for i = 1:N
    mu = grammar(i).mu;
    S = grammar(i).sigma;
    atom_prb(i) = twopi*(1/sqrt(det(S)))*exp(-0.5*(x-mu)'*inv(S)*(x-mu));
    event_probs(ceil(i/4)) = event_probs(ceil(i/4)) + atom_prb(i);
    if (mod(i, 4) ~= 1)
        assert(strcmp(grammar(i).event, grammar(i-1).event), ...
            ['Grammar events not clustered in groups of 4! ', ...
            grammar(i-1).event, ' ~= ', grammar(i).event ]);
    end
end

%atom_prb = atom_prb/sum(atom_prb); %Don't normalize
[max_atom_prb, max_i] = max(atom_prb);

end

