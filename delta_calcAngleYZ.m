% inverse kinematics
 % helper functions, calculates angle theta1 (for YZ-pane)
function [theta1, status] = delta_calcAngleYZ( x0,  y0,  z0) 
 global e f re rf
      y1 = -0.5 * tand(30) * f; % f/2 * tg 30
     y0 = y0 -0.5 * tand(30)    * e;    % shift center to edge
     % z = a + b*y
      a = (x0*x0 + y0*y0 + z0*z0 +rf*rf - re*re - y1*y1)/(2*z0);
      b = (y1-y0)/z0;
     % discriminant
      d = -(a+b*y1)*(a+b*y1)+rf*(b*b*rf+rf); 
     if (d < 0) status = -1; % non-existing point
     else
      yj = (y1 - a*b - sqrt(d))/(b*b + 1); % choosing outer point
      zj = a + b*yj;
     %theta = atand(-zj/(y1 - yj)) + ((yj>y1)?180.0:0.0);
     if (yj>y1) 
         q=180
     else q=0;
     end
     theta1 = atand(-zj/(y1 - yj)) + q;
     status= 0;
     end
end
 