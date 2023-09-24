function [B] = Weight(A)

A = abs(A);

if (A <= 1)
    B = 2/3 - (1 - A/2) * A^2;
elseif (A < 2)
    B = 1/6 * (2 - A)^3;
else
    B = 0;
end
