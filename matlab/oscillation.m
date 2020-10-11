function [ y ] = oscillation( x )
%OSCILLATION compute the oscillation of a signal

N = length(x);
Lmin = 0;
Lmax = 0;

for t = 1:(N-2)
    if x(t) > x(t+1) && x(t+2) > x(t+1)
        Lmin = Lmin + 1;
    end
    if x(t) < x(t+1) && x(t+2) < x(t+1)
        Lmax = Lmax + 1;
    end
end

if Lmin + Lmax > 0
    y = N / (Lmin + Lmax);
else
    y = 0;
end

end