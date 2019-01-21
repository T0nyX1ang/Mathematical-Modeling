function [Y,Xf,Af] = myNeuralNetworkFunction(X,~,~)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 16-Jul-2018 10:28:27.
%
% [Y] = myNeuralNetworkFunction(X,~,~) takes these arguments:
%
%   X = 1xTS cell, 1 inputs over TS timesteps
%   Each X{1,ts} = Qx2 matrix, input #1 at timestep ts.
%
% and returns:
%   Y = 1xTS cell of 1 outputs over TS timesteps.
%   Each Y{1,ts} = Qx1 matrix, output #1 at timestep ts.
%
% where Q is number of samples (or series) and TS is the number of timesteps.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [0.000506768047524364;0.00054385935765322];
x1_step1.gain = [1.00030195349408;1.00028261573557];
x1_step1.ymin = -1;

% Layer 1
b1 = [-24.936041855816903023;-6.011060583525710932;-0.49923690308408086302;2.8286628753742824038;-1.2548139830703524122;-0.10475527252214522633;-0.29553460841957940319;-0.10964443594378593672;-3.5125657603850650723;-6.0820443427115433721];
IW1_1 = [7.1235087800643936973 -29.384150394859418043;2.9714725185087003112 1.5263640400686744325;0.008833257348537112974 -0.5172491330064232784;-1.1485495711152426956 -0.18785098543697445472;1.0799349720219140192 1.6021723286671520903;0.70694228044210793982 1.2616330699685127659;0.13686701379066179562 -0.37324845747500090543;0.2713989606181237968 -0.26617510457683646319;0.19729849393557341575 1.6912498902752008956;1.9494003004760156461 2.7477785797918139465];

% Layer 2
b2 = 19.729392839298743212;
LW2_1 = [-0.00013887558552982525589 7.1282615579880630463 1.8851278322833771028 -2.1245363196582616183 -0.067813531788860112459 -0.059860984227860139506 -4.0651086710540988989 1.9925054643190378556 1.5419802518511591671 10.091341879562810036];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = 0.000750325470782323;
y1_step1.xoffset = 1.00016041803381;

% ===== SIMULATION ========

% Format Input Arguments
isCellX = iscell(X);
if ~isCellX
    X = {X};
end

% Dimensions
TS = size(X,2); % timesteps
if ~isempty(X)
    Q = size(X{1},1); % samples/series
else
    Q = 0;
end

% Allocate Outputs
Y = cell(1,TS);

% Time loop
for ts=1:TS
    
    % Input 1
    X{1,ts} = X{1,ts}';
    Xp1 = mapminmax_apply(X{1,ts},x1_step1);
    
    % Layer 1
    a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*Xp1);
    
    % Layer 2
    a2 = repmat(b2,1,Q) + LW2_1*a1;
    
    % Output 1
    Y{1,ts} = mapminmax_reverse(a2,y1_step1);
    Y{1,ts} = Y{1,ts}';
end

% Final Delay States
Xf = cell(1,0);
Af = cell(2,0);

% Format Output Arguments
if ~isCellX
    Y = cell2mat(Y);
end
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
y = bsxfun(@minus,x,settings.xoffset);
y = bsxfun(@times,y,settings.gain);
y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
x = bsxfun(@minus,y,settings.ymin);
x = bsxfun(@rdivide,x,settings.gain);
x = bsxfun(@plus,x,settings.xoffset);
end