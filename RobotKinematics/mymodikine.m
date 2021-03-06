function [ikine_t]=mymodikine(Tbe)
 
%       theta         d          a               offset
% MDH=[theta1-pi/2   199         0              0;
%      theta2-pi/2   208.5       0          -pi/2;
%      theta3        -173.5      809.779        0;
%      theta4+pi/2   121         719.175        0;
%      theta5        120.179     0              pi/2;
%      theta6+pi/2   104.5       0            -pi/2];

d1=199;
d2=208.5;
d3=-173.5;
d4=121;
d5=120.179;
d6=104.5;
a3=809.779;
a4=719.175;
offset=[-pi/2 -pi/2 0 pi/2 0 pi/2];


nx= Tbe(1,1);
ny=Tbe(2,1);
nz=Tbe(3,1);
ox= Tbe(1,2);
oy=Tbe(2,2);
oz=Tbe(3,2);
ax= Tbe(1,3);
ay=Tbe(2,3);
az=Tbe(3,3);
px= Tbe(1,4);
py=Tbe(2,4);
pz=Tbe(3,4);

 
%J1 (2,3) (2,4)
t11=atan2(d2+d3+d4,sqrt((py-d6*ay)^2+(d6*ax-px)^2-(d2+d3+d4)^2))-atan2(py-d6*ay,d6*ax-px);
t12=atan2(d2+d3+d4,-sqrt((py-d6*ay)^2+(d6*ax-px)^2-(d2+d3+d4)^2))-atan2(py-d6*ay,d6*ax-px);
%J5 (2,1) (2,2)
t51=atan2(sqrt((ny*cos(t11)-nx*sin(t11))^2+(oy*cos(t11)-ox*sin(t11))^2),ay*cos(t11)-ax*sin(t11));
t52=atan2(-sqrt((ny*cos(t11)-nx*sin(t11))^2+(oy*cos(t11)-ox*sin(t11))^2),ay*cos(t11)-ax*sin(t11));
t53=atan2(sqrt((ny*cos(t12)-nx*sin(t12))^2+(oy*cos(t12)-ox*sin(t12))^2),ay*cos(t12)-ax*sin(t12));
t54=atan2(-sqrt((ny*cos(t12)-nx*sin(t12))^2+(oy*cos(t12)-ox*sin(t12))^2),ay*cos(t12)-ax*sin(t12));
%J6
t61=atan2((ox*sin(t11)-oy*cos(t11))/sin(t51),(ny*cos(t11)-nx*sin(t11))/sin(t51));
t62=atan2((ox*sin(t11)-oy*cos(t11))/sin(t52),(ny*cos(t11)-nx*sin(t11))/sin(t52));
t63=atan2((ox*sin(t12)-oy*cos(t12))/sin(t53),(ny*cos(t12)-nx*sin(t12))/sin(t53));
t64=atan2((ox*sin(t12)-oy*cos(t12))/sin(t54),(ny*cos(t12)-nx*sin(t12))/sin(t54));

%q234
%(1,3) (3,3)
% T16=T12*T23*T34*T45*T56;
% TT=inv(T01)*mT;
t234_1=atan2(az/sin(t51),-(ax*cos(t11)+ay*sin(t11))/sin(t51));
t234_2=atan2(az/sin(t52),-(ax*cos(t11)+ay*sin(t11))/sin(t52));
t234_3=atan2(az/sin(t53),-(ax*cos(t12)+ay*sin(t12))/sin(t53));
t234_4=atan2(az/sin(t54),-(ax*cos(t12)+ay*sin(t12))/sin(t54));
%J2  (1,4) (3,4)
% T15=T12*T23*T34*T45;
% TT=inv(T01)*mT*inv(T56);
A_1=px*cos(t11)+py*sin(t11)-ay*d6*sin(t11)-ax*d6*cos(t11)-d5*sin(t234_1);
A_2=px*cos(t11)+py*sin(t11)-ay*d6*sin(t11)-ax*d6*cos(t11)-d5*sin(t234_2);
A_3=px*cos(t12)+py*sin(t12)-ay*d6*sin(t12)-ax*d6*cos(t12)-d5*sin(t234_3);
A_4=px*cos(t12)+py*sin(t12)-ay*d6*sin(t12)-ax*d6*cos(t12)-d5*sin(t234_4);

B_1=pz-d1-az*d6-d5*cos(t234_1);
B_2=pz-d1-az*d6-d5*cos(t234_2);
B_3=pz-d1-az*d6-d5*cos(t234_3);
B_4=pz-d1-az*d6-d5*cos(t234_4);

t21=atan2(a4^2-a3^2-(A_1)^2-(B_1)^2,  sqrt(4*a3^2*((A_1)^2+(B_1)^2)-(a4^2-a3^2-(A_1)^2-(B_1)^2)^2))+atan2(A_1,B_1);
t22=atan2(a4^2-a3^2-(A_1)^2-(B_1)^2,  -sqrt(4*a3^2*((A_1)^2+(B_1)^2)-(a4^2-a3^2-(A_1)^2-(B_1)^2)^2))+atan2(A_1,B_1);
t23=atan2(a4^2-a3^2-(A_2)^2-(B_2)^2,  sqrt(4*a3^2*((A_2)^2+(B_2)^2)-(a4^2-a3^2-(A_2)^2-(B_2)^2)^2))+atan2(A_2,B_2);
t24=atan2(a4^2-a3^2-(A_2)^2-(B_2)^2,  -sqrt(4*a3^2*((A_2)^2+(B_2)^2)-(a4^2-a3^2-(A_2)^2-(B_2)^2)^2))+atan2(A_2,B_2);
t25=atan2(a4^2-a3^2-(A_3)^2-(B_3)^2,  sqrt(4*a3^2*((A_3)^2+(B_3)^2)-(a4^2-a3^2-(A_3)^2-(B_3)^2)^2))+atan2(A_3,B_3);
t26=atan2(a4^2-a3^2-(A_3)^2-(B_3)^2,  -sqrt(4*a3^2*((A_3)^2+(B_3)^2)-(a4^2-a3^2-(A_3)^2-(B_3)^2)^2))+atan2(A_3,B_3);
t27=atan2(a4^2-a3^2-(A_4)^2-(B_4)^2,  sqrt(4*a3^2*((A_4)^2+(B_4)^2)-(a4^2-a3^2-(A_4)^2-(B_4)^2)^2))+atan2(A_4,B_4);
t28=atan2(a4^2-a3^2-(A_4)^2-(B_4)^2,  -sqrt(4*a3^2*((A_4)^2+(B_4)^2)-(a4^2-a3^2-(A_4)^2-(B_4)^2)^2))+atan2(A_4,B_4);
%J23
t23_1=atan2(-(B_1+a3*sin(t21)),A_1-a3*cos(t21));
t23_2=atan2(-(B_1+a3*sin(t22)),A_1-a3*cos(t22));
t23_3=atan2(-(B_2+a3*sin(t23)),A_2-a3*cos(t23));
t23_4=atan2(-(B_2+a3*sin(t24)),A_2-a3*cos(t24));
t23_5=atan2(-(B_3+a3*sin(t25)),A_3-a3*cos(t25));
t23_6=atan2(-(B_3+a3*sin(t26)),A_3-a3*cos(t26));
t23_7=atan2(-(B_4+a3*sin(t27)),A_4-a3*cos(t27));
t23_8=atan2(-(B_4+a3*sin(t28)),A_4-a3*cos(t28));
%J3
t31=t23_1-t21;
t32=t23_2-t22;
t33=t23_3-t23;
t34=t23_4-t24;
t35=t23_5-t25;
t36=t23_6-t26;
t37=t23_7-t27;
t38=t23_8-t28;
%J4
t41=t234_1-t23_1;
t42=t234_1-t23_2;
t43=t234_2-t23_3;
t44=t234_2-t23_4;
t45=t234_3-t23_5;
t46=t234_3-t23_6;
t47=t234_4-t23_7;
t48=t234_4-t23_8;
ikine_t=[t11 t21 t31 t41 t51 t61;
          t11 t22 t32 t42 t51 t61;
          t11 t23 t33 t43 t52 t62;
          t11 t24 t34 t44 t52 t62
          t12 t25 t35 t45 t53 t63;
          t12 t26 t36 t46 t53 t63;
          t12 t27 t37 t47 t54 t64;
          t12 t28 t38 t48 t54 t64];

ikine_t(1,:)=ikine_t(1,:)-offset;
ikine_t(2,:)=ikine_t(2,:)-offset;
ikine_t(3,:)=ikine_t(3,:)-offset;
ikine_t(4,:)=ikine_t(4,:)-offset;
ikine_t(5,:)=ikine_t(5,:)-offset;
ikine_t(6,:)=ikine_t(6,:)-offset;
ikine_t(7,:)=ikine_t(7,:)-offset;
ikine_t(8,:)=ikine_t(8,:)-offset;
%将角度对其到 -pi到pi之间
ikine_t=wrapToPi(ikine_t);
