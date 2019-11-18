% Generated on: 191003
% Last modification: 191003
% Author: Suwon Lee

classdef cl_gliderpatch < handle
    properties
        position
        pathAngle
        heading

        height = 3;
        width  = 2;
        notch  = 1;
        depth  = 0.2;
        scale  = 1;
        color  = 'white';
    end
    methods     % Constructor methods 
        function  obj = cl_gliderpatch(pos,gamma,chi)
            obj.position  = pos;
            obj.pathAngle = gamma;
            obj.heading   = chi;
        end
    end
    methods 
        function [fig,ax] = visualize(obj,fignum)
            fig = figure(fignum);
            V0 = obj.getVertex;
            V  = V0 + repmat(obj.position(:),1,8);
            F  = [1,2,3,4;5,6,7,8];
            F2 = zeros(4,4);
            for i = 1:4
                if i == 4
                  F2(i,:) = [i,1,1+4,i+4];
                else
                  F2(i,:) = [i,i+1,i+1+4,i+4];
                end
            end
            ax(1) = patch('vertices',V','faces',F,'facecolor',obj.color);
            ax(2) = patch('vertices',V','faces',F2,'facecolor',0.5*[1,1,1]);
            axis equal; grid on; box on;
        end
        function [fig,ax] = connect(obj,fignum)
            fig = figure(fignum);
            x = [0,obj.position(1)]; 
            y = [0,obj.position(2)]; 
            z = [0,obj.position(3)];
            ax = line(x,y,z,'linewidth',1.5,'color','k');
        end
        function [fig] = project(obj,fignum)
            fig = figure(fignum);
            x1 = [0,obj.position(1)];
            y1 = [0,obj.position(2)];
            z1 = [0,0];
            line(x1,y1,z1,'linewidth',1.5,'color',[1,1,1]*0.6,'linestyle','--');
            x2 = repmat(obj.position(1),1,2);
            y2 = repmat(obj.position(2),1,2);
            z2 = [0,obj.position(3)];
            line(x2,y2,z2,'linewidth',1.5,'color',[1,1,1]*0.6,'linestyle','--');
        end
        function [fig,ax] = showbodycoordinate(obj,fignum)
            fig = figure(fignum);
            x = obj.position(1); y = obj.position(2); z = obj.position(3);
            u = 2*cos(obj.pathAngle)*cos(obj.heading);
            v = 2*cos(obj.pathAngle)*sin(obj.heading);
            w = 2*sin(obj.pathAngle);
            axisopt = {'linewidth',1.5,'color','k','autoscale','off','maxheadsize',.5};
            ax(1) = quiver3(x,y,z,2,0,0,axisopt{:});
            ax(2) = quiver3(x,y,z,0,2,0,axisopt{:});
            ax(3) = quiver3(x,y,z,0,0,-.7,axisopt{:});
            ax(4) = quiver3(x,y,z,u,v,w,axisopt{:},'color','r');
            x1 = [0,u]+obj.position(1);
            y1 = [0,v]+obj.position(2);
            z1 = [0,0]+obj.position(3);
            x2 = [u,u]+obj.position(1);
            y2 = [v,v]+obj.position(2);
            z2 = [0,w]+obj.position(3);
            line(x1,y1,z1,'linewidth',1.5,'color','r','linestyle','--');
            line(x2,y2,z2,'linewidth',1.5,'color','r','linestyle','--');
        end
        function [fig,ax] = showbodyaxis(obj,fignum)
            fig = figure(fignum);
            x = obj.position(1); y = obj.position(2); z = obj.position(3);
            len = 1;
            ux = len*cos(obj.pathAngle)*cos(obj.heading);
            vx = len*cos(obj.pathAngle)*sin(obj.heading);
            wx = len*sin(obj.pathAngle);
            uy = -len*sin(obj.heading);
            vy = len*cos(obj.heading);
            wy = 0;
            uz = len*sin(obj.pathAngle)*cos(obj.pathAngle);
            vz = len*sin(obj.pathAngle)*sin(obj.pathAngle);
            wz = -len*cos(obj.pathAngle);
            axisopt = {'linewidth',1.5,'color','b','autoscale','off','maxheadsize',.5};
            ax(1) = quiver3(x,y,z,ux,vx,wx,axisopt{:});
            ax(2) = quiver3(x,y,z,-uy,-vy,wy,axisopt{:});
            ax(3) = quiver3(x,y,z,uz,vz,wz,axisopt{:});
        end
        function [fig,ax] = 
    end
    methods 
      function V = shape(obj)
        x0 = zeros(1,8);
        y0 = zeros(1,8);
        z0 = zeros(1,8);
        x0(1) = 0;
        x0(2) = -obj.width/2;
        x0(3) = 0;
        x0(4) = obj.width/2;
        y0(1) = obj.height/2;
        y0(2) = -obj.height/2;
        y0(3) = -obj.height/2 + obj.notch;
        y0(4) = -obj.height/2;
        for i = 1:4
          x0(i+4) = x0(i);
          y0(i+4) = y0(i);
          z0(i) = obj.depth;
          z0(i+4) = -obj.depth;
        end
        
        V = obj.rot(3,-pi/2)*[x0;y0;z0]*obj.scale;
      end
      function V = getVertex(obj)
        V0 = obj.shape();
        R  = obj.rot(3,obj.heading)*obj.rot(2,-obj.pathAngle);
        V  = R*V0;
      end
    end
    methods (Static)
        function [fig,ax] = showaxis(fignum,varargin)
            fig = figure(fignum);
            axisopt = {'linewidth',1.5,'color','k','autoscale','off','maxheadsize',.2};
            ax(1) = quiver3(-1,0,0,5,0,0,axisopt{:}); hold on;
            ax(2) = quiver3(0,-1,0,0,5,0,axisopt{:});
            if isempty(varargin)
                ax(3) = quiver3(0,0,-1,0,0,5,axisopt{:});
            elseif strcmp(varargin{1},'invert')
                ax(3) = quiver3(0,0,.5,0,0,-2,axisopt{:});
            else
                error('invalid argument');
            end
            hold off;
        end
      function R = rot(axisIdx,angle)
        switch axisIdx
          case 1
            R = [1,0,0; 0,cos(angle),-sin(angle);0,sin(angle),cos(angle)];
          case 2
            R = [cos(angle),0,sin(angle);0,1,0;-sin(angle),0,cos(angle)];
          case 3
            R = [cos(angle),-sin(angle),0;sin(angle),cos(angle),0;0,0,1];
          otherwise
            error('invalid axisIdx');
        end
      end
    end
end
