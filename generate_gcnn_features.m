rng(190, 'twister');
addpath(genpath('isc'));

data_root = 'GCNN_data/';

%% Change the data format
conv_dir = fullfile(data_root, 'converted');
disp('Transposing the X,Y,Z vectors...');
preprocess_shapes(data_root, conv_dir);
disp('Done.');

%% Compute LBO
disp('Extracting the Laplaz-Beltrami Operator...');
lbo_dir = fullfile(data_root, 'lbo');
nLBO = 300;
extract_lbo(conv_dir, lbo_dir, nLBO);
disp('Done');

%% Compute GEOVEC
disp('Extracting geovec parameters...');
nGEOVEC = 150;
geovec_dir = fullfile(data_root, 'geovec');
geovec_params = estimate_geovec_params(lbo_dir, nGEOVEC);
extract_geovec(lbo_dir, geovec_dir, geovec_params);
disp('Done');

%% Compute patch operator (disk)
disp('Extracting the patch operator...');
disk_dir = fullfile(data_root, 'disk');
patch_params.rad          = 0.01;    % disk radius
patch_params.flag_dist    = 'fmm';   % possible choices: 'fmm' or 'min'
patch_params.nbinsr       = 5;       % number of rings
patch_params.nbinsth      = 16;      % number of rays
patch_params.fhs          = 2.0;     % factor determining hardness of scale quantization
patch_params.fha          = 0.01;    % factor determining hardness of angle quantization
patch_params.geod_th      = true;
extract_patch_operator(conv_dir, disk_dir, patch_params);
disp('Done');
