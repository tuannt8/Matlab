data = zeros(2,4);
c_vol = [0.024706 0.112241; 0.023920 0.095977]; 
c=c_vol; data(:,1) = (c(:,2) - c(:,1))./c(:,2);

c_cur = [0.06 0.11; 7.6 13.4];
c=c_cur; data(:,2) = (c(:,2) - c(:,1))./c(:,2);

c_vol_grad = [0.0541 0.0813; 0.0683 0.0890];
c=c_vol_grad; data(:,3) = (c(:,2) - c(:,1))./c(:,2);

c_mass_grad = [0.132 0.806 ; 0.058  0.338];
c=c_mass_grad; data(:,4) = (c(:,2) - c(:,1))./c(:,2);

data = data*100;
%%
close all;
bar(data);
legend('Compute volume', 'curvature normal', 'volume gradient', 'shape optimization');
set(gca, 'XTickLabel', {'Rotation', 'Averaging'});
ylabel('Computation time reduction [%]');