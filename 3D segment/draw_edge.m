function [ output_args ] = draw_edge( e, o )
%DRAW_EDGE Summary of this function goes here
%   Detailed explanation goes here
for i = 1:length(e)/2
    tt = e(2*(i-1)+1:2*(i-1)+2, :);
    plot3(tt(:,1),tt(:,2),tt(:,3), o);
end

end

