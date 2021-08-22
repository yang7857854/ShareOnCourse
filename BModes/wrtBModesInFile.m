function [] = wrtBModesInFile (BModesInFile,BModesSecFile,TwrLength,TwrBaseHt,...
                               TwrTopMass,CM_Loc,CM_axial,ixxMat)
  
                           
% generate the BModes input file for a fixed base foundation
                           
TwrHt = TwrLength + TwrBaseHt;
fid1 = fopen(BModesInFile,'wt');

fprintf(fid1,'%s \n','======================   BModes v3.00 Main Input File  ==================');
fprintf(fid1,'%s \n',strcat('BMode input for a tower defined in',BModesSecFile));
fprintf(fid1,'%s \n',' ');
fprintf(fid1,'%s \n','--------- General parameters ---------------------------------------------------------------------');
fprintf(fid1,'%s \n','true      Echo        Echo input file contents to *.echo file if true.');
fprintf(fid1,'%s \n','2         beam_type   1: blade, 2: tower (-)');
fprintf(fid1,'%s \n','0.        romg:       rotor speed, automatically set to zero for tower modal analysis (rpm)');
fprintf(fid1,'%s \n','1.        romg_mult:  rotor speed muliplicative factor (-)');
fprintf(fid1,'%7.3f \t %s \n', TwrHt,'radius:     rotor tip radius measured along coned blade axis, OR tower height above ground level [onshore] or MSL [offshore](m)');
fprintf(fid1,'%s \n','0.0      hub_rad:    hub radius measured along coned blade axis OR tower rigid-base height (m)');
fprintf(fid1,'%s \n','0.        precone:    built-in precone angle, automatically set to zero for a tower (deg)');
fprintf(fid1,'%s \n','0.        bl_thp:     blade pitch setting, automatically set to zero for a tower (deg)');
fprintf(fid1,'%s \n','1         hub_conn:   hub-to-blade or tower-base boundary condition [1: cantilevered; 2: free-free; 3: only axial and torsion constraints] (-)');
fprintf(fid1,'%s \n','20        modepr:     number of modes to be printed (-)');
fprintf(fid1,'%s \n','t         TabDelim    (true: tab-delimited output tables; false: space-delimited tables)');
fprintf(fid1,'%s \n','f         mid_node_tw  (true: output twist at mid-node of elements; false: no mid-node outputs)');
fprintf(fid1,'%s \n',' ');
fprintf(fid1,'%s \n','--------- Blade-tip or tower-top mass properties --------------------------------------------');
fprintf(fid1,'%15.7e \t %s \n',TwrTopMass,'tip_mass    blade-tip or tower-top mass (kg)');
fprintf(fid1,'%15.7e \t %s \n',CM_Loc,'cm_loc      tip-mass c.m. offset from the tower axis measured along x-tower axis (m)');
fprintf(fid1,'%15.7e \t %s \n',CM_axial,'cm_axial    tip-mass c.m. offset tower tip measures axially along the z axis (m)');
fprintf(fid1,'%15.7e \t %s \n',ixxMat(1),'ixx_tip     blade lag mass moment of inertia about the tip-section x reference axis (kg-m^2)');
fprintf(fid1,'%15.7e \t %s \n',ixxMat(2),'iyy_tip     blade flap mass moment of inertia about the tip-section y reference axis (kg-m^2)');
fprintf(fid1,'%15.7e \t %s \n',ixxMat(3),'izz_tip     torsion mass moment of inertia about the tip-section z reference axis (kg-m^2)');
fprintf(fid1,'%15.7e \t %s \n',ixxMat(4),'ixy_tip     cross product of inertia about x and y reference axes(kg-m^2)');
fprintf(fid1,'%15.7e \t %s \n',ixxMat(5),'izx_tip     cross product of inertia about z and x reference axes(kg-m^2)');
fprintf(fid1,'%15.7e \t %s \n',ixxMat(6),'iyz_tip     cross product of inertia about y and z reference axes(kg-m^2)');
fprintf(fid1,'%s \n',' ');
fprintf(fid1,'%s \n','--------- Distributed-property identifiers --------------------------------------------------------');
fprintf(fid1,'%s \n','1         id_mat:     material_type [1: isotropic; non-isotropic composites option not yet available]');
fprintf(fid1,'%s \t %s \n',strcat('"',BModesSecFile,'"'),': sec_props_file   name of beam section properties file (-)');
fprintf(fid1,'%s \n',' ');
fprintf(fid1,'%s \n','Property scaling factors..............................');
fprintf(fid1,'%s \n','1.0       sec_mass_mult:   mass density multiplier (-)');
fprintf(fid1,'%s \n','1.0       flp_iner_mult:   blade flap or tower f-a inertia multiplier (-)');
fprintf(fid1,'%s \n','1.0       lag_iner_mult:   blade lag or tower s-s inertia multiplier (-)');
fprintf(fid1,'%s \n','1.0       flp_stff_mult:   blade flap or tower f-a bending stiffness multiplier (-)');
fprintf(fid1,'%s \n','1.0       edge_stff_mult:  blade lag or tower s-s bending stiffness multiplier (-)');
fprintf(fid1,'%s \n','1.0       tor_stff_mult:   torsion stiffness multiplier (-)');
fprintf(fid1,'%s \n','1.0       axial_stff_mult: axial stiffness multiplier (-)');
fprintf(fid1,'%s \n','1.0       cg_offst_mult:   cg offset multiplier (-)');
fprintf(fid1,'%s \n','1.0       sc_offst_mult:   shear center multiplier (-)');
fprintf(fid1,'%s \n','1.0       tc_offst_mult:   tension center multiplier (-)');
fprintf(fid1,'%s \n','');
fprintf(fid1,'%s \n','--------- Finite element discretization --------------------------------------------------');
fprintf(fid1,'%s \n','50        nselt:     no of blade or tower elements (-)');
fprintf(fid1,'%s \n','Distance of element boundary nodes from blade or flexible-tower root (normalized wrt blade or tower length), el_loc()');
fprintf(fid1,'%s \n','0.0000	0.0200	0.0400	0.0600	0.0800	0.1000	0.1200	0.1400	0.1600	0.1800	0.2000	0.2200	0.2400	0.2600	0.2800	0.3000	0.3200	0.3400	0.3600	0.3800	0.4000	0.4200	0.4400	0.4600	0.4800	0.5000	0.5200	0.5400	0.5600	0.5800	0.6000	0.6200	0.6400	0.6600	0.6800	0.7000	0.7200	0.7400	0.7600	0.7800	0.8000	0.8200	0.8400	0.8600	0.8800	0.9000	0.9200	0.9400	0.9600	0.9800	1.0000');
fprintf(fid1,'%s \n','');
fprintf(fid1,'%s \n','--------- Properties of tower support subsystem (read only if beam_type is 2) ------------');
fprintf(fid1,'%s \n','1          tow_support: : aditional tower support [0: no additional support; 1: floating-platform or monopile with or without tension wires] (-)');
fprintf(fid1,'%8.3f \t %s \n',-TwrBaseHt,'draft        : depth of tower base from the ground or the MSL (mean sea level) (m)');
fprintf(fid1,'%s \n','0.    cm_pform     : distance of platform c.m. below the MSL (m)');
fprintf(fid1,'%s \n','0.  mass_pform   : platform mass (kg)');
fprintf(fid1,'%s \n','Platform mass inertia 3X3 matrix (i_matrix_pform):');
fprintf(fid1,'%s \n','0.   0.   0.');
fprintf(fid1,'%s \n','0.   0.   0.');
fprintf(fid1,'%s \n','0.   0.   0.');
fprintf(fid1,'%s \n','0.0        ref_msl    : distance of platform reference point below the MSL (m)');
fprintf(fid1,'%s \n','Platform-reference-point-referred hydrodynamic 6X6 matrix (hydro_M):');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.0');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','Platform-reference-point-referred hydrodynamic 6X6 stiffness matrix (hydro_K):');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','Mooring-system 6X6 stiffness matrix (mooring_K):');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.0');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','0.  0.  0.  0.  0.  0.');
fprintf(fid1,'%s \n','');
fprintf(fid1,'%s \n','Distributed (hydrodynamic) added-mass per unit length along a flexible portion of the tower length:');
fprintf(fid1,'%s \n','0           n_secs_m_distr: number of sections at which added mass per unit length is specified (-)');
fprintf(fid1,'%s \n','0.  0.    : z_distr_m [row array of size n_added_m_pts; section locations wrt the flexible tower base over which distributed mass is specified] (m)');
fprintf(fid1,'%s \n','0.  0.    : distr_m [row array of size n_added_m_pts; added distributed masses per unit length] (kg/m)');
fprintf(fid1,'%s \n','');
fprintf(fid1,'%s \n','Distributed elastic stiffness per unit length along a flexible portion of the tower length:');
fprintf(fid1,'%s \n','0           n_secs_k_distr: number of points at which distributed stiffness per unit length is specified (-)');
fprintf(fid1,'%s \n','0	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	27	28	29	30	31	32	33	34	35	36  : z_distr_k [row array of size n_added_m_pts; section locations wrt the flexible tower base over which distributed stiffness is specified] (m)');
fprintf(fid1,'%s \n','595318000.0 	1165208000	1129400000	1095553000	1059931000	1024493000	989209000	953643000	918718000	883287000	847803000	812541000	777187000	741870000	706616000	671440000	636229000	600957000	565919000	530470000	495081000	459574000	385327000	305479000	280059000	254125000	227500000	200112000	171927000	143115000	114173000	80184000	52237000	35561000	20912000	9000000	1156000   : distr_k [row array of size n_added_m_pts; distributed stiffness per unit length] (N/m^2)');
fprintf(fid1,'%s \n','');
fprintf(fid1,'%s \n','Tension wires data');
fprintf(fid1,'%s \n','0         n_attachments: no of wire-attachment locations on tower [0: no tension wires] (-)');
fprintf(fid1,'%s \n','3 3       n_wires:       no of wires attached at each location (must be 3 or higher) (-)');
fprintf(fid1,'%s \n','6 9       node_attach:   node numbers of attacments location (node number must be more than 1 and less than nselt+2) (-)');
fprintf(fid1,'%s \n','0.e0 0.e0 wire_stfness:  wire spring constant in each set (see users  manual) (N/m)');
fprintf(fid1,'%s \n','0. 0.     th_wire:       angle of tension wires (wrt the horizontal ground plane) at each attachment point (deg)');
fprintf(fid1,'%s \n','');
fprintf(fid1,'%s \n','END of Main Input File Data *********************************************************************');
fprintf(fid1,'%s \n','*************************************************************************************************');
fprintf(fid1,'%s \n','*************************************************************************************************');
fclose('all');  




