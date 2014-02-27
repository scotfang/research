%%%%% FTransEnergy.m
%%%%% Compute the transition probability
%%%%% tuple: the tuple of current atomic event
%%%%% ron: repeat or next atomic event, 0: repeat, 1: next atomic event, 2:
%%%%% next event


function trans_energy = FTransEnergy(grammar,tuple,ron)%% repeat or next

a = grammar.transpara(1);
b = grammar.transpara(2);
if ron == 0
    %trans_energy = -log(1/(1+exp(a*tuple+b)));
    trans_energy = -log(0.95);
end

if ron == 1
   %trans_energy = -log(1/(1+exp(-a*tuple-b))); 
   trans_energy = -log(0.05);
end

if ron == 2
   selfp = 1/(1+exp(a*tuple+b));
   otherp = (1 - selfp)/8;
   trans_energy = -log(otherp); 
end

