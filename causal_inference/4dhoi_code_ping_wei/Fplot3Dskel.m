%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fplotskel(S);
% Descripton: plot the human body skeleton with 2D joint coordinates
% Input: 
% S: 3D joint coordinates, 20*2 dims
% By Ping Wei, 01-07-2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Fplot3Dskel(S)

lw = 3;
ms = 15;

plot3(S(1:2,1),S(1:2,2),S(1:2,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms); hold on
plot3(S(2:3,1),S(2:3,2),S(2:3,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);
plot3(S(3:4,1),S(3:4,2),S(3:4,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);

plot3([S(3,1) S(5,1)],[S(3,2) S(5,2)],[S(3,3) S(5,3)],'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);
plot3(S(5:6,1),S(5:6,2),S(5:6,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);
plot3(S(6:7,1),S(6:7,2),S(6:7,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);
plot3(S(7:8,1),S(7:8,2),S(7:8,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);

plot3([S(3,1) S(9,1)],[S(3,2) S(9,2)],[S(3,3) S(9,3)],'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);
plot3(S(9:10,1),S(9:10,2),S(9:10,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);
plot3(S(10:11,1),S(10:11,2),S(10:11,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);
plot3(S(11:12,1),S(11:12,2),S(11:12,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);

plot3([S(1,1) S(13,1)],[S(1,2) S(13,2)],[S(1,3) S(13,3)],'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);
plot3(S(13:14,1),S(13:14,2),S(13:14,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);
plot3(S(14:15,1),S(14:15,2),S(14:15,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);
plot3(S(15:16,1),S(15:16,2),S(15:16,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);

plot3([S(1,1) S(17,1)],[S(1,2) S(17,2)],[S(1,3) S(17,3)],'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);
plot3(S(17:18,1),S(17:18,2),S(17:18,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);
plot3(S(18:19,1),S(18:19,2),S(18:19,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);
plot3(S(19:20,1),S(19:20,2),S(19:20,3),'-r.','LineWidth',lw,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',ms);


%axis equal
%% plot with M(:,4:6)
%set(gca,'CameraPosition',[100 30 -5000]);
%set(gca,'CameraUpVector',[0 -1 0]);
%axis([0 640 0 480]);

%% plot with M(:,1:3)

 set(gca,'CameraPosition',[0.2 0.4 0]);
 set(gca,'CameraUpVector',[0 1 0]);
 axis([-1.0 1.0 -0.75 0.75]);
 set(gca,'ZTickLabel',[]);
 grid on

 %axis([-2 2 -2 2 -2 4]);

 %himage=findobj('tag','z');
 %set(himage,'visible','off');
 %set(himage,'handlevisibility','off');


 %set(gca,'CameraViewAngleMode','manual')
 %set(gca,'CameraPosition',[146 33 -7482]);
 %set(gca,'CameraTargetMode','manual');
 %set(gca,'CameraTarget',[458 216 2831]);
 %set(gca,'CameraUpVectorMode','manual');
 %set(gca,'CameraUpVector',[0 -1 0]);
 %view(-52,-76);
 %xlabel('x'),ylabel('y'),zlabel('z');
 %view(2,-90) 

 %plot(x,y,'--rs','LineWidth',2,...
                 %'MarkerEdgeColor','k',...
                 %'MarkerFaceColor','g',...
                 %'MarkerSize',10)

