% function that calculates the torque
% parameters:
% a, b: problem parameters
% h: time step
% us: a row vector of controls used in the past.
% as: a row vector of historical angles, with the last element being the current angle
% vs: a row vector of historical velocities, with the last element being the current velocity
% umax: maximum torque

function u = getTorque(a, b, h, us, as, vs, umax)
    % you have to implement this function
    % rememeber to make sure that |u| < umax
    if umax > 0.5
        reachtop = 0;
        for i = 1:length(as)
           if cos(as(i)) <= -0.8
              top = as(i);
              reachtop = 1;
              break;
           end
        end
        if reachtop == 1  && cos(as(end)) <= -0.3
            u = -vs(end)/h + a*sin(us(end)) + b*vs(end);         
        else
           if vs(end) >= 0
               u = umax;
           else
               u = -umax;
           end
        end
        if u >= umax
           u = umax - 0.0001;
        elseif u <= -umax
           u = -umax + 0.0001;
        end
    else
        reachtop = 0;
        for i = 1:length(as)
           if cos(as(i)) <= -0.4
              top = as(i);
              reachtop = 1;
              break;
           end
        end
        if reachtop == 1  && cos(as(end)) <= -0.6
            u = -vs(end)/h + a*sin(us(end)) + b*vs(end);         
        else
           if vs(end) >= 0
               u = umax;
           else
               u = -umax;
           end
        end
        if u >= umax
           u = umax - 0.0001;
        elseif u <= -umax
           u = -umax + 0.0001;
        end
    end 
        
 