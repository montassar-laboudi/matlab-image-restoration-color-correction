% VisuVagues(Vagues)
%
% Visualization of the image Vagues.
% This image must be in the Fourier domain.
%
% (C) Gilles Burel / University of Brest

function VisuVagues(Vagues)

[nblig, nbcol, nbcouleurs] = size(Vagues);

if nbcouleurs > 1
    Vagues = mean(Vagues, 3);
end

boost = 3;

logfft = fftshift(log(eps + abs(Vagues)));
logfft = logfft - min(logfft(:)) + eps;

imagesc(logfft.^boost);
colorbar;
colormap(gray);

end