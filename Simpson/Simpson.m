function I = Simpson(x,y)
%Summary: This function is used for the purpose of integrating experimental
%data using the Simpson's 1/3 rule.
%Inputs:
%       x: Independent variable from experimental data
%       y: Dependent variable from experimental data
%Outputs
%       I:  The integral of a given function

%%

% Checks to make sure at least two arguments are entered
if nargin ~= 2 
    error('Two arguments required')
end

%%

% Checks to see if input values are the same length.
if length(x) ~= length(y) 
    error('Inputs need to be the same length')
end

%%

% Checks to see whether the amount of intervals is even or odd. If odd,
% displays warning message that Trapezoidal Test will be used on last
% interval.
intervals = (size(x)-1);

if mod(intervals,2) == 0
    disp('Even amount of intervals')
else 
    disp('WARNING: Odd intervals - Trapezoidal Test will be used on last interval')
end

%%

% Checks what the spacing of the first interval is
intx = diff(x);

% Makes sure the intervals are all equal to the first interval. This makes 
%the intervals evenly spaced.
if  intx(1) ~= intx(1,:) 
    error('Unequal interval')
end

%%

Length = length(x);
a = min(x); % Sets the lower bound as a.
b = max(x); % Sets the upper bound as b.
X2 = 0; % Initializes variables
X1 = 0;
X3 = 0;
X4 = 0;

% Sums the values for odd segments
for S = 1:2:(Length-1) 
    X1 = (y(:,S)) + 2;
    X2 = X1 + X2;
end

% Sums the values for even even segments
for j = 2:2:(Length-2)
    X3 = (y(:,j));
    X4 =  X3 + X4;
end
%%

% Trapezoidal rule 
trapezoid = ((x(1,length(x)))- (x(1,length(x)-1)))*((y(1,length(x)-1)+(y(1,length(y)))))/2;

% If odd, Simpson's rule is used
if mod(intervals,2) == 1 
    I = (b-a).*((y(1,1)) + 4.*(X2) + 2.*(X4) + y(1,(Length)))/(3.*Length);
% If even, Simpson's rule and Trapezoidal rule is used 
else
    I = ((b-a).*((y(1,1)) + 4.*(X2) + ((X4/2)) + y(1,(Length)))/(3.*(length(x)))) + trapezoid;
end

% Displays the calculated integral
I

end

