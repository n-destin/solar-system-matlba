function [rad] = radius(x1,x2,y1,y2)
%This function taked in x-coordinates x1 x2 for two points, 
% and y1 y2 y-coordinates for the same coordinates, and 
% returns the distance between them
% x1: X-position of the first object
% x2: X-position for the second object
% y1: y-position for the frist position
% y2: y-position for the second object

% 

rad = sqrt((x1-x2)^2+(y1-y2)^2);
end