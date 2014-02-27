function GP = FGaussianProb(Vec,Mu,Sigma)

thr = 0.2;
GP = zeros(size(Vec,1),1);
if ~isempty(Mu) & ~isempty(Sigma)
    D = size(Vec,2);
    twopi = 1/((2*pi)^(D/2));
    InvSigma = inv(Sigma);
    DetSigma = (1/sqrt(det(Sigma)));   
    
    % IBTime = toc
    % for i = 1:size(Vec,1)
    %     tGP(i) = twopi*DetSigma*exp(-0.5*((Vec(i,:))-Mu)*InvSigma*((Vec(i,:))-Mu)');
    % end
    
    RMu = repmat(Mu,size(Vec,1),1);
    En = -0.5*diag((Vec-RMu)*InvSigma*(Vec-RMu)');
    GP = twopi*DetSigma*exp(En);
else
    tNVec = Vec.*Vec;
    NVec = sqrt(sum(tNVec,2));
    ind = find(NVec < thr);
    if ~isempty(ind)
        GP(ind) = 1;
    else
       [~,IX] = sort(NVec);
       ind = IX(1:ceil(length(NVec)/5));
       GP(ind) = 1;
    end
    
end

