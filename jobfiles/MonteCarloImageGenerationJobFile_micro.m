function JOBLIST = MonteCarloImageGenerationJobFile_micro()

% Region dimensions
region_width_pixels  = 1024;
region_height_pixels  = 1024;

DefaultJob.JobOptions.ParallelProcessing = 1;
DefaultJob.JobOptions.NumberOfDigits = 6;
DefaultJob.JobOptions.ReSeed = 1;

DefaultJob.ImageType = 'synthetic';
DefaultJob.SetType = 'mc';
DefaultJob.CaseName = 'piv_test_images';
% DefaultJob.ProjectRepository = '/home/shannon/b/aether/Projects/APC/';
DefaultJob.ProjectRepository = '~/Desktop/piv_test_images';

DefaultJob.Parameters.Image.Height = region_height_pixels;
DefaultJob.Parameters.Image.Width = region_width_pixels;
DefaultJob.Parameters.Sets.Start = 1;
DefaultJob.Parameters.Sets.End = 1;
DefaultJob.Parameters.Sets.ImagesPerSet = 1;

% Rigid-body displacements (pixels)
DefaultJob.Parameters.Translation.X =  (15.2123) * [1, 1];
DefaultJob.Parameters.Translation.Y =  13.5334 * [1, 1];
DefaultJob.Parameters.Translation.Z =  0  * [0, 2];

% Range of isotropic scaling factors
DefaultJob.Parameters.Scaling = 1 * [1 1]; 

% Range of rotation angles (degrees)
DefaultJob.Parameters.Rotation.Z_01 = 0 * [1 1];
DefaultJob.Parameters.Rotation.Y    = 0 * [1 1];
DefaultJob.Parameters.Rotation.Z_02 = 0 * [1 1];

% Shearing
DefaultJob.Parameters.Shear.XY = 0.0 * [1, 1];
DefaultJob.Parameters.Shear.XZ = 0.0 * [0, 1];
DefaultJob.Parameters.Shear.YX = 0 * [0.00, 0.10];
DefaultJob.Parameters.Shear.YZ = 0 * [0.00, 0.10];
DefaultJob.Parameters.Shear.ZX = 0 * [0.00, 0.10];
DefaultJob.Parameters.Shear.ZY = 0 * [0.00, 0.10];

% Range of particle concentrations (particles per pixel)
DefaultJob.Parameters.Experiment.ParticleConcentration = 1E-2 * [1 1];

% Noise parameters
% DefaultJob.Parameters.Noise.Mean = 0.05 * [0, 0];
% DefaultJob.Parameters.Noise.Std = 0.05 * [0, 0];

% Optics
% Size of the pixels in microns
% Assumes square pixels
DefaultJob.Parameters.Image.PixelSize = 10;

% Bit depth of the imaging system
% Can be anything but typically 
% 8, 12, or 16
DefaultJob.Parameters.Image.BitDepth = 8;

% Objective lens parameters
DefaultJob.Parameters.Optics.Objective.Name = '60x';

% Laser wavelength in microns
DefaultJob.Parameters.Optics.Laser.Wavelength = 0.532;
 
% Channel depth in microns
DefaultJob.Parameters.Experiment.ChannelDepth = 100;

% Particle diameter in microns
DefaultJob.Parameters.Experiment.ParticleDiameter = 0.2 * [1, 1];

% Particle concentration (particles per �m^3)
DefaultJob.Parameters.Experiment.ParticleConcentration = 5E-5;

% Diffusion
DefaultJob.Parameters.Experiment.DiffusionStdDev = 0 * [1, 1];

% Case 1
SegmentItem = DefaultJob;
SegmentItem.SetType = 'mc';
SegmentItem.CaseName = 'piv_test_constant_diffusion';
SegmentItem.Parameters.Image.Height = 1024;
SegmentItem.Parameters.Image.Width  = 1280;
SegmentItem.Parameters.Noise.Mean = 0 * [0.1, 0.1];
SegmentItem.Parameters.Noise.Std = 0.03 * [1, 1];
SegmentItem.Parameters.Experiment.ParticleDiameter = 0.2 * [1, 1];
SegmentItem.Parameters.Experiment.ParticleConcentration = 5E-3 * [1, 1];
JOBLIST(1) = SegmentItem;

% SegmentItem.Parameters.Experiment.DiffusionStdDev = 1 * [1, 1];
% SegmentItem.Parameters.Sets.Start = SegmentItem.Parameters.Sets.Start + 1;
% SegmentItem.Parameters.Sets.End = SegmentItem.Parameters.Sets.Start;
% JOBLIST(end + 1) = SegmentItem;
% 
% SegmentItem.Parameters.Experiment.DiffusionStdDev = 2 * [1, 1];
% SegmentItem.Parameters.Sets.Start = SegmentItem.Parameters.Sets.Start + 1;
% SegmentItem.Parameters.Sets.End = SegmentItem.Parameters.Sets.Start;
% JOBLIST(end + 1) = SegmentItem;
% 
% SegmentItem.Parameters.Experiment.DiffusionStdDev = 3 * [1, 1];
% SegmentItem.Parameters.Sets.Start = SegmentItem.Parameters.Sets.Start + 1;
% SegmentItem.Parameters.Sets.End = SegmentItem.Parameters.Sets.Start;
% JOBLIST(end + 1) = SegmentItem;
% 
% SegmentItem.Parameters.Experiment.DiffusionStdDev = 4 * [1, 1];
% SegmentItem.Parameters.Sets.Start = SegmentItem.Parameters.Sets.Start + 1;
% SegmentItem.Parameters.Sets.End = SegmentItem.Parameters.Sets.Start;
% JOBLIST(end + 1) = SegmentItem;
% 
% SegmentItem.Parameters.Experiment.DiffusionStdDev = 5 * [1, 1];
% SegmentItem.Parameters.Sets.Start = SegmentItem.Parameters.Sets.Start + 1;
% SegmentItem.Parameters.Sets.End = SegmentItem.Parameters.Sets.Start;
% JOBLIST(end + 1) = SegmentItem;

% generateMonteCarloImageSet_micro(JOBLIST);

end








