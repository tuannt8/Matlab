function [ domain ] = round_coords( center, radius, domain_size )
%ROUND_COORDS Summary of this function goes here
%   Detailed explanation goes here
    domain = zeros(domain_size);

    for x = center(1) - radius : center(1) + radius
        for y = center(2) - radius : center(2) + radius
            for z = center(3) - radius : center(3) + radius
                
                if(x > 0 && x <= domain_size(1) ...
                    && y > 0 && y <= domain_size(2) ...
                    && z > 0 && z <= domain_size(3))
                    dis = [x - center(1), y - center(2), z - center(3)];
                    if(sqrt(dis*dis') <= radius)
                        domain(x,y,z) = 1;
                    end
                end
            end
        end
    end
    
    domain = logical(domain);

end

