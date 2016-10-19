close all;

l = 0.3;
x = [0.5 0.2; 0.2 0.5];
v = [1 0; 0 1];

dt = 0.01;

figure;
while 1

    f = [0 -0.5; 0 -0.5];
    if(norm(x(1,:) - x(2,:)) < l)
        d = x(1,:) - x(2,:);
        f(1,:) = f(1,:) + d.*((l-norm(d))/norm(d)*40);
        f(2,:) = f(2,:) - d.*((l-norm(d))/norm(d)*40);
    end
    a = f;
    v = v + a*dt;
%     v = v - v*0.01;
    x = x + v*dt;

    for i = 1:2
        if x(i,1) < 0
            x(i,1) = 0;
            v(i,1) = -v(i,1);
        end
        if x(i,1) > 1
            x(i,1) = 1;
            v(i,1) = -v(i,1);
        end
        if x(i,2) < 0
            x(i,2) = 0;
            v(i,2) = -v(i,2);
        end
        if x(i,2) > 1
            x(i,2) = 1;
            v(i,2) = -v(i,2);
        end        
    end
clf;
pos = [0 0 1 1];
rectangle('Position',pos, 'LineWidth', 2);

pos = [x(1,1)-0.05 x(1,2)-0.05 0.1 0.1];
rectangle('Position',pos,'Curvature',[1 1], 'LineWidth', 2);

pos = [x(2,1)-0.05 x(2,2)-0.05 0.1 0.1];
rectangle('Position',pos,'Curvature',[1 1], 'LineWidth', 2);

xlim([-1 2]);
ylim([-1 2]);


pause(0.01);
end