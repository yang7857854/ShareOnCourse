% generate the elastDyn file for openFAST 3.0 based on the given tower
% property

% Main input and calculation configration parameters
TwrFile = 'CoreWindActiveFloat_towerSecDT.txt';
BModesExe = 'BModes_Alpha.exe';
OutElstDynTwrFileName = 'IEA15MW_CoreWind_ElastoDyn_tower.dat';
TwrLength = 120.50;   % in meter 
TwrBaseHt = 9.0;
NumOutSec = 21;
Density = 8500;   % kg/m^3
YoungsModulus = 2.10E11; % Pa
ShearModulus = 8.08E10;  % Pa
TwrTopMass = 1639877.;
CM_Loc = -6.476016;
CM_axial = 4.2691133;
ixxMat = [3.89258526e+08 2.29364247e+08 1.86875391e+08 0. -7199394.0784606 0. ]; % ixx_tip ,iyy_tip,izz_tip,ixy_tip, izx_tip,iyz_tip

% Start to calculate
% 1: Interpolate tower input
TwrSecsDT = load (TwrFile);  % HtFrac, Diameter in meter, thickness in mm;
dHtFrac =  1.0/(NumOutSec-1);
HtFrac = 0:dHtFrac:1.0;
DiaSecs = interp1(TwrSecsDT(:,1),TwrSecsDT(:,2),HtFrac,'pchip');
TckSecs = interp1(TwrSecsDT(:,1),TwrSecsDT(:,3),HtFrac,'pchip');

%2: Tower properties
Area = 0.25*pi*(DiaSecs.^2 - (DiaSecs-2*TckSecs*0.001).^2);
AreaInertia = 1.0/16.0*pi*(DiaSecs.^4 - (DiaSecs-2*TckSecs*0.001).^4);
PolarInertia = 2.0 * AreaInertia;
MassDenSecs = Density * Area;
TwrFAStff = YoungsModulus * AreaInertia;
TwrSSStff = TwrFAStff;
TwrGJStff = ShearModulus * PolarInertia;
TwrEAStff = YoungsModulus * Area;
TwrFAIner = Density * AreaInertia;
TwrSSIner = TwrFAIner;

%3. write Bmodes input file.
LenOutFile = length(OutElstDynTwrFileName);
BModesSecFile = strcat(OutElstDynTwrFileName(1:LenOutFile-4),'_Sec.dat');
BModesInFile = strcat(OutElstDynTwrFileName(1:LenOutFile-4),'.bmi');
wrtBModesSecFile (BModesSecFile,HtFrac,MassDenSecs,TwrFAStff,TwrSSStff,...
                  TwrGJStff,TwrEAStff,TwrFAIner,TwrSSIner);
wrtBModesInFile (BModesInFile,BModesSecFile,TwrLength,TwrBaseHt,...
                 TwrTopMass,CM_Loc,CM_axial,ixxMat);

% 4. run BModes
commandLine =strcat(BModesExe,32,BModesInFile);
system(commandLine);

% 5. get Modeshape coefficients
BModesOutFile = strcat(OutElstDynTwrFileName(1:LenOutFile-4),'.out');
MSIDs = [2 5 1 4]; % corresponding to 1st FA, 2nd FA, 1st SS and 2nd SS, respectively.
MaxMode = 10;        % Number of mode in the .out file
MethodID = 1;        % 1 for "Projection" method, 2 for "Improved Direct" method
% get the mode shapes and slope at the bottom
[ModeShapes,Slopes] = ReadBModOut(BModesOutFile,MaxMode,MSIDs);
% calculate the shape coefficients
Coeffs = getModeShapeCoef(ModeShapes,Slopes,MethodID);
% output the results
fileNameOut = strcat(BModesOutFile(1:length(BModesOutFile)-4),'_ModeShapeCoefs.txt');
writeCoeffs(Coeffs,fileNameOut)

% write OpenFAST v3.0 ElastDyn tower file

wrtElastDynTwrFile (OutElstDynTwrFileName,Coeffs,HtFrac,MassDenSecs,...
                    TwrFAStff,TwrSSStff)
% Done



