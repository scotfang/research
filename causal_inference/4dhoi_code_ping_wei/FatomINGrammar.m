%%%%% FatomINGrammar.m
function grm = FatomINGrammar(atom,Grammar)

for i = 1:size(Grammar,2)
    if strcmp(Grammar(i).atom,atom)
        grm = Grammar(i);
        return
    end
end

