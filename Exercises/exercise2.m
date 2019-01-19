% Exercise 2 - File I/O & Matrix Generation
% Edited by Tony Xiang
% Last Modified in 2018-7-13

%% Default Matrix Generation
A = zeros(3, 5) % Element -> 0
B = ones(3, 5) % Element -> 1
C = rand(3, 5) % Element -> rand(0, 1)
D = eye(3, 5) % Diagonal -> 1
E = diag(C) % Get Diagonal [when input is a matrix]
F = diag(E) % Generate Diagonal Matrix [when input is a vector]
G = linspace(4, 8) % Generate a Linear Space from a to b [default dimension]
H = linspace(4, 8, 5) % Generate a Linear Space from a to b [fixed dimension]

%% Read From Files
% You can use load to read from NUMERIC tables [table -> matrix] 
% You can use importdata to read from normal tables [table -> struct]
% You can use xlsread to read from MS_Excel tables [table -> matrix]
a = importdata('.\Test_Files\normal_table1.txt');
b = importdata('.\Test_Files\normal_table2.txt');
c = importdata('.\Test_Files\normal_table3.txt');
a.data
a.colheaders % Get Column Names
b.data
b.rowheaders % Get Row Names
c.data
c.textdata % Get Text Names
load '.\Test_Files\numeric_table.txt'
d = xlsread('.\Test_Files\Excel_table1.xlsx') % default xlsread
e = xlsread('.\Test_Files\Excel_table1.xlsx','Sheet1','B2:D4') % specify parameters

%% Write to Files
% You can use save to write data to files [matrix -> table]
% You can use xlswrite to write data to MS_Excel tables [matrix -> table]

% save('table_save1') 
xlswrite('.\Test_Files\Excel_table2.xlsx', e)

%% Working Directory
pwd % Current Working Directory
cd % Change Directory [Or chdir]

%% Batch I/O
str = uigetdir('Please Choose Working Directory');
cd(str);
N = 1000; % Output File Number
% Generate Random Matrix
for i = 1:N
    filename = strcat(num2str(i), '.txt');
    RandMatrix = rand(3, 3);
    save(filename, 'RandMatrix', '-ascii');
end
for i = 1:N
    filename = strcat(num2str(i), '.txt')
    temp = load(filename);
    save('matcat.txt', 'temp', '-append', '-ascii');
end
