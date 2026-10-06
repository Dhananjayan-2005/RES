clc;
clear;
close all;

K = 1.38065e-23;
q = 1.602e-19;

Iscn = 8.21;
Vocn = 32.9;

Ki = 0.0032;
Ns = 54;

T = 25 + 273;
Tn = 30 + 273;
Gn = 1000;

a = 2;
Eg = 1.2;

G = 1000;
Rs = 0.221;
Rp = 415.405;

Vtn = Ns*K*Tn/q;
I0n = Iscn/(exp(Vocn/(a*Vtn))-1);

I0 = I0n*(Tn/T)^3*exp((q*Eg/(a*K))*(1/Tn-1/T));

Ipv = (G/Gn)*(Iscn + Ki*(T-Tn));

Vt = Ns*K*T/q;

i = 1;
I(1) = 0;

for V = Vocn:-0.1:0

    I1 = I0*(exp((V+I(i)*Rs)/(Vt*a))-1);
    I2 = (V+I(i)*Rs)/Rp;

    I(i+1) = Ipv - I1 - I2;

    if I(i+1) < 0
        I(i+1) = 0;
    end

    Vi(i) = V;
    P(i) = V*I(i+1);

    i = i+1;
end

plot(Vi,I(2:i),'r','LineWidth',2);
xlabel('Voltage (V)');
ylabel('Current (A)');
grid on;

figure;
plot(Vi,P,'k','LineWidth',2);
xlabel('Voltage (V)');
ylabel('Power (W)');
grid on;