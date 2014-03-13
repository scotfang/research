function dirs = getDirs( path )
%Get all directories in path, exclude directories starting with '.'
dirs = dir(path);
dirs = dirs(arrayfun(@(x) x.isdir, dirs)); %remove non-directories
dirs = dirs(~arrayfun(@(x) x.name(1)=='.', dirs)); %remove dirs starting
                                                   %with '.'
end

