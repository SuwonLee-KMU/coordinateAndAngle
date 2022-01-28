% Example01 : example for curtain3.m

clear all; clc;
x = linspace(0,10,100);
y = sin(x);
z = cos(x);
[plt1,plt2] = curtain3(x,y,z,'color_positive','r',... % Positive color
                        'color_negative','b',...      % Negative color
                        'num_points',200,...          % Discretization level
                        'alpha',0.3,...               % Opacity
                        'ground',0.2);                % Set ground level
xlabel('x')
ylabel('y')
zlabel('z')
grid on;