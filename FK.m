q=[0;pi/6;pi/6;0;pi/6];



bot = [0,0,0,1];

%Test case
%q=[0;0;1.4312;-0.8029;0.6632];

d1=50;
d4=20;
a2=30;
a5=10;


% Find TE_O (State of End Effector in O refence frame)

TE_5A=[eye(3),[0;0;-a5]];
TE_5A=[TE_5A;bot];

T5A_5=[1,0,0,0;
    0,0,1,0;
    0,-1,0,0;];
T5A_5=[T5A_5;bot];

T5_4=[cos(q(5)),-sin(q(5)),0,0;
    0,0,1,0;
    -sin(q(5)),-cos(q(5)),0,0;];
T5_4=[T5_4;bot];

T4_3A=[eye(3),[0;0;d4]];
T4_3A=[T4_3A;bot];

T3A_3=[cos(q(4)),sin(q(4)),0,0;
    0,0,1,0;
    sin(q(4)),-cos(q(4)),0,0];
T3A_3=[T3A_3;bot];

T3_2A=[cos(-q(3)),sin(-q(3)),0,0;
    sin(-q(3)),cos(-q(3)),0,0;
    0,0,1,0];
T3_2A=[T3_2A;bot];

T2A_2=[eye(3),[a2;0;0]];
T2A_2=[T2A_2;bot];

T2_1=[cos(q(2)),-sin(q(2)),0,0;
    0,0,-1,0;
    sin(q(2)),cos(q(2)),0,0];
T2_1=[T2_1;bot];

T1_0A=[eye(3),[0;0;d1]];
T1_0A=[T1_0A;bot];

T0A_0=[cos(q(1)),-sin(q(1)),0,0;
    sin(q(1)),cos(q(1)),0,0;
    0,0,1,0];
T0A_0=[T0A_0;bot];

TE_0=T0A_0*T1_0A*T2_1*T2A_2*T3_2A*T3A_3*T4_3A*T5_4*T5A_5*TE_5A;

RE_0=TE_0*[0;0;0;1] % Position of End Effector
