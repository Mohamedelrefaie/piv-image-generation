%#codegen
function  [IMAGE1, IMAGE2] = generateImagePair_mc(IMAGEHEIGHT, IMAGEWIDTH, PARTICLEDIAMETER, PARTICLECONCENTRATION, TRANSFORMATIONMATRIX)
% GENERATEIMAGES(imHeight, imWidth, TRANSFORMATIONMATRIX, saveFlag, saveDirectory)
% Generates a series of synthetic particle images that have been transformed by a
% specified series of transformation matrices. 
%
% The equations used to generate the particles were taken from Equation 16 (on page 5) of the paper
% "Methods for Digital Particle Image Sizing (DPIS): Comparisons and
% Improvements" (2009) by Michael R. Brady, Samuel G. Raben, Pavlos P.
% Vlachos, published in the journal Flow Measurement and Instrumentation.
% (doi:10.1016/j.flowmeasinst.2009.08.001)
%
% INPUTS
%   IMAGEHEIGHT = Height of generated images (pixels)
%
%   IMAGEWIDTH = Width of generate images (pixels)
%
%   PARTICLECONCENTRATION = Average number of particles per pixel
%
%   TRANSFORMATIONMATRIX = 3 x 3 matrix that specifies the affine
%   transformation relating the particle positions in the first image to
%   the particle positions in the second image. 
%
%   SAVEFLAG = Flag to specify whether or not to save the generated images (1 to save, 0 to not save). 
%
%   SAVEDIR = Directory in which to save the generated images. 
%
%   SAVENAME = Name of the images to save, which will be followed by '_A'
%   and '_B' for the first and second images in the pair. 
%
%   CONTROLCASE = Binary flag (0 or 1) specifying whether to generate a
%   simple six-particle pattern to easily observe the effects of the
%   transformation on the images. This should only be enabled for debugging
%   purposes. 
%
% OUTPUTS
%   This code does not save any outputs to the workspace. Instead, it saves
%   images to locations specified by the inputs to the code.
% 
% SEE ALSO
%    makeAffineTransform

% % % % % % % % % 
% BEGIN FUNCTION %
% % % % % % % % % 

% Double the height and width of the images so that rotations don't cause
% cropping.
augmentedWidth = 2 * IMAGEWIDTH; % Double the width so that rotations don't cause cropping
augmentedHeight = 2 * IMAGEHEIGHT; % Double the height so that rotations don't cause cropping

% Calculate the coordinate of the geometric center of the image.
xc = (augmentedWidth + 1 ) / 2; % X center of image
yc = (augmentedHeight + 1 ) /2; % Y center of image

% Gaussian parameter to control the width of intensity distribution 
intensityStd = 0.25; % / (PARTICLEDIAMETER^2 / 8); 

% Number of particles to generate
nParticles = round(PARTICLECONCENTRATION * (augmentedHeight + 2 * PARTICLEDIAMETER) * (augmentedWidth + 2 * PARTICLEDIAMETER));
% Uniformly distributed random numbers  from -0.5 to 0.5 corresponding to centers of the Gaussian function
particleCenters = rand( nParticles, 1 ) - 0.5; 

% Randomly generate the coordinates of particles
% Generate horizontal locations of particles in first image (column vector)
X1 = 1 + (augmentedWidth - 1) * rand(nParticles, 1);
Y1 = 1 + ( augmentedHeight - 1 ) * rand( nParticles, 1);

% Gaussian Function that expresses the intensity distribution of the particle image on the "sensor"
particleMaxIntensities = exp( -particleCenters .^ 2 / (2 * intensityStd ^ 2 ) ); 

% Create a placeholder to store the generated image
image1 = generateParticleImage(augmentedHeight, augmentedWidth, X1, Y1, PARTICLEDIAMETER, particleMaxIntensities);

% Crop the image and flip it vertically to place it in a right-handed coordinate system.
Image1Cropped = flipud(image1(augmentedHeight / 4 + 1 : 3 * augmentedHeight / 4, augmentedWidth / 4 + 1 : 3 * augmentedWidth / 4));

% Make 16 bit. Save to output variable.
IMAGE1 = uint16( (2^16 - 1) .* Image1Cropped .* 2.8^2 / PARTICLEDIAMETER ^2);

% Transform the particle coordinates
[Y2, X2] = transformImageCoordinates(TRANSFORMATIONMATRIX, X1, Y1, [yc xc]);

% Generate the second image
image2 = generateParticleImage(augmentedHeight, augmentedWidth, X2, Y2, PARTICLEDIAMETER, particleMaxIntensities);

% Crop the second image
Image2Cropped =  flipud(image2(augmentedHeight / 4 + 1: 3 * augmentedHeight / 4, augmentedWidth / 4 + 1: 3 * augmentedWidth / 4));

% Recast as 16-bit
IMAGE2 = uint16( (2^16 - 1) .* Image2Cropped .*  2.8^2 ./ PARTICLEDIAMETER^2);

end % End of function

