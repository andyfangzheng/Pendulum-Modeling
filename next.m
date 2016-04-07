% a function that simulates the dynamics
% you don't have to worry about this function
% parameters:
% a, b: problem parameters
% x: current state, u: torque

function xdot = next(a, b, x, u)
    xdot = [x(2); - a * sin(x(1)) - b * x(2) + u];
