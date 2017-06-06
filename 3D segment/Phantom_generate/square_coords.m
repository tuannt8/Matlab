function [ domain ] = square_coords( origin, size, domain_size )
%SQUARE_COORDS Summary of this function goes here
%   Detailed explanation goes here
    domain = zeros(domain_size);

    for x = origin(1) : origin(1) + size(1)
        for y = origin(2) : origin(2) + size(2)
            for z = origin(3) : origin(3) + size(3)
                if(x > 0 && x <= domain_size(1) ...
                    && y > 0 && y <= domain_size(2) ...
                    && z > 0 && z <= domain_size(3))
                    domain(x,y,z) = 1;
                end
            end
        end
    end
    
    domain = logical(domain);
end

