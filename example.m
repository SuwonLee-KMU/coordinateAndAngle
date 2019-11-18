clear all; clc;

pos = [2,1,1];
gam = pi/180* 30;
chi = pi/180* 30;
gld = cl_gliderpatch(pos,gam,chi);
gld.scale = .2;
gld.showaxis(1,'invert');
hold on;
gld.visualize(1);
gld.connect(1);
gld.project(1);
gld.showbodycoordinate(1);
gld.showbodyaxis(1);
hold off;
% return;

crv = cl_curvedAngle;
hold on;
crv.draw(1,[0,0,0],1.5,gld.position,[gld.position(1:2),0]);
crv.draw(1,[0,0,0],1.5,[0,1,0],[gld.position(1:2),0]);
crv.draw(1,gld.position,1,[0,1,0],[cos(gld.heading),sin(gld.heading),0],'color','r');
crv.draw(1,gld.position,1,...
    [cos(gld.pathAngle)*cos(gld.heading),...
    cos(gld.pathAngle)*sin(gld.heading),...
    sin(gld.pathAngle)],[cos(gld.heading),sin(gld.heading),0],'color','r');
hold off;

set(gca,'visible','off')
% export_fig 'asdf.png' -m5 -dpng -transparent