% Vagues = TransformeeDeFourier(I);
%
% The image I, which is in the image/spatial domain, is converted
% to the Fourier domain.
%
% (C) Gilles Burel / University of Brest

function Vagues = TransformeeDeFourier(I)

I = double(I);

[nblig, nbcol, nbcouleurs] = size(I);

if nbcouleurs == 1
    Vagues = fft2(I);
else
    for i = 1:nbcouleurs
        Vagues(:,:,i) = fft2(I(:,:,i));
    end
end