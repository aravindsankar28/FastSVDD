
%plot(z(:,1),z(:,2),'.');

n = 200;
r = sqrt(rand(n,1)); % Start out as if filling a unit circle
 t = 2*pi*rand(n,1);
 X = 3*sqrt(2/59)*r.*cos(t); % Rescale by major & minor semi-axis lengths
 Y = 2*sqrt(2/4)*r.*sin(t);
 x = (2*X-5*Y)/sqrt(58); % Rotate back to original coordinates
 y = (5*X+2*Y)/sqrt(58);
 
 z1 = [x y];
 plot(z1(:,1),z1(:,2),'b.');
 hold on;
 
r = sqrt(rand(n,1)); % Start out as if filling a unit circle
 t = 2*pi*rand(n,1);
 X = 3*sqrt(2/59)*r.*cos(t); % Rescale by major & minor semi-axis lengths
 Y = 2*sqrt(2/4)*r.*sin(t);
 x = 0.4+(2*X-5*Y)/sqrt(58); % Rotate back to original coordinates
 y = 0.4+(5*X+2*Y)/sqrt(58);
 
 z2 = [x y];
 plot(z2(:,1),z2(:,2),'r.');
 
 
 z = [z1;z2];
 save('ellipse.mat','z');