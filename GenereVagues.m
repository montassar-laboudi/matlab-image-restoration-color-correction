% Vagues = GenereVagues(NombreDeVagues, nblig, nbcol);
%
% Creates an image Vagues with size nblig x nbcol.
% This image contains the specified number of waves.
%
% (C) Gilles Burel / University of Brest

function Vagues = GenereVagues(NombreDeVagues, nblig, nbcol)

h = fspecial('disk', NombreDeVagues);
[nbligh, nbcolh] = size(h);

hpad = zeros(nblig, nbcol);
hpad(1:nbligh, 1:nbcolh) = h;

hpad = circshift(hpad, [-NombreDeVagues -NombreDeVagues]);

H = fft2(hpad);
Vagues = real(H);

end