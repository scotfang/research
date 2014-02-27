%function [Q, Pts, Nm]=getManhattanAxis(Pts)
% created by B. Zheng (bzheng01@ucla.edu)
% Input: points cloud [x y z]
% Output: 1) Manhatton axes Q; 2) transformed point cloud Pts; 3)
% transformed normals Nm
function [Q, Pts, Nm, center]=getManhattanAxis(Pts)

tri=delaunay(Pts(:,1),Pts(:,2));
FV.faces=tri;
FV.vertices=Pts;
FV2=smoothpatch(FV,1,10); %smoothing surface
figure
S=trisurf(FV2.faces,FV2.vertices(:,1),FV2.vertices(:,2),FV2.vertices(:,3),'EdgeColor','None');
V = get(S,'VertexNormals'); % get surface normals
close gcf;
%close
[V2]=normlizeV(V);

%% clustering
K=5;
[IDX] = kmeans(V2, K,'start','cluster');
%plot3k(Pts, 'ColorData', double(IDX)); hold on


Cluster_size=zeros(1,K);
for i=1:K,
   Cluster_size(i)=sum(IDX==i);
end
%Cluster_size
[~,order]=sort(Cluster_size, 'descend');

center=mean(Pts,1);
% A1=median(V2(IDX==order(1),:),1);
% A2=median(V2(IDX==order(2),:),1);
% A3=median(V2(IDX==order(3),:),1);

A1=mean(V2(IDX==order(1),:),1);
A2=mean(V2(IDX==order(2),:),1);
A3=mean(V2(IDX==order(3),:),1);


A=[A1;-A2;A3];
%A

%plotAxis(center,A,.500,'g');

[Q] = Gram_Schmidt(A');

%% fix the order of axis 
[~, a]=sort(Q(:),'descend');
[I,J]=ind2sub([3 3],a);
Qt=Q;
% Qt(:,I(1))=sign(Q(I(1),J(1)))*Q(:,J(1));
% Qt(:,I(2))=sign(Q(I(2),J(2)))*Q(:,J(2));
Qt(:,I(1))=Q(:,J(1));
Qt(:,I(2))=Q(:,J(2));
ins=[1 2 3];
iT=ins(ins~=I(2) & ins~=I(1));
jT=ins(ins~=J(2) & ins~=J(1));
% if length(iT) < length(jT)
%    jT = jT(1:length(iT));
% end
% if length(iT) > length(jT)
%    iT = iT(1:length(jT));
% end
if size(iT,2) ~= size(jT,2)
    Q = [];
    Nm = [];
    return;
end
Qt(:,iT)=Q(:,jT);

Q=Qt;
%plotAxis(center,Q',.500,'r');

tt2=[Pts(:,1)-center(1) Pts(:,2)-center(2) Pts(:,3)-center(3)]*Q;
Pts=[tt2(:,1)+center(1) tt2(:,2)+center(2) tt2(:,3)+center(3)];

Nm=V2*Q; % rotate normals






