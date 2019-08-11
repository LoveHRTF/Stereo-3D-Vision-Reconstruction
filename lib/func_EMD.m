function [R1, R2, t1, t2] = func_EMD(E)

TTT = 1/2 * trace(E * E') * eye(3) - E * E';                                % Calculate TT
coff = adjoint(E)';                                                         % Calculate E_cof

t1 = TTT(1,:) / sqrt(TTT(1,1));
t2 = TTT(2,:) / sqrt(TTT(2,2));
t3 = TTT(3,:) / sqrt(TTT(3,3));

if abs(t1(1) - t2(1)) <= 0.0001
    t2 = t3;
end

t1_sew = [0, -t1(3), t1(2); t1(3), 0, -t1(1) ;-t1(2), t1(1), 0]; 
t2_sew = [0, -t2(3), t2(2); t2(3), 0, -t2(1) ;-t2(2), t2(1), 0]; 

R1 = (1/(sum(t1.^2))) * coff - (1/(sum(t1.^2))) * t1_sew * E;
R2 = (1/(sum(t2.^2))) * coff - (1/(sum(t2.^2))) * t2_sew * E;
end

