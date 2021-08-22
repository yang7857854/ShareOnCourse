clear all
close all
BModesOut = 'G:\StudyJeyla\Research\1Papers\2021Chinese\15MWSeismic\Bmodes\IEA15MWmonopile_tower_30m_forFASTv7_Rigid.out';
MSIDs = [2 5 1 4]; % corresponding to 1st FA, 2nd FA, 1st SS and 2nd SS, respectively.
MaxMode = 10;        % Number of mode in the .out file
MethodID = 1;        % 1 for "Projection" method, 2 for "Improved Direct" method
% get the mode shapes and slope at the bottom
[ModeShapes,Slopes] = ReadBModOut(BModesOut,MaxMode,MSIDs);
% calculate the shape coefficients
Coeffs = getModeShapeCoef(ModeShapes,Slopes,MethodID);
% output the results
fileNameOut = strcat(BModesOut(1:length(BModesOut)-4),'_ModeShapeCoefs.txt');
writeCoeffs(Coeffs,fileNameOut)
disp(strcat('Check mode shape coefficients in: ',fileNameOut))