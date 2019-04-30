%%% README
% per lanciare questo script bisogna creare una cartella 'matrices' e
% metterci dentro le matrici da analizzare
%%%

function []=resolution(matrix)
  addpath(genpath(pwd()));
  if ispc
    os = 'windows';
  elseif isunix
    os = 'linux';
  end
  [x, xe, solv_time] = resolve(matrix);
  if (uint8(x) == xe)
      e = norm(x - xe) / norm(xe);
      result = sprintf('Resolving %s\nElapsed time: %d seconds\nRelative error: %d\n\n', matrix, solv_time, e);
      fid = fopen(['results' filesep 'matlab_' os '_results.txt'], 'a');
      fprintf(fid, result);
      fclose(fid);
  end
end

function [x, xe, solv_time]=resolve(matrix)
  M = load(['matrices', filesep, matrix]);
  A = M.Problem.A;
  clear M; 
  xe = ones(size(A, 1), 1);
  b = A * xe;
  tic;
  x = A \ b;
  solv_time = toc;
end
