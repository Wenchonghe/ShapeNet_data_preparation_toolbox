function preprocess_shapes(source_dir, dest_dir)
	source_files = dir(fullfile(source_dir, '*.mat'));
	for i = 1 : length(source_files)
		tmp = load(fullfile(source_dir, source_files(i).name));
		tmp = tmp.shape;
	
		shape = struct;
		shape.TRIV = tmp.TRIV + 1;
		shape.X = tmp.X';
		shape.Y = tmp.Y';
		shape.Z = tmp.Z';
		save(fullfile(dest_dir,source_files(i).name), 'shape');
	end
end
