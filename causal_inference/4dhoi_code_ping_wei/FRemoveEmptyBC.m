%%%%% remove those box centers at which the boxes contains no point cloud
function Bc = FRemoveEmptyBC(BcOrg,Pc,bS)

if nargin < 3 
    bS = 0.03; % 0.03
end

Bc = [];
m = 0;
%StarTime = toc
for i = 1:size(BcOrg,1)
    Box(1,1) = BcOrg(i,1) - bS;
    Box(2,1) = BcOrg(i,1) + bS;
    Box(1,2) = BcOrg(i,2) - bS;
    Box(2,2) = BcOrg(i,2) + bS;
    Box(1,3) = BcOrg(i,3) - bS;
    Box(2,3) = BcOrg(i,3) + bS;    
    [InPts,~] = FFindPtsInBox(Pc,Box);
    if size(InPts,1) > 2
        m = m + 1;
        Bc(m,:) = BcOrg(i,:);
    end    
end
%EndTime = toc
%DurTime = EndTime - StarTime

% StarTime = toc
% Box = zeros(size(BcOrg,1),6);
% Box(:,1) = BcOrg(:,1) - bS;
% Box(:,2) = BcOrg(:,1) + bS;
% Box(:,3) = BcOrg(:,2) - bS;
% Box(:,4) = BcOrg(:,2) + bS;
% Box(:,5) = BcOrg(:,3) - bS;
% Box(:,6) = BcOrg(:,3) + bS;
% for i = 1:size(BcOrg,1)  
%     box = reshape(Box(i,:),2,3);
%     [InPts,~] = FFindPtsInBox(Pc,box);
%     if size(InPts,1) > 2
%         m = m + 1;
%         Bc(m,:) = BcOrg(i,:);
%     end    
% end
% EndTime = toc
%a = 1;