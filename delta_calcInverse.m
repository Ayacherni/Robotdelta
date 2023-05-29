 % inverse kinematics: (x0, y0, z0) -> (theta1, theta2, theta3)
 % returned status: 0=OK, -1=non-existing position
 function [theta1, theta2, theta3, status]= delta_calcInverse( x0,  y0,  z0) 
     theta1 = 0;
     theta2 = 0;
     theta3 = 0;
     [theta1,status] = delta_calcAngleYZ(x0, y0, z0);
     if (status == 0) 
         [theta2,status] = delta_calcAngleYZ(x0*cosd(120) + y0*sind(120), y0*cosd(120)-x0*sind(120), z0);  % rotate coords to +120 deg
     end
     if (status == 0) 
         [theta3,status] = delta_calcAngleYZ(x0*cosd(120) - y0*sind(120), y0*cosd(120)+x0*sind(120), z0);  % rotate coords to -120 deg
     end
 end
 