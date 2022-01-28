% Generated on: Aug 24, 2020
% Last modification: Aug 24, 2020
% Author: Suwon Lee from Seoul National University

function [plt1,plt2] = curtain3(x,y,z,varargin)
    % Default values
    curtain_color_positive = 'r';
    curtain_color_negative = 'b';
    curtain_alpha = 0.3;
    numpoints     = 100;
    ground        = 0;
    % Hand over varargin
    if nargin >= 4
        id = find(strcmp(varargin,'color_positive')) + 1;
        if ~isempty(id); curtain_color_positive = varargin{id}; end
        id = find(strcmp(varargin,'color_negative')) + 1;
        if ~isempty(id); curtain_color_negative = varargin{id}; end
        id = find(strcmp(varargin,'num_points'))+1;
        if ~isempty(id); numpoints = varargin{id}; end
        id = find(strcmp(varargin,'alpha'))+1;
        if ~isempty(id); curtain_alpha = varargin{id}; end
        id = find(strcmp(varargin,'ground'))+1;
        if ~isempty(id); ground = varargin{id}; end
    end

    ndata = numel(x);
    index = ceil(linspace(1,ndata,numpoints));
    Xp = [];
    Yp = [];
    Zp = [];
    Xn = [];
    Yn = [];
    Zn = [];
    for i = 1:numel(index)-1
        id1 = index(i);
        id2 = index(i+1);
        x_tmp = [x(id1); x(id2); x(id2); x(id1)];
        y_tmp = [y(id1); y(id2); y(id2); y(id1)];
        z_tmp = [z(id1); z(id2); ground; ground];
        if z(id1) >= ground
            Xp = cat(2,Xp,x_tmp);
            Yp = cat(2,Yp,y_tmp);
            Zp = cat(2,Zp,z_tmp);
        else
            Xn = cat(2,Xn,x_tmp);
            Yn = cat(2,Yn,y_tmp);
            Zn = cat(2,Zn,z_tmp);
        end
    end
    plt1 = fill3(Xp,Yp,Zp,curtain_color_positive,'facealpha',curtain_alpha,...
        'edgecolor','none');
    hold on;
    plt2 = fill3(Xn,Yn,Zn,curtain_color_negative,'facealpha',curtain_alpha,...
        'edgecolor','none');
    hold off;
end