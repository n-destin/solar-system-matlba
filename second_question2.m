% part 2: When the distance between the moon and earth is dooubled

clear all, clc
dt = 1; % the time step
G = 6.6743*10^-11; % gravitational constant
ending = 365*24*60*60; %remember to change from one day to 365 days
t = 1:dt:ending; % defining the time interval
Msun = 1.989*10^30; % mass of sun
Mearth = 5.97*10^24; % mass of earth
Mmoon = 7.3*10^22; % mass of moon
Mvenus = 4.87*10^24; % mass of venus

% positions of the bodies

Xsun = 0; % inittial X position of the earth
Xearth = 147.1*10^9; % initial X position of Earth
Xvenus = 107.5 * 10^9; % initial X positionof Venus
Xmoon = 147.83*10^9; % initial X position of moon

Ysun = 0; % initial Y position of sun
Yearth = 0; % initial Y position of Earth
Yvenus = 0; % initial Y position of Venus
Ymoon = 0; % initial Y position of Moon

Vxsun = 0; % initial  X-velocity of Sun
Vxearth = 0; % initial X velocity of Earth
Vxvenus = 0; %initial X-velocity of Venus
Vxmoon = 0; % initial Xvelocity of Mooon
 
Vysun = 0; % intiial Y velocity of Sun
Vyearth  = 29.8*10^3; % initial Y-velocity of earth
Vymoon = 30.8*10^3; % initial Y velocity of Moon
Vyvenus = 35*10^3; % remember to check this.% % % % %

% making an array that holds the first values of positions and velocities, and that will
% continously hold them when updated:

X  = zeros([numel(t),4]); % array for the X positionf of the bodies
Y = zeros([numel(t),4]); % array for the Y positions of the bodies
Vx = zeros([numel(t),4]); % array for the X-Veloctiy of the bodies
Vy = zeros([numel(t),4]); % arary for the Y-velocity of the bodies
Ax = zeros([numel(t),4]); % array for the X-acceleration of the bodies
Ay = zeros([numel(t),4]); % array for the Y-acceleration of the bodies
% assigning the initial position of the values to the arrays; the first
% columnis for earth, the second is for sun, the third for moon, and the
% forth is for venus

X(1,1) = Xearth;  % earth initial position
X(1,2) = Xsun; % sun initial position
X(1,3) = Xmoon; % moon initial position
X(1,4) = Xvenus; % venus initial position

Y(1,1) = Yearth; % earth initial Y position
Y(1,2) = Ysun; % Sun initial Y position
Y(1,3) = Ymoon; % moon initial Y position
Y(1,4)  = Yvenus; % venus initial Y position

% initial velocities for the bodies
Vx(1,1) = Vxearth;
Vx(1,2) = Vxsun;
Vx(1,3) = Vxmoon;
Vx(1,4) = Vxvenus;
% initial veocities on y-axis
Vy(1,1) = Vyearth;
Vy(1,2) = Vysun;
Vy(1,3) = Vymoon;
Vy(1,4) = Vyvenus;

% calculate the distance between each and every of the each celestrial body
% and he gravitational force between them (separatelty) for the initial
% We are using the Radius function written 

RES = radius(Xsun, Xearth, Ysun, Yearth); % earth and sun
REM = radius(Xearth, Xmoon, Yearth, Ymoon); % moon and earth
REV = radius(Xearth, Xvenus, Yearth, Yvenus); % earth and venus
RSM = radius(Xsun, Xmoon, Ysun, Ymoon); % sun and moon
RSV = radius(Xsun, Xvenus, Ysun, Yvenus); % sun and venus
RVM = radius(Xvenus, Xmoon, Yvenus, Ymoon); % venus and moon

R = zeros(numel(t), 6); % initialzing the array for the radius
% initialize the values of radiuses
R(1,1) = RES; % sun and earth
R(1,2) = REM; % earth and moon
R(1,3) = REV; % earth and venus
R(1,4) = RSV; % venus and sun
R(1,5) = RSM; %sun and moon
R(1,6) = RVM; % venus and moon
% fprintf('Vector R')
% disp(R);

% calculating the initial accelerations from the given equations;

Aearthx = accfind(Msun, Mvenus, Mmoon, RES, REV, REM, X(1,1), X(1,4), X(1,3), X(1,2));
Aearthy = accfind(Msun, Mvenus, Mmoon, RES, REV, REM, Y(1,1), Y(1,4), Y(1,3), Y(1,2));
Amoonx = accfind(Msun, Mvenus, Mearth, RSM, RVM, REM, X(1,3), X(1,2), X(1,4), X(1,1));
Amoony = accfind(Msun, Mvenus, Mearth, RSM, RVM, REM, Y(1,3), Y(1,2), Y(1,4), Y(1,1));
Asunx = accfind(Mearth, Mmoon, Mvenus, RES, RSM, RSV, X(1,2), X(1,1), X(1,3), X(1,4));
Asuny = accfind(Mearth, Mmoon, Mvenus, RES, RSM, RSV, Y(1,2), Y(1,1), Y(1,3), Y(1,4));
Avenusx = accfind(Mearth, Msun, Mmoon, REV, RSV, RVM, X(1,4), X(1,1), X(1,2), X(1,3));
Avenusy = accfind(Mearth, Msun, Mmoon, REV, RSV, RVM, Y(1,4), Y(1,1), Y(1,2), Y(1,3));
% assinging the calculated values to the columns of the first rows of Ax
% and Ay
Ax(1,1) = Aearthx;
Ax(1,2) = Asunx;
Ax(1,3) = Amoonx;
Ax(1,4) = Avenusx;

Ay(1,1) = Aearthy;
Ay(1,2) = Asuny;
Ay(1,3) = Amoony;
Ay(1,4) = Avenusy;

% using the Eurler's formula to calculate 

% loop through the values of t, starting from 2 because we have already
% used the first row
v_range = 25*10^3:500:39*10^3;
k = 1;
while k<length(v_range)
    Vy(1,3) = v_range(k);
    Vmoon = Vy(1,3);
    i = 2;
    found = 0;
while i<ending
    % updating the velocity values for moon
     j= 3;
     Vx(i,j) = Vx(i-1,j) + dt*Ax(i-1,j);
     Vy(i,j) = Vy(i-1,j) + dt*Ay(i-1,j);
     X(i,j) = X(i-1,j) + Vx(i, j)*dt;
     Y(i,j) = Y(i-1,j) + dt*Vy(i, j);
     % updating velocity values for earth
     j= 1;
     Vx(i,j) = Vx(i-1,j) + dt*Ax(i-1,j);
     Vy(i,j) = Vy(i-1,j) + dt*Ay(i-1,j);
     X(i,j) = X(i-1,j) + Vx(i, j)*dt;
     Y(i,j) = Y(i-1,j) + dt*Vy(i, j);
     % updating the velocity values for sun
     j= 2;
     Vx(i,j) = Vx(i-1,j) + dt*Ax(i-1,j);
     Vy(i,j) = Vy(i-1,j) + dt*Ay(i-1,j);
     X(i,j) = X(i-1,j) + Vx(i, j)*dt;
     Y(i,j) = Y(i-1,j) + dt*Vy(i, j);
     %updating the velocity values for venus
     j= 4;
     Vx(i,j) = Vx(i-1,j) + dt*Ax(i-1,j);
     Vy(i,j) = Vy(i-1,j) + dt*Ay(i-1,j);
     X(i,j) = X(i-1,j) + Vx(i, j)*dt;
     Y(i,j) = Y(i-1,j) + dt*Vy(i, j);

    % update the radius between the circles selestrial bodies according to
    % the new positions

    R(i, 1) = radius(X(i,1), X(i,2), Y(i,1), Y(i,2));
    R(i, 2) = radius(X(i,1), X(i,3),Y(i,1),Y(i,3));
    R(i, 3) = radius(X(i,1),X(i,4), Y(i,1), Y(i,4));
    R(i, 4) = radius(X(i,2), X(i,4), Y(i,2), Y(i,4));
    R(i, 5) = radius(X(i,2),X(i,3), Y(i,2), Y(i,3));
    R(i, 6) = radius(X(i,3),X(i,4),Y(i,3), Y(i,4));

   % assigning the newly calculated values to the 
 
    RES = R(i,1); % sun and earth
    REM = R(i,2); % earth and moon
    REV = R(i,3); % earth and venus
    RSV = R(i,4); % venus and sun
    RSM = R(i,5); %sun and moon
    RVM = R(i,6); % venus and moon

    Ax(i, 1) = accfind(Msun, Mvenus, Mmoon, RES, REV, REM, X(i,1), X(i,2), X(i,4), X(i,3));
    Ax(i, 2) = accfind(Mearth, Mmoon, Mvenus, RES, RSM, RSV, X(i,2), X(i,1), X(i,3), X(i,4));
    Ax(i, 3) = accfind(Msun, Mvenus, Mearth, RSM, RVM, REM, X(i,3), X(i,2), X(i,4), X(i,1));
    Ax(i, 4) = accfind(Mearth, Msun, Mmoon, REV, RSV, RVM, X(i,4), X(i,1), X(i,2), X(i,3));
% updating the acceleration on Y
    Ay(i, 1) = accfind(Msun, Mvenus, Mmoon, RES, REV, REM, Y(i,1), Y(i,2), Y(i,4), Y(i,3));
    Ay(i, 2) = accfind(Mearth, Mmoon, Mvenus, RES, RSM, RSV, Y(i,2), Y(i,1), Y(i,3), Y(i,4));
    Ay(i, 3) = accfind(Msun, Mvenus, Mearth, RSM, RVM, REM, Y(i,3), Y(i,2), Y(i,4), Y(i,1));
    Ay(i, 4) = accfind(Mearth, Msun, Mmoon, REV, RSV, RVM, Y(i,4), Y(i,1), Y(i,2), Y(i,3));
    
    if (RES > 0 && RES < 10^9) % staying in the range values
        i = i + 1; % continue looping
    else 
        found = 1; 
        i  = ending + 1; % go out of the loop
    end    
end

if found ~= 1
    fprintf('%d', Vmoon);
end

k = k+1; % move to the next velocity
end

