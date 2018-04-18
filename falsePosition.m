function [root, fx, ea, iter] = falsePosition(func, xl, xu, es, maxiter)
%%

%Summary: The falsePosition function provides accurate estimates of the
%dependent variable within a given area by using the bracketing method.
%Inputs:
%   func - the function being evaluated
%   x_l - the lower guess
%   x_u - the upper guess
%   es - the desired relative error (default = 0.0001%)
%   maxiter - the number of iterations desired (default = 200)
%Outputs:
%   root - the estimated root location
%   fx - the function evaluated at the root location
%   ea - the approximate relative error (%)
%   iter - how many iterations were performed

%%

if nargin < 3 % makes sure user inputs at least three arguments
    error('At least three input variables are required')
elseif nargin < 4 % if there are less than four arguments assigns default variables
    es = 0.0001;% default for desired approximate relative error
    maxiter = 200;%default for max iterations
elseif nargin < 5 % if there are less than five arguments assigns default variable
    maxiter = 200;
elseif nargin > 5 % if more than five input arguments return error
    error ('Unable to have more than 5 arguments')
end

%%

stest = func(xl) * func(xu); % tests to make sure brackets contain a root
if stest > 0
    error('Bracket does not contain a root')% no root because a negative times a positive will be negative
elseif stest == 0
    error('One bracket is a root')% One bracket is a root because 0 multiplied by anything is 0
end

%%
oldroot = 0;
iter = 0; % intializes iterations to start at 0
while iter <= maxiter % iterations will continue running until the set max number of iterations
    root = xu - ((func(xu)*(xl -xu))/(func(xl) - func(xu)));% false position equation to find root
    fx = func(root); % evaluates function value at the root
    iter = iter + 1;% increases iterations by one every time code goes through the while loop
    if root ~= 0
        ea = abs((root - oldroot)/root)*100;% calculates approximate relative error
        oldroot = root;% sets oldroot to the root so next time loop is run it will be the old loop
    end
    if func(root)*func(xl) < 0% multiplies root to the lower guess
        xu = root; % sets upper limit as the root
    elseif func(root)*func(xu) < 0% multiplies root to the upper guess
        xl = root;% sets lower limit as the root
    else
        ea = 0;% checks to see if error is 0
    end
    if  ea < es || iter >= maxiter % checks if error is small enough or if max iterations has been reached
        break%stops loop
    end
    
end
    fprintf('Root: %f\n',root)%prints root value
    fprintf('Number of Iterations: %f\n', iter)%prints number of iterations
    fprintf('Error: %f\n',ea)%prints approximate relative error
    fprintf('Value of Function at Root: %f\n', fx)%prints the value of the function at the root
end

