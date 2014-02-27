%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fplot3Dbox(obox,clr,lw);
% Descripton: plot the 3D bounding box
% Input: 
% obox: 3D coordinates of vertex of object bounding box, 8*3
% clr: bounding box clor,[r g b], r,g,b(-[0,1]
% lw: line width
% By Ping Wei, 01-27-2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Fplot3DScene(obox,clr,lw)


% plot3(obox(1:2,1),obox(1:2,2),obox(1:2,3),'-','Color',clr,'LineWidth',lw); hold on
 plot3(obox(2:3,1),obox(2:3,2),obox(2:3,3),'-','Color',clr,'LineWidth',lw); hold on
 plot3(obox(3:4,1),obox(3:4,2),obox(3:4,3),'-','Color',clr,'LineWidth',lw);
% plot3(obox([1,4],1),obox([1,4],2),obox([1,4],3),'-','Color',clr,'LineWidth',lw);

plot3(obox(5:6,1),obox(5:6,2),obox(5:6,3),'-','Color',clr,'LineWidth',lw);
plot3(obox(6:7,1),obox(6:7,2),obox(6:7,3),'-','Color',clr,'LineWidth',lw);
plot3(obox(7:8,1),obox(7:8,2),obox(7:8,3),'-','Color',clr,'LineWidth',lw);
plot3(obox([5,8],1),obox([5,8],2),obox([5,8],3),'-','Color',clr,'LineWidth',lw);

% plot3(obox([1,5],1),obox([1,5],2),obox([1,5],3),'-','Color',clr,'LineWidth',lw);
plot3(obox([2,6],1),obox([2,6],2),obox([2,6],3),'-','Color',clr,'LineWidth',lw);
plot3(obox([3,7],1),obox([3,7],2),obox([3,7],3),'-','Color',clr,'LineWidth',lw);
plot3(obox([4,8],1),obox([4,8],2),obox([4,8],3),'-','Color',clr,'LineWidth',lw);


% plot3(obox(1:2,1),obox(1:2,2),obox(1:2,3),'-','Color',clr,'LineWidth',lw); hold on
% plot3(obox(2:3,1),obox(2:3,2),obox(2:3,3),'-','Color',clr,'LineWidth',lw);
% plot3(obox(3:4,1),obox(3:4,2),obox(3:4,3),'-','Color',clr,'LineWidth',lw);
% plot3(obox([1,4],1),obox([1,4],2),obox([1,4],3),'-','Color',clr,'LineWidth',lw);
% 
% plot3(obox(5:6,1),obox(5:6,2),obox(5:6,3),'-','Color',clr,'LineWidth',lw);
% plot3(obox(6:7,1),obox(6:7,2),obox(6:7,3),'-.','Color',clr,'LineWidth',lw);
% plot3(obox(7:8,1),obox(7:8,2),obox(7:8,3),'-.','Color',clr,'LineWidth',lw);
% plot3(obox([5,8],1),obox([5,8],2),obox([5,8],3),'-','Color',clr,'LineWidth',lw);
% 
% plot3(obox([1,5],1),obox([1,5],2),obox([1,5],3),'-','Color',clr,'LineWidth',lw);
% plot3(obox([2,6],1),obox([2,6],2),obox([2,6],3),'-','Color',clr,'LineWidth',lw);
% plot3(obox([3,7],1),obox([3,7],2),obox([3,7],3),'-.','Color',clr,'LineWidth',lw);
% plot3(obox([4,8],1),obox([4,8],2),obox([4,8],3),'-','Color',clr,'LineWidth',lw);
