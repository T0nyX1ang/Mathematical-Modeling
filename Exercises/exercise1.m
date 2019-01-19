% Exercise 1 - Basic Operators
% Edited by Tony Xiang
% Last Modified in 2018-7-11

%% First Thing First
A = [1 2 3 4 5; 6 7 8 9 10; 11 12 13 14 15];
B = [1 2; 3 4; 5 6; 7 8; 9 10];
C = [15 14 13 12 11; 10 9 8 7 6; 5 4 3 2 1];
D = [1 2 3 4 5; 6 7 8 9 10]
E = [1 2 3; 4 5 6; 7 8 9];

% Matrix Transpose & Point Transpose
A'
A.'

% Matrix Addition & Subtraction
A + C
A - C
A + 1 % Addition / Subtraction by element

% Matrix Multiplication & Point Multiplication
A * B
A .* C

% Matrix Division & Point Division [Left], solve x * B = A while A / B
chk1 = A / D
A ./ C
norm(chk1 * D - A)

% Matrix Division & Point Division [Right], solve A * x = B while A \ B
chk2 = A \ E
A .\ C
norm(A * chk2 - E)

% Matrix Power
E ^ 2
E .^ 2

%% Relation Operators
A > C  % gt: greater than
A < C  % lt: lower than
A >= C % ge: greater or equal than
A <= C % le: lower or equal than
A == C % eq: equal to
A ~= C % ne: not equal to

%% Boolean Operators
P = [1 1 0; 0 1 1; 0 0 1]
Q = [0 1 0; 1 1 0; 0 1 0]

and(P, Q) % element -> element
or(P, Q) % element -> element
not(P) % element -> element
xor(P, Q) % element -> element

%% Characteristic Operators
R = [1 2 3 inf; 2 nan 2 3]
S = [1 2 3 1; 2 5 2 4]
any(P) % vector -> element
all(P) % vector -> element
all(ones(3:3))
isnan(R) % element -> element 
isinf(R) % element -> element
isfinite(R) % element -> element
isempty(R) % matrix -> element
isletter(R) % element -> element
isprime(S) % element -> element
isreal(R) % matrix -> element

%% Find Operators [find(cond, number, direction)]
X = [1 -2 3 -4; -1 2 -3 4];
ind1 = find(X > 0)
ind2 = find(X > 0, 4)
ind3 = find(X > 0, 4, 'first')
ind4 = find(X > 0, 4, 'last')
[row1, col1] = find(X > 0, 2)
[row2, col2, v] = find(X > 0, 2)

%% String Operators
a = 'aaaa';
b = 'bbbb';
c = strcat(a, b)
f = 'sin(x.^2)';
fh = str2sym(f);
fhv = vectorize(fh);
value = quad(fhv, 2, 8);
v = 'f = @(x) x.^2';
eval(v);
f(4)
integ = integral(f, 2, 8)

%% Cell and Matrix Conversion
a_cell = cell(2, 5)
a_mat = rand(2, 3)
c = {a_mat} % Matrix -> Cell
cell2mat(c) % Cell -> Matrix
celldisp(c) % Show Cell Elements
% cellplot(c) % Show Cell Structure
num2cell(a_mat) % Element -> Cell

%% Predefined Elements
ans % Current Answer
eps % Minimum number
pi % 3.1415926...
inf % infinity: 1/0
NaN % not a number: 0/0
1i % imaginary unit: sqrt(-1)
1j % imaginary unit: sqrt(-1)