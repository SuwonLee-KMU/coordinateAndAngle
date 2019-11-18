% Generated on: 191005
% Last modification: 191005
% Author: Suwon Lee from Seoul National University
classdef cl_curvedAngle < handle
  properties
  end
  methods
    function [fig,ax] = draw(obj,fignum,center,radius,initDir,termDir,varargin)
      fig = figure(fignum); 
      di = initDir/norm(initDir);
      df = termDir/norm(termDir);
      ang = acos(dot(di,df));
      nf = cross(di,df)/norm(cross(di,df));
      R = [di(:), cross(nf(:),di(:)), nf(:)];
      t = linspace(0,ang,20);
      x0 = radius*cos(t);
      y0 = radius*sin(t);
      z0 = zeros(1,numel(t));
      tmp = R*[x0;y0;z0];
      x1 = tmp(1,:);
      y1 = tmp(2,:);
      z1 = tmp(3,:);
      x = x1 + center(1);
      y = y1 + center(2);
      z = z1 + center(3);
      if isempty(varargin)
          plot3(x,y,z,'linewidth',1.5,'color','k','marker','none');
      else
          plot3(x,y,z,'linewidth',1.5,'marker','none',varargin{:});
      end
    end
  end
end
