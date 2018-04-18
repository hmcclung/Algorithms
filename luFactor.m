function [L, U, P] = luFactor(A)
%%

%Summary: The luFactor function performs LU factorization using partial
%pivoting and gives the [L], [U], and [P] matrices from a given coefficient
%matrix.
%Inputs:
%   A = coefficient matrix
%Outputs:
%   L = Lower Triangular Matrix
%   U = Upper Triangular Matrix
%   P = Pivot Matrix
% Instructions:
%   Enter the [A] matrix of coefficients.

%%
%Checks to make sure only one input argument is entered.
if nargin > 1 
    error('Only one input argument is needed')
elseif nargin < 1
    error('One input argument is needed')
end
%Checks to make sure matrix entered is a square matrix.
[row,column] = size(A);
if row~=column
    error('Not a square matrix')
end
%%

d = length(A);% Makes the variable d equal to the length of the [A] matrix 
U = A;% Sets U equal to A
L = eye(d);% Creates an identity matrix based on the variable d. Then
%assigns that matrix to L.
P = eye(d);% Creates an identity matrix based on the variable d. Then
%assigns that matrix to P.

%%

for g = 1:d % Sets g equal to an array from 1 to d
    [~,m] = max(abs(U(g:d,g)));% Finds the number with the maximum magnitude
    % in the U matrix
    m = m + (g - 1); % Sets m equal to row that is being operated on
  
    temp = P(:,1);% Creates temporary array to store max values in first row
    P(1,:) = P(g,:);% Sets the row with lower values to the row being 
    % switched from.
    P(g,:) = temp;% Sets the row that max values should be on equal to the 
    % max values.
    
    temp = L(g,1:g-1);% This section does the same thing as above with the 
    % L matrix so that it follows pivoting.
    L(g,1:g-1) = L(m,1:g-1);
    L(m,1:g-1) = temp;
    
    temp = U(g,g:end);% This section does the same thing as the two sections
    % above but with the U matrix.
    U(g,g:end) = U(m,g:end);
    U(m,g:end) = temp;
    
   L(g,g) = 1;% Sets matrix coordinate (g,g)equal to 1
   for vec = (1 + g):size(U,1)% vec sets up a vector for value inputs
       mul_factor = U(vec,g)/U(g,g);% Calculates what the vector needs to
       %multiplied by to make the coefficient 0
       U(vec,g:d) = U(vec,g:d) - U(g,g:d)*mul_factor;% Performs the
       %calculations needed for Gauss Elimination
       L(vec,g) = mul_factor;% Takes the L matrix and inputs the 
       %mul_factor value
   end
end
   disp('P')
   fprintf('%4d %4d %4d\n',(P'));% displays P matrix
   disp('U')
   fprintf('%4d %4d %4d\n',(U'));% displays U matrix 
   disp('L')
   fprintf('%4d %4d %4d\n',(L'));% displays L Matrix
end


