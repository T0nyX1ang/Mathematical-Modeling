% Exercise 7 - Interpolations
% Edited by Tony Xiang
% Last Modified in 2018-7-13
% -> More Files at D:\001 My things\009 Books and Essays\国赛建模\MATLAB培训程序\插值1.m

%% Main Exercise
x=[129.0,140.0,103.5,88.0,185.5,195.0,105.5,157.5,107.5,77.0,81.0,162.0,162.0,117.5];
y=[7.5,141.5,23.0,147.0,22.5,137.5,85.5,-6.5,-81.0,3.0,56.5,-66.5,84.0,-33.5];
z=[-4,-8,-6,-8,-6,-8,-8,-9,-9,-8,-8,-9,-4,-9];
[xi, yi] = meshgrid(75:1:200, -50:1:150);
zi = griddata(x, y, z, xi, yi, 'cubic');
meshz(xi, yi, zi)
% contour(xi, yi, zi, -5:0.1:0)

%% Interpolation Tools
% interpn(x1,x2,...,xn,y,xx1,xx2,...,xxn,'method')
    % Methods: nearest, linear, spline, cubic
% pp = spline(x, y) % Return A Polymonial Demonstration of Interpolation
% yi = ppval(pp, xi) % Calculate Value of pp
% fnval(pp, x) % Calculate Value of pp at x
% fprime = fnder(pp) % Calculate Derivative of pp
% fprime = fnder(pp, dorder) % Calculate [Dorder] Derivative of pp
% fzeros = fnzeros(pp, [range]) % Calculate zero points of pp [in range]
% intgrf = fnint(pp) % Calculate Integral of pp
% intgrf = fnint(pp) % Calculate Integral of pp [With Left Endpoint]
% fnplt(pp) % Plot pp
% ndgrid % High Dimension Grid
% griddata(x1,x2,...,xn,y,xx1,xx2,...,xxn,'method') % Used for bad data

%% Plot Tools
% plot
% plot3
% meshgrid
% ndgrid
% mesh
% meshz
% contour

%% Animations
% movie
% surf

%% Other
% flow %  function of three variables, generates fluid flow data that is useful for demonstrating SLICE, INTERP3, and other functions that visualize scalar volume data.