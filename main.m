% robot geometry
 % (look at pics above for explanation)
 global e f re rf
 e = 115;     % end effector
 f = 457.3;     % base
 re = 232;
 rf = 112;
 theta1_i=-30;
 theta1_f=30;
 theta2=30;
 theta3=70;
 
 theta1(1)=theta1_i;
 r(1)=0;
 x0_i=-150; x0_f=150;
 y0=0;
 z0=-212;
 for k=1:100
     r(k)=k/100;
 x0 = x0_i +r(k)*(x0_f-x0_i);
 [theta1, theta2, theta3, status]= delta_calcInverse( x0,  y0,  z0)
 %theta1 = theta1_i +r(k)*(theta1_f-theta1_i);
 %[x0,y0,z0, status ]=delta_calcForward(theta1,  theta2,  theta3)
 S1=[3*f/sqrt(3) -f 0]
 S2=[0 2*f 0]
 S3=[-3*f/sqrt(3) -f 0]

 B1=[0 -f 0];
 B2=[0.5*sqrt(3)*f 0.5*f 0];
 B3=[-0.5*sqrt(3)*f 0.5*f 0];
 
 A1=[0 -f-rf*cosd(theta1) -rf*sind(theta1)];
 A2=[0.5*sqrt(3)*(f+rf*cosd(theta2)) 0.5*(f+rf*cosd(theta2)) -rf*sind(theta2)];
 A3=[-0.5*sqrt(3)*(f+rf*cosd(theta3)) 0.5*(f+rf*cosd(theta3)) -rf*sind(theta3)];
 
 E1=[x0 y0-e z0];
 E2=[x0+0.5*sqrt(3)*e y0+0.5*e z0];
 E3=[x0-0.5*sqrt(3)*e y0+0.5*e z0];
 
 figure(1)
 hold on
 grid on
 line([S1(1) S2(1) S3(1) S1(1)],[S1(2) S2(2) S3(2) S1(2)],[S1(3) S2(3) S3(3) S1(3)],'Color','c')
 line([0 B1(1) A1(1) E1(1) x0],[0 B1(2) A1(2) E1(2) y0],[0 B1(3) A1(3) E1(3) z0],'Color','red')
 line([0 B2(1) A2(1) E2(1) x0],[0 B2(2) A2(2) E2(2) y0],[0 B2(3) A2(3) E2(3) z0],'Color','blue')
 line([0 B3(1) A3(1) E3(1) x0],[0 B3(2) A3(2) E3(2) y0],[0 B3(3) A3(3) E3(3) z0],'Color','black')
% line([0 B1(1) B2(1) B3(1)],[0 B1(2) B2(2) B3(2)],[0 B1(3) B2(3) B3(3)])
 %line([0 B2(1)],[0 B2(2)],[0 B2(3)])
 %line([0 B3(1)],[0 B3(2)],[0 B3(3)])
 pause(0.1)
 end
 