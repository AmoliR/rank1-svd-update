%% PROGRAM TO CHECK IF TWO MATRICES ARE EQUAL OR NOT GIVEN SOME TOLERANCE

function [] = equalMat(a,b)
tol = 0.0001; %Define tolerance level
tolerance = tol(ones(size(a)));
if abs(a-b) < tolerance
    disp('Equal'); 
else 
    disp('Not Equal');
end


