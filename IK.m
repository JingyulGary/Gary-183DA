function q = IK(s)
bot = [0,0,0,1];
d1=50;
d4=20;
a2=30;
a5=10;
%Inverse Kinematic
precision = 0.1;
%s=[13;8;64;0];
for q1 = 0:pi/90:2*pi
   for q2 = 0:pi/90:pi/2
      for q3 = 0:pi/90:pi/2
          for q4 = -pi/2:pi/90:pi/2
              for q5 = 0:pi/90:pi/2
                  TE_5A=[eye(3),[0;0;-a5]];
TE_5A=[TE_5A;bot];

T5A_5=[1,0,0,0;                    
0,0,1,0;                   
0,-1,0,0;]; 
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

if (abs(RE_0(1)-s(1)) < precision) && (abs(RE_0(2)-s(2)) < precision) && (abs(RE_0(3)-s(3)) < precision)
   RE_0
   q=[q1;q2;q3;q4;q5]
end
              end
          end
      end
   end
end
end
