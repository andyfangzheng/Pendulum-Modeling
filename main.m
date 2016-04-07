%% Yuan Gao, AMATH 383, Spring 2015 - Homework 5: Pendulum

%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the homework.
%  You can change the parameters below to expriment with different
%  parameters.
%
%  Before doing anything, you can run this file to see what happens!
%
%  getTorque.m : the only file you need to implement
%  next.m      : calculates derivative of the angle and angular velocity
%  submit.m    : run submit.m to submit your code to grading server
%

clear all; close all; clc
%% ------------- parameters definition -------------

% -- dynamics --
a = 1; % parameter that models gravity, mass and length (a > 0)
b = 0.1; % parameter that models damping (b > 0)

% -- time step --
h = 0.1;

% -- maximum control torque --
umax = 0.2;

% -- initial angle and angular velocity --
angle = pi/1.5; % initial angle
velocity = 0; % initial velocity

% -- record the values of (u, angle, velocity) for plot and analysis --
record = zeros(3,501);
record(:, 1) = [0 angle velocity];

%% ------------- simulation of the dynamics -------------
score = 0;

disp('Running simulation ...')

for i = 1:500
    
    % calculate torque
    % this is the ONLY function you need to implement
    u = getTorque(a, b, h, record(1, 1:i), record(2, 1:i), record(3, 1:i), umax);
    if abs(u) >= umax,
        sprintf('Error: Torque exceeded maximum allowed torque!');
        score = 0;
        break;
    end
    
    % integrate the dynamics forward
    pendulumODE = @(t,x) next(a,b,x,u);
    [t,y] = ode45(pendulumODE, linspace(0, h, 2), [angle velocity]);
    angle = y(end,1);
    velocity = y(end,2);
    
    % record the intermediate values
    record(:, i+1) = [u angle velocity];
    
    % update score
    score = score + exp(1.0 - cos(angle));
    
    % plot the dynamics
    clf;
    plot(sin(angle), -cos(angle), 'o'); % draw the ball
    % uncomment the line below to show velocity at current step
    % text(sin(angle), -cos(angle), num2str(velocity));
    hold on
    plot([0 sin(angle)], [0 -cos(angle)], 'k-'); % draw the line
    axis([-1 1 -1 1]);
    xlabel(['time = ' num2str(i) 'h']);
    drawnow
end

%% ------------- print result and plot -------------
disp(['Your score for this sample test case is: ' num2str(score)])

% this plot helps you analyze your controller
figure;
plot(1:501, record);
legend('u','angle','velocity');