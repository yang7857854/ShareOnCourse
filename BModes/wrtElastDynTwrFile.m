function [] = wrtElastDynTwrFile (OutElstDynTwrFileName,Coef,HtFrac,MassDenSecs,...
                    TwrFAStff,TwrSSStff)
% write the tower file for ElastDyn in OpenFAST 3.0
NumLines = length(MassDenSecs);

fid1 = fopen(OutElstDynTwrFileName,'wt');
fprintf(fid1,'%s \n','------- ELASTODYN V1.00.* TOWER INPUT FILE -------------------------------------');
fprintf(fid1,'%s \n','IEA 15 MW offshore reference model on UMaine VolturnUS-S semi-submersible floating platform');
fprintf(fid1,'%s \n','---------------------- TOWER PARAMETERS ----------------------------------------');
fprintf(fid1,'%5d \t %s \n',NumLines,'NTwInpSt    - Number of input stations to specify tower geometry');
fprintf(fid1,'%s \n','1.0                    TwrFADmp(1) - Tower 1st fore-aft mode structural damping ratio (%)');
fprintf(fid1,'%s \n','1.0                    TwrFADmp(2) - Tower 2nd fore-aft mode structural damping ratio (%)');
fprintf(fid1,'%s \n','1.0                    TwrSSDmp(1) - Tower 1st side-to-side mode structural damping ratio (%)');
fprintf(fid1,'%s \n','1.0                    TwrSSDmp(2) - Tower 2nd side-to-side mode structural damping ratio (%)');
fprintf(fid1,'%s \n','---------------------- TOWER ADJUSTMUNT FACTORS --------------------------------');
fprintf(fid1,'%s \n','1.0                    FAStTunr(1) - Tower fore-aft modal stiffness tuner, 1st mode (-)');
fprintf(fid1,'%s \n','1.0                    FAStTunr(2) - Tower fore-aft modal stiffness tuner, 2nd mode (-)');
fprintf(fid1,'%s \n','1.0                    SSStTunr(1) - Tower side-to-side stiffness tuner, 1st mode (-)');
fprintf(fid1,'%s \n','1.0                    SSStTunr(2) - Tower side-to-side stiffness tuner, 2nd mode (-)');
fprintf(fid1,'%s \n','1.0                    AdjTwMa     - Factor to adjust tower mass density (-)');
fprintf(fid1,'%s \n','1.0                    AdjFASt     - Factor to adjust tower fore-aft stiffness (-)');
fprintf(fid1,'%s \n','1.0                    AdjSSSt     - Factor to adjust tower side-to-side stiffness (-)');
fprintf(fid1,'%s \n','---------------------- DISTRIBUTED TOWER PROPERTIES ----------------------------');
fprintf(fid1,'%s \n','  HtFract       TMassDen         TwFAStif       TwSSStif');
fprintf(fid1,'%s \n','   (-)           (kg/m)           (Nm^2)         (Nm^2)');
for i=1:NumLines
    fprintf(fid1,'%13.6e \t %13.6e \t %13.6e \t %13.6e \n',HtFrac(i),MassDenSecs(i),TwrFAStff(i),TwrSSStff(i));
end

fprintf(fid1,'%s \n','---------------------- TOWER FORE-AFT MODE SHAPES -------');
for i=1:5
        TempS = num2str(i+1);
        fprintf(fid1,'%13.7f \t %s \n',Coef(i), strcat('TwFAM1Sh(',TempS,') - Mode 1, coefficient of x^',TempS,' term'));
    end
    for i=1:5
        TempS = num2str(i+1);
        fprintf(fid1,'%13.7f \t %s \n',Coef(i+5), strcat('TwFAM2Sh(',TempS,') - Mode 2, coefficient of x^',TempS,' term'));
    end
    fprintf(fid1,'%s \n','---------------------- TOWER SIDE-TO-SIDE MODE SHAPES --------------------------');
    for i=1:5
        TempS = num2str(i+1);
        fprintf(fid1,'%13.7f \t %s \n',Coef(i+10), strcat('TwSSM1Sh(',TempS,') - Mode 1, coefficient of x^',TempS,' term'));
    end
    for i=1:5
        TempS = num2str(i+1);
        fprintf(fid1,'%13.7f \t %s \n',Coef(i+15), strcat('TwSSM2Sh(',TempS,') - Mode 2, coefficient of x^',TempS,' term'));
    end
fclose('all');


