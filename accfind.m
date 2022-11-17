function [acc] = accfind(m2, m3, m4, r12, r13, r14, x1, x2, x3, x4)
G = 6.6743*10^-11;
%this function takes in masses of three objects, m2, m3, and m4, and their
% radius respective to another object, and their coordinated, and returns
% acceleration of that body;
% x1 is the position of the object you wish to find the acceleration. It
% might be x, or y. X2 is the position of the second object, x3 is the
% position of the third object, and x4 is the position of the fourth object
%Remark: They can be either x y, or z positions, though named x
% m2: mass of the object relative to the firs one and r12 is the distance
% between that object with the one you wish to find the velocity
% m3: mass of another object and r13 is the distance between that object
% with the object for which you wish to find the distance
% m4 mass of the third object when the and r14 us the distance between that
% object with the 

acc = -G*(m2*(x1-x2)/r12^3 + m3*(x1-x3)/r13^3+m4*(x1-x4)/r14^3);
end