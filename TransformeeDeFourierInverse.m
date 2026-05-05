% I = TransformeeDeFourierInverse(Vagues);
%
% The image Vagues, which is in the Fourier domain, is converted back
% to the image/spatial domain.
%
% (C) Gilles Burel / University of Brest

function I = TransformeeDeFourierInverse(Vagues)

[nblig, nbcol, nbcouleurs] = size(Vagues);

if nbcouleurs == 1
    I = ifft2(Vagues);
else
    for i = 1:nbcouleurs
        I(:,:,i) = ifft2(Vagues(:,:,i));
    end
end

% maxi = max(I(:));

% Warning: this normalization is specific to this project.
I = I / (2^16 - 1);

I(I < 0) = 0;
I(I > 1) = 1;