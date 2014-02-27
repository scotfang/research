function [objbc,objwc,objrt,objprob] = FRemoveSmallProb(objbc,objwc,objrt,objprob,KR)


if length(objbc) ~= length(objwc) | length(objbc) ~= length(objprob) | length(objwc) ~= length(objprob)|length(objrt) ~= length(objprob)
    error('myApp:smallProb', 'The numbers of the interacting objects are not the same!');
end

if nargin < 5
    KR = 0.3;
end

for i = 1:length(objbc)
   wc =  objwc{i};
   bc =  objbc{i};
   rt =  objrt{i};
   prob =  objprob{i};
   [~,Ind] = sort(prob,'descend');
   if i > 2
      KR = 0.2;
   end
   KInd = Ind(1:ceil(KR*length(Ind)));
   objwc{i} = wc(KInd,:);
   objbc{i} = bc(KInd,:);
   objrt{i} = rt(KInd,:);
   objprob{i} = prob(KInd,:);
end