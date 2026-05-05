# MATLAB Image Restoration and Color Correction

A MATLAB image processing project that demonstrates how to correct color imbalance in a photograph and restore a blurred image using RGB channel analysis, mirror image construction, Fourier-domain processing, and inverse wave filtering.

The project is organized as a MATLAB Live Script and saves all generated figures into a `results/` folder so they can be displayed directly in this README.

---

## Author

Created by **Montassar Laboudi**.

---

## Credits

Some helper functions used in this project were provided by **Gilles Burel / University of Brest**.

Provided helper functions:

- `TraceRectangle.m`
- `TransformeeDeFourier.m`
- `TransformeeDeFourierInverse.m`
- `VisuVagues.m`
- `GenereVagues.m`

---

## Project Overview

This project contains two main image processing workflows:

1. **Color correction of a photograph**
2. **Restoration of a blurred image**

The first part corrects a red/orange color cast by selecting a region that should normally be white and using it as a reference.

The second part restores a blurred image by creating a mirrored version of the image, transforming it into the Fourier domain, reducing the wave patterns associated with blur, and converting it back into the image domain.

---

## Features

- RGB image reading and visualization
- Color correction using a white reference region
- RGB channel extraction and analysis
- Red-region channel comparison
- Mirror image construction using `flipud` and `fliplr`
- Fourier transform visualization
- Inverse Fourier transform reconstruction
- Wave pattern generation
- Inverse wave filtering
- Blurred image restoration
- Automatic saving of all figures into the `results/` folder

---

## Technologies Used

- **MATLAB**
- Image Processing Toolbox
- RGB image processing
- Fourier transform
- Inverse Fourier transform
- Matrix operations
- Live Script workflow

---

## Project Structure

```txt
matlab-image-restoration-color-correction/
├── image_restoration_color_correction.mlx
├── irene.jpg
├── PhotoFloue.png
├── TraceRectangle.m
├── TransformeeDeFourier.m
├── TransformeeDeFourierInverse.m
├── VisuVagues.m
├── GenereVagues.m
├── results/
│   ├── 01-original-image.png
│   ├── 02-white-reference-rectangle.png
│   ├── 03-selected-paper-region.png
│   ├── 04-corrected-image.png
│   ├── 05-paper-region-after-correction.png
│   ├── 06-red-bag-rectangle-position.png
│   ├── 07-selected-red-bag-region.png
│   ├── 08-blurred-image.png
│   ├── 09-rgb-channels.png
│   ├── 10-red-region-rectangle-position.png
│   ├── 11-red-region-rgb-analysis.png
│   ├── 12-flipud-r-channel.png
│   ├── 13-fliplr-r-channel-comparison.png
│   ├── 14-temporary-image.png
│   ├── 15-mirrored-red-channel.png
│   ├── 16-mirrored-blurred-image.png
│   ├── 17-fourier-domain-waves.png
│   ├── 18-inverse-fourier-check.png
│   ├── 19-original-waves.png
│   ├── 20-clean-wave-pattern.png
│   ├── 21-inverted-clean-wave-pattern.png
│   ├── 22-reduced-waves.png
│   ├── 23-waves-comparison.png
│   ├── 24-restored-mirrored-image.png
│   └── 25-final-restored-image.png
├── README.md
├── LICENSE
└── .gitignore
```

---

## Workflow

```txt
Original Image
     ↓
Select White Reference Region
     ↓
Compute RGB Correction Coefficients
     ↓
Apply Color Correction
```

```txt
Blurred Image
     ↓
Extract RGB Channels
     ↓
Create Mirrored Image
     ↓
Apply Fourier Transform
     ↓
Generate and Invert Wave Pattern
     ↓
Reduce Waves
     ↓
Apply Inverse Fourier Transform
     ↓
Crop Final Restored Image
```

---

# Results

## 1. Color Correction

### Original Image

The original photograph has a strong red/orange color cast.

![Original Image](./results/01-original-image.png)

---

### White Reference Region

A rectangular region is selected from a paper area that should normally be white.

![White Reference Rectangle](./results/02-white-reference-rectangle.png)

---

### Selected Paper Region

The selected paper region appears red/orange instead of white.

![Selected Paper Region](./results/03-selected-paper-region.png)

---

### Corrected Image

The RGB correction coefficients are applied to the full image.  
The corrected image appears more natural and less red.

![Corrected Image](./results/04-corrected-image.png)

---

### Paper Region After Correction

After correction, the paper region becomes closer to white.

![Paper Region After Correction](./results/05-paper-region-after-correction.png)

---

### Red Bag Region After Correction

A red object is selected to observe the limitation of the global correction.

![Red Bag Rectangle Position](./results/06-red-bag-rectangle-position.png)

---

### Selected Red Bag Region

The red bag region becomes less realistic after correction because the same global RGB correction is applied to the entire image.

![Selected Red Bag Region](./results/07-selected-red-bag-region.png)

---

## 2. Blurred Image Analysis

### Blurred Image

The second image is blurred and will be restored using Fourier-domain processing.

![Blurred Image](./results/08-blurred-image.png)

---

### RGB Channel Extraction

The blurred image is separated into red, green, and blue channels.

![RGB Channels](./results/09-rgb-channels.png)

---

### Red Region Selection

A red region is selected in the blurred image.

![Red Region Rectangle Position](./results/10-red-region-rectangle-position.png)

---

### Red Region RGB Analysis

The selected red region appears bright in the red channel and darker in the green and blue channels.

![Red Region RGB Analysis](./results/11-red-region-rgb-analysis.png)

---

## 3. Mirror Image Construction

### Vertical Flip of the Red Channel

The red channel is flipped vertically using `flipud`.

![Vertical Flip](./results/12-flipud-r-channel.png)

---

### Horizontal Flip of the Red Channel

The red channel is flipped horizontally using `fliplr` and compared with the original blurred image.

![Horizontal Flip Comparison](./results/13-fliplr-r-channel-comparison.png)

---

### Temporary Image Construction

A temporary image is created by combining the original red channel with its horizontally flipped version.

![Temporary Image](./results/14-temporary-image.png)

---

### Mirrored Red Channel

The mirrored red channel is created using both vertical and horizontal flipping.

![Mirrored Red Channel](./results/15-mirrored-red-channel.png)

---

### Full Mirrored Blurred Image

The same mirroring process is applied to the green and blue channels, then the full RGB mirrored image is reconstructed.

![Mirrored Blurred Image](./results/16-mirrored-blurred-image.png)

---

## 4. Fourier Domain Processing

### Fourier Domain Waves

The mirrored blurred image is transformed into the Fourier domain.  
In this domain, the blur appears as wave-like structures.

![Fourier Domain Waves](./results/17-fourier-domain-waves.png)

---

### Inverse Fourier Check

Applying the inverse Fourier transform without modification reconstructs the mirrored blurred image.

![Inverse Fourier Check](./results/18-inverse-fourier-check.png)

---

## 5. Image Restoration

### Original Waves

The Fourier representation of the mirrored blurred image is visualized again before restoration.

![Original Waves](./results/19-original-waves.png)

---

### Clean Wave Pattern

A clean wave pattern is generated using `GenereVagues`.

![Clean Wave Pattern](./results/20-clean-wave-pattern.png)

---

### Inverted Clean Wave Pattern

The generated wave pattern is inverted using a regularized inverse filter.

![Inverted Clean Wave Pattern](./results/21-inverted-clean-wave-pattern.png)

---

### Reduced Waves

The inverted wave pattern is multiplied by the original Fourier waves to reduce blur.

![Reduced Waves](./results/22-reduced-waves.png)

---

### Original vs Reduced Waves

This comparison shows the effect of the wave reduction step.

![Wave Comparison](./results/23-waves-comparison.png)

---

### Restored Mirrored Image

The reduced waves are transformed back into the image domain.

![Restored Mirrored Image](./results/24-restored-mirrored-image.png)

---

### Final Restored Image

The restored image is cropped back to the original image size.

![Final Restored Image](./results/25-final-restored-image.png)

---

# Methodology

## Color Correction Method

The color correction step is based on the assumption that a selected paper region should be white.

The average RGB values of the paper region are computed:

```matlab
r = mean(R(:));
g = mean(G(:));
b = mean(B(:));
```

Correction coefficients are then calculated:

```matlab
u = 1 / r;
v = 1 / g;
w = 1 / b;
```

Each channel is multiplied by its correction coefficient:

```matlab
ImageCorrigee(:,:,1) = u * Image(:,:,1);
ImageCorrigee(:,:,2) = v * Image(:,:,2);
ImageCorrigee(:,:,3) = w * Image(:,:,3);
```

This improves the white reference region, but because the correction is global, it may distort naturally red objects.

---

## Mirror Image Method

The mirrored image is built using:

```matlab
Rm = [R fliplr(R); flipud(R) flipud(fliplr(R))];
Gm = [G fliplr(G); flipud(G) flipud(fliplr(G))];
Bm = [B fliplr(B); flipud(B) flipud(fliplr(B))];
```

Then the full RGB image is reconstructed:

```matlab
ImageMiroirFloue(:,:,1) = Rm;
ImageMiroirFloue(:,:,2) = Gm;
ImageMiroirFloue(:,:,3) = Bm;
```

The mirror construction helps reduce boundary discontinuities before Fourier-domain restoration.

---

## Fourier Restoration Method

The mirrored image is transformed into the Fourier domain:

```matlab
Vagues = TransformeeDeFourier(ImageMiroirFloue);
```

A clean wave pattern is generated:

```matlab
VaguesPropres = GenereVagues(NombreDeVagues, nblig1, nbcol1);
```

The inverse wave pattern is computed:

```matlab
rho = 10.^(-Force);
VaguesPropresInversees = conj(VaguesPropres) ./ ((abs(VaguesPropres).^2) + rho);
```

The waves are reduced:

```matlab
VaguesReduites = VaguesPropresInversees .* Vagues;
```

Finally, the restored image is reconstructed:

```matlab
ImageMiroirRestauree = TransformeeDeFourierInverse(VaguesReduites);
ImageRestauree = ImageMiroirRestauree(1:nblig, 1:nbcol, :);
```

---

## Important Observations

### Color Correction

- The original image has a strong red/orange color cast.
- A paper region is used as a white reference.
- The corrected image looks more natural.
- The paper region becomes closer to white.
- Naturally red objects may become unrealistic after correction.

### Image Restoration

- The blurred image is extended into a mirrored image.
- The Fourier transform reveals wave-like blur patterns.
- A clean wave pattern is generated and inverted.
- The inverted waves reduce blur in the Fourier domain.
- The restored image is sharper than the original blurred image.
- The `Force` parameter controls the restoration strength.

---

## Parameters Used

| Parameter | Value | Description |
|---|---:|---|
| `NombreDeVagues` | `18` | Number of generated waves used for the inverse filter |
| `Force` | `5` | Controls the strength of the restoration |
| `rho` | `10.^(-Force)` | Regularization parameter used to avoid unstable inversion |

---

## How to Run

1. Open MATLAB.
2. Open the live script:

```txt
image_restoration_color_correction.mlx
```

3. Make sure the images and helper functions are in the project folder.
4. Run the live script.
5. All figures will be saved automatically in the `results/` folder.

---

## Required Files

```txt
image_restoration_color_correction.mlx
irene.jpg
PhotoFloue.png
TraceRectangle.m
TransformeeDeFourier.m
TransformeeDeFourierInverse.m
VisuVagues.m
GenereVagues.m
```

---

## Notes

- This project is educational and demonstrates fundamental image processing concepts.
- The helper functions were provided by **Gilles Burel / University of Brest**.
- The `results/` folder is intentionally included so the README can display output images.
- The quality of the final restoration depends on the selected wave count and `Force` value.
- Global color correction can improve one reference region but distort other colors.

