function [y1] = PG_k(x1)
%PG_K neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 05-Feb-2019 22:03:42.
% 
% [y1] = PG_k(x1) takes these arguments:
%   x = 2xQ matrix, input #1
% and returns:
%   y = 1xQ matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [243.2;0.005081];
x1_step1.gain = [0.0250312891113892;0.040004065213107];
x1_step1.ymin = -1;

% Layer 1
b1 = [0.081062048306747736;0.0083795639625958707;0.30040070475094532;-0.61427694728861115;-0.00093092723651117871;-0.95151288973960635;-0.22917632201185392;-0.056762125320317214;-0.028011567950419494];
IW1_1 = [0.092849960106966375 0.035656373901128226;0.0037298642413358825 -0.002465818365321195;0.50100730720367059 -0.032913926063245377;-0.057214631770366453 0.42718198473685959;-0.023385142717161796 0.018949121295777749;-0.30714694045887997 0.30784900645997504;-0.020869051354014807 -0.065126050955394435;-0.0018470163627256127 -0.04578567305453881;-0.12720708190554378 0.00054681874026659002];

% Layer 2
b2 = [-0.52299358455927247;0.49938033467926729;0.14391725452835646;0.13893182580822933;-1.0802279241101864;-0.00039682145797933989];
IW2_1 = [-0.24912627485599448 -0.31043521577228966;-0.31566805924469227 0.36575779462882047;0.062638320025330971 -0.062794863191826769;-0.19951846242395269 0.47560550350873321;-0.45633235072399664 -0.60759126723236678;-0.0035065763603042456 -0.0019625591749946902];
LW2_1 = [-0.038666128908834529 -0.0057683408184952918 0.49930730361145037 -1.1514034087231111 0.0028215165376502542 1.5657267281743097 0.059809530100475398 0.013366665345965647 0.028583880987487167;-0.010789182144923439 -0.0043768496511528013 -0.41300197522131116 0.0067796402064838161 0.014246163564346832 -0.63541478700527143 -0.050522208091579777 -0.024967439318347589 0.047047910789818979;-0.0010453058991545965 -0.015291399179158812 -0.22908792827213759 0.11935440452005829 -0.0014580829613207494 -0.45467893680531019 0.023024868736979346 -0.003896840546276416 0.012352234935218177;-0.019335533844495278 -0.015778128615079566 -0.015576756235584072 -0.082062621646311784 0.014434206613116465 0.084371573316094253 0.022862432706008195 -0.0093987386579691724 0.032619074787118792;-0.086352923245571478 0.0039092107208281868 -0.42477397925336974 1.3685731916167021 -0.00080727179951848508 -0.17949183945678876 0.19979878266443643 0.070262186562569579 0.041445238354379209;-1.1304016899825975e-06 -8.6281477264972005e-05 0.0052664417137620228 -0.0031314558206342442 8.1353533279296798e-05 0.008615123781479701 0.00020089797489810418 3.0411008827115444e-05 0.00018840036670965008];

% Layer 3
b3 = -0.0064464324028235603;
IW3_1 = [0.092757677002355265 -0.45358192968888766];
LW3_1 = [0.05082970784054807 -0.030096770712324548 0.57614179193441362 -1.1277914159270117 -0.0066765181024577552 1.3991912089344885 0.012531720194347108 -0.013271774199468607 -0.019647219960428956];
LW3_2 = [1.6897478851798957 -0.88651663656021396 -0.5479152774252346 0.61935571675304202 -2.1142910189140851 0.011129872389458685];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = 6.56598818122127;
y1_step1.xoffset = 0.3364;

% ===== SIMULATION ========

% Dimensions
Q = size(x1,2); % samples

% Input 1
xp1 = mapminmax_apply(x1,x1_step1);

% Layer 1
a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*xp1);

% Layer 2
a2 = tansig_apply(repmat(b2,1,Q) + IW2_1*xp1 + LW2_1*a1);

% Layer 3
a3 = repmat(b3,1,Q) + IW3_1*xp1 + LW3_1*a1 + LW3_2*a2;

% Output 1
y1 = mapminmax_reverse(a3,y1_step1);
%**************************************************
%Anurag Goyal Added on 2019-02-05
%Making sure that output is bound between training data
if(y1<0.3364)
    y1=0.3364;
elseif(y1>0.6410)
    y1=0.6410;
else
    y1=y1;
end
%**************************************************
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
