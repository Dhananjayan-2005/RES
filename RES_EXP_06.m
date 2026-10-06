clear
clc
close all

Vbati = [];
SOCi = [];

for I1 = 5:1:5
    t1 = 7;
    SOC1 = 0.2;
    K = 0.8;
    D = 1e-5;
    SOCm = 936;
    ns = 6;
    SOC2 = SOC1;

    for t = 0:0.1:t1

        B = SOC2;

        if (I1 <= 0)       % discharging mode
            V1 = (1.926 + 0.124*B)*ns;
            R1 = (.19 + .1037/(B - .14))*ns/SOCm;

        elseif (I1 > 0)    % charging mode
            V1 = (2 + .148*B)*ns;
            R1 = (.758 + .1309/(1.06 - B))*ns/SOCm;
        end

        R1 = double(R1);

        % SOC calculation
        f1 = K*V1*I1 - D*SOC2*SOCm;
        SOC = SOC2 + (f1/SOCm)*0.1;

        SOC2 = SOC;

        % Battery voltage
        Vbat = V1 + I1*R1;
        Vbat = double(Vbat);

        % Store values
        Vbati = [Vbati; Vbat];
        SOC = double(SOC);
        SOCi = [SOCi; SOC];

    end
end

Vbati
SOCi

figure
plot(Vbati)
xlabel('Time')
ylabel('Battery Voltage')
title('Battery Voltage')

figure
plot(SOCi)
xlabel('Time')
ylabel('SOC')
title('State of Charge')