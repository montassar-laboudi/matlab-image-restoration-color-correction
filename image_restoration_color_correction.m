%% MATLAB Image Restoration and Color Correction
% Author: Montassar Laboudi
%
% This live script performs:
% 1. Color correction of a photograph using a white reference region.
% 2. RGB channel analysis of a blurred image.
% 3. Mirror image construction.
% 4. Fourier-domain image restoration.
%
% Helper functions used in this project were provided by Gilles Burel:
% - TraceRectangle
% - TransformeeDeFourier
% - TransformeeDeFourierInverse
% - VisuVagues
% - GenereVagues

clear all;
close all;
clc;

%% Create Results Folder

resultsFolder = "results";

if ~exist(resultsFolder, "dir")
    mkdir(resultsFolder);
end

%% PART 1: Color Correction of a Photograph

Image = imread("irene.jpg");
Image = double(Image) / 255.0;

fig = figure;
imshow(Image);
title("Original Image");
exportgraphics(fig, fullfile(resultsFolder, "01-original-image.png"), "Resolution", 300);

%% Select a White Reference Region

% The original image has a strong red color cast.
% To correct this, we select a region that should normally be white.

lh = 519;
lb = 542;
cg = 422;
cd = 484;

Irect = TraceRectangle(Image, lh, cg, lb, cd);

fig = figure;
imshow(Irect);
title("White Reference Rectangle Position");
exportgraphics(fig, fullfile(resultsFolder, "02-white-reference-rectangle.png"), "Resolution", 300);

papier = Image(lh:lb, cg:cd, :);

fig = figure;
imshow(papier);
title("Selected Paper Region");
exportgraphics(fig, fullfile(resultsFolder, "03-selected-paper-region.png"), "Resolution", 300);

%% Compute RGB Average Values

R = papier(:,:,1);
G = papier(:,:,2);
B = papier(:,:,3);

r = mean(R(:));
g = mean(G(:));
b = mean(B(:));

fprintf("Average RGB values of the paper region:\n");
fprintf("r = %.4f\n", r);
fprintf("g = %.4f\n", g);
fprintf("b = %.4f\n", b);

% Approximate values obtained:
% r = 0.9767
% g = 0.6208
% b = 0.3047
%
% The red component is the highest because the image is shifted toward a
% red-orange color tone.

%% Apply Color Correction

u = 1 / r;
v = 1 / g;
w = 1 / b;

ImageCorrigee(:,:,1) = u * Image(:,:,1);
ImageCorrigee(:,:,2) = v * Image(:,:,2);
ImageCorrigee(:,:,3) = w * Image(:,:,3);

fig = figure;
imshow(ImageCorrigee);
title("Corrected Image");
exportgraphics(fig, fullfile(resultsFolder, "04-corrected-image.png"), "Resolution", 300);

%% Verify the Corrected Paper Region

papierCorr = ImageCorrigee(lh:lb, cg:cd, :);

fig = figure;
imshow(papierCorr);
title("Paper Region After Color Correction");
exportgraphics(fig, fullfile(resultsFolder, "05-paper-region-after-correction.png"), "Resolution", 300);

%% Test the Correction on a Red Object

lh_rouge = 519;
lb_rouge = 542;
cg_rouge = 5;
cd_rouge = 50;

Irect_rouge = TraceRectangle(ImageCorrigee, lh_rouge, cg_rouge, lb_rouge, cd_rouge);

fig = figure;
imshow(Irect_rouge);
title("Rectangle Position on the Red Bag");
exportgraphics(fig, fullfile(resultsFolder, "06-red-bag-rectangle-position.png"), "Resolution", 300);

sac = ImageCorrigee(lh_rouge:lb_rouge, cg_rouge:cd_rouge, :);

fig = figure;
imshow(sac);
title("Selected Red Bag Region");
exportgraphics(fig, fullfile(resultsFolder, "07-selected-red-bag-region.png"), "Resolution", 300);

% Observation:
% The red bag colors become less realistic after correction.
% This happens because the correction was calculated to make the paper
% region white. Since the correction is global, naturally red objects are
% also affected.

%% PART 2: Reading and Analyzing the Blurred Image

close all;

ImageFloue = imread("PhotoFloue.png");
[nblig, nbcol, nbcouleurs] = size(ImageFloue);

fprintf("Blurred image size: %d rows, %d columns, %d color channels\n", ...
    nblig, nbcol, nbcouleurs);

fig = figure;
imshow(ImageFloue);
title("Blurred Image");
exportgraphics(fig, fullfile(resultsFolder, "08-blurred-image.png"), "Resolution", 300);

%% Extract RGB Channels

R = ImageFloue(:,:,1);
G = ImageFloue(:,:,2);
B = ImageFloue(:,:,3);

fig = figure;
subplot(3,1,1);
imshow(R);
title("R Channel");

subplot(3,1,2);
imshow(G);
title("G Channel");

subplot(3,1,3);
imshow(B);
title("B Channel");

exportgraphics(fig, fullfile(resultsFolder, "09-rgb-channels.png"), "Resolution", 300);

%% Analyze a Red Region

lh_rouge = 320;
lb_rouge = 355;
cg_rouge = 250;
cd_rouge = 310;

Irect_rouge_im = TraceRectangle(ImageFloue, lh_rouge, cg_rouge, lb_rouge, cd_rouge);

fig = figure;
imshow(Irect_rouge_im);
title("Rectangle Position on a Red Region");
exportgraphics(fig, fullfile(resultsFolder, "10-red-region-rectangle-position.png"), "Resolution", 300);

rouge_R = R(lh_rouge:lb_rouge, cg_rouge:cd_rouge, :);
rouge_G = G(lh_rouge:lb_rouge, cg_rouge:cd_rouge, :);
rouge_B = B(lh_rouge:lb_rouge, cg_rouge:cd_rouge, :);

fig = figure;
subplot(3,1,1);
imshow(rouge_R);
title("Red Region in R Channel");

subplot(3,1,2);
imshow(rouge_G);
title("Red Region in G Channel");

subplot(3,1,3);
imshow(rouge_B);
title("Red Region in B Channel");

exportgraphics(fig, fullfile(resultsFolder, "11-red-region-rgb-analysis.png"), "Resolution", 300);

% Observation:
% The selected red region appears bright in the R channel and dark in the
% G and B channels.

%% PART 3: Creating a Mirror Image

fig = figure;
imshow(flipud(R));
title("Vertical Flip of R Channel");
exportgraphics(fig, fullfile(resultsFolder, "12-flipud-r-channel.png"), "Resolution", 300);

fig = figure;
subplot(2,1,1);
imshow(fliplr(R));
title("Horizontal Flip of R Channel");

subplot(2,1,2);
imshow(ImageFloue);
title("Original Blurred Image");

exportgraphics(fig, fullfile(resultsFolder, "13-fliplr-r-channel-comparison.png"), "Resolution", 300);

%% Temporary Image Construction

Tmp = [R fliplr(R); R R];

fig = figure;
imshow(Tmp);
title("Temporary Image Construction");
exportgraphics(fig, fullfile(resultsFolder, "14-temporary-image.png"), "Resolution", 300);

%% Mirrored Red Channel

Rm = [R fliplr(R); flipud(R) flipud(fliplr(R))];

fig = figure;
imshow(Rm);
title("Mirrored Red Channel");
exportgraphics(fig, fullfile(resultsFolder, "15-mirrored-red-channel.png"), "Resolution", 300);

%% Create the Full Mirrored RGB Image

Gm = [G fliplr(G); flipud(G) flipud(fliplr(G))];
Bm = [B fliplr(B); flipud(B) flipud(fliplr(B))];

ImageMiroirFloue(:,:,1) = Rm;
ImageMiroirFloue(:,:,2) = Gm;
ImageMiroirFloue(:,:,3) = Bm;

fig = figure;
imshow(ImageMiroirFloue);
title("Mirrored Blurred Image");
exportgraphics(fig, fullfile(resultsFolder, "16-mirrored-blurred-image.png"), "Resolution", 300);

%% PART 4: Fourier Domain Transformation

Vagues = TransformeeDeFourier(ImageMiroirFloue);

fig = figure;
VisuVagues(Vagues);
title("Fourier Domain Waves");
exportgraphics(fig, fullfile(resultsFolder, "17-fourier-domain-waves.png"), "Resolution", 300);

I = TransformeeDeFourierInverse(Vagues);

fig = figure;
imshow(I);
title("Image After Inverse Fourier Transform");
exportgraphics(fig, fullfile(resultsFolder, "18-inverse-fourier-check.png"), "Resolution", 300);

% If no modification is made in the Fourier domain, the inverse transform
% returns the mirrored blurred image.

%% PART 5: Image Restoration

Vagues = TransformeeDeFourier(ImageMiroirFloue);
[nblig1, nbcol1, nbcouleurs1] = size(ImageMiroirFloue);

fig = figure;
VisuVagues(Vagues);
title("Original Waves");
exportgraphics(fig, fullfile(resultsFolder, "19-original-waves.png"), "Resolution", 300);

%% Generate Clean Wave Pattern

NombreDeVagues = 18;

VaguesPropres = GenereVagues(NombreDeVagues, nblig1, nbcol1);

fig = figure;
VisuVagues(VaguesPropres);
title("Clean Wave Pattern");
exportgraphics(fig, fullfile(resultsFolder, "20-clean-wave-pattern.png"), "Resolution", 300);

%% Invert the Clean Wave Pattern

Force = 5;
rho = 10.^(-Force);

VaguesPropresInversees = conj(VaguesPropres) ./ ((abs(VaguesPropres).^2) + rho);

fig = figure;
VisuVagues(VaguesPropresInversees);
title("Inverted Clean Wave Pattern");
exportgraphics(fig, fullfile(resultsFolder, "21-inverted-clean-wave-pattern.png"), "Resolution", 300);

%% Reduce the Waves

VaguesPropresInversees = VaguesPropresInversees(:,:,[1 1 1]);

VaguesReduites = VaguesPropresInversees .* Vagues;

fig = figure;
VisuVagues(VaguesReduites);
title("Reduced Waves");
exportgraphics(fig, fullfile(resultsFolder, "22-reduced-waves.png"), "Resolution", 300);

%% Compare Original and Reduced Waves

fig = figure;
subplot(2,1,1);
VisuVagues(Vagues);
title("Original Waves");

subplot(2,1,2);
VisuVagues(VaguesReduites);
title("Reduced Waves");

sgtitle("Comparison Between Original and Reduced Waves");

exportgraphics(fig, fullfile(resultsFolder, "23-waves-comparison.png"), "Resolution", 300);

% If rho = 0, the simplified result of the inverted waves is equivalent to
% 1 / waves.
%
% The regularization term rho prevents excessive noise amplification.

%% Reconstruct the Restored Mirrored Image

ImageMiroirRestauree = TransformeeDeFourierInverse(VaguesReduites);

fig = figure;
imshow(ImageMiroirRestauree);
title(sprintf("Restored Mirrored Image (Force = %f)", Force));
exportgraphics(fig, fullfile(resultsFolder, "24-restored-mirrored-image.png"), "Resolution", 300);

% If Force is too low, the image remains blurred.
% If Force is too high, the image becomes unstable and noisy.

%% Crop the Restored Image

ImageRestauree = ImageMiroirRestauree(1:nblig, 1:nbcol, :);

fig = figure;
imshow(ImageRestauree);
title("Final Restored Image");
exportgraphics(fig, fullfile(resultsFolder, "25-final-restored-image.png"), "Resolution", 300);

%% Final Message

disp("Processing complete.");
disp("All figures have been saved in the results folder.");