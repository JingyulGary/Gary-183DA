clc; clear all;
bot = [0,0,0,1];

%Test case
q=[0;0;1.4312;-0.8029;0.6632];

d1=50;
d4=20;
a2=30;
a5=10;


% Find TE_O (State of End Effector in O refence frame)

% TE_5A=[eye(3),[0;0;-a5]];
% TE_5A=[TE_5A;bot];
% 
% T5A_5=[0,-1,0,0;
%     0,0,1,0;
%     1,0,0,0;];
% T5A_5=[T5A_5;bot];
% 
% T5_4=[cos(q(5)),-sin(q(5)),0,0;
%     0,0,1,0;
%     -sin(q(5)),-cos(q(5)),0,0;];
% T5_4=[T5_4;bot];
% 
% T4_3A=[eye(3),[0;0;d4]];
% T4_3A=[T4_3A;bot];
% 
% T3A_3=[cos(q(4)),sin(q(4)),0,0;
%     0,0,1,0;
%     sin(q(4)),-cos(q(4)),0,0];
% T3A_3=[T3A_3;bot];
% 
% T3_2A=[cos(-q(3)),sin(-q(3)),0,0;
%     sin(-q(3)),cos(-q(3)),0,0;
%     0,0,1,0];
% T3_2A=[T3_2A;bot];
% 
% T2A_2=[eye(3),[a2;0;0]];
% T2A_2=[T2A_2;bot];
% 
% T2_1=[cos(q(2)),-sin(q(2)),0,0;
%     0,0,-1,0;
%     sin(q(2)),cos(q(2)),0,0];
% T2_1=[T2_1;bot];
% 
% T1_0A=[eye(3),[0;0;d1]];
% T1_0A=[T1_0A;bot];
% 
% T0A_0=[cos(q(1)),-sin(q(1)),0,0;
%     sin(q(1)),cos(q(1)),0,0;
%     0,0,1,0];
% T0A_0=[T0A_0;bot];
% 
% TE_0=T0A_0*T1_0A*T2_1*T2A_2*T3_2A*T3A_3*T4_3A*T5_4*T5A_5*TE_5A;
% 
% RE_0=TE_0*[0;0;0;1] % Position of End Effector

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Inverse Kinematic
precision = 0.05;
s=[13;8;70;0];
RRE=[0;0;0;0];
RQ=[0;0;0;0;0];
R1=[0;0;0;0];
R2=[0;0;0;0];
R3=[0;0;0;0];

for s3 = 64:0.1:70
for q1 = 0
   for q2 = 0.2:pi/180:0.4
      for q3 = 0.6:pi/180:1
          for q4 = -1.1:pi/180:-0.8
              for q5 = 1.1:pi/180:1.4
TE_5A=[eye(3),[0;0;-a5]];
TE_5A=[TE_5A;bot];

T5A_5=[0,-1,0,0;
    0,0,1,0;
    1,0,0,0;];
T5A_5=[T5A_5;bot];

T5_4=[cos(q5),-sin(q5),0,0;
    0,0,1,0;
    -sin(q5),-cos(q5),0,0;];
T5_4=[T5_4;bot];

T4_3A=[eye(3),[0;0;d4]];
T4_3A=[T4_3A;bot];

T3A_3=[cos(q4),sin(q4),0,0;
    0,0,1,0;
    sin(q4),-cos(q4),0,0];
T3A_3=[T3A_3;bot];

T3_2A=[cos(-q3),sin(-q3),0,0;
    sin(-q3),cos(-q3),0,0;
    0,0,1,0];
T3_2A=[T3_2A;bot];

T2A_2=[eye(3),[a2;0;0]];
T2A_2=[T2A_2;bot];

T2_1=[cos(q2),-sin(q2),0,0;
    0,0,-1,0;
    sin(q2),cos(q2),0,0];
T2_1=[T2_1;bot];

T1_0A=[eye(3),[0;0;d1]];
T1_0A=[T1_0A;bot];

T0A_0=[cos(q1),-sin(q1),0,0;
    sin(q1),cos(q1),0,0;
    0,0,1,0];
T0A_0=[T0A_0;bot];

TE_0=T0A_0*T1_0A*T2_1*T2A_2*T3_2A*T3A_3*T4_3A*T5_4*T5A_5*TE_5A;

RE_0=TE_0*[0;0;0;1];

if (abs(RE_0(1)-s(1)) < precision) && (abs(RE_0(2)-s(2)) < precision) && (abs(RE_0(3)-s3) < precision)
   RRE=[RRE,RE_0]
   q=[q1;q2;q3;q4;q5];
   RQ=[RQ,q]
   R1=[R1,(T0A_0*T1_0A*T2_1)*[0;0;0;1]];
   R2=[R2,(T0A_0*T1_0A*T2_1*T2A_2*T3_2A)*[0;0;0;1]];
   R3=[R2,(T0A_0*T1_0A*T2_1*T2A_2*T3_2A*T3A_3*T4_3A*T5_4)*[0;0;0;1]];
   
end
              end
          end
      end
   end
end
end

figure;
scatter3(RRE(1,:),RRE(2,:),RRE(3,:),'.');hold on;
scatter3(R1(1,:),R1(2,:),R1(3,:),'.','red');hold on;
scatter3(R2(1,:),R2(2,:),R2(3,:),'.','green');hold on;
scatter3(R3(1,:),R3(2,:),R3(3,:),'.','blue');hold on;
