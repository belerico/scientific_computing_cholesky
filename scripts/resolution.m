%%% README
% per lanciare questo script bisogna creare una cartella 'matrices' e
% metterci dentro le matrici da analizzare
%%%
clear

% Test Matrix
<<<<<<< HEAD
files =  dir('matrices/');

for i = 3 : size(files, 1)
    disp(['Loading' ' ' files(i).name])
    matFile = load([files(i).folder, '/', files(i).name]);
    disp('Setting matrix A')
    A = matFile.Problem.A;
    disp('Compute exact solution xe')
=======
files =  dir('../matrices/');

for i = 3 : size(files, 1)
    M = load([files(i).folder, '/', files(i).name]);
  
    A = triu(M.Problem.A);
    M = []
>>>>>>> 1b524008c5a2824306e155008b581004c53f8088
    xe = ones(size(A, 1), 1);
    disp('Compute b')
    b = A * xe;
    xe = [];
    allvars = whos;
    init_memory = sum([allvars.bytes]);

    %% Solve the system
    disp('Solving system with Cholesky factorization...')
    tic
    L = chol(A);
    Y = linsolve(L, b);
    x_sol = linsolve(L, Y);
    toc
    disp('Done')
    
    %% Check
    allvars = whos;
    ending_memory = sum([allvars.bytes]);
    xe = ones(size(A, 1), 1);
    if (uint8(x_sol) == xe)
        disp([ "La matrice: ", files(i).name])
        disp("Ok la soluzione e' corretta");
        e = norm(x_sol - xe) / norm(xe);
        fprintf("L'errore e' %d", e);
        fprintf("La memoria usata (in Byte) e' %d", (ending_memory - init_memory));
    end
end