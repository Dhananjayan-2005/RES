clc;
clear;
close all;

% PEM Fuel Cell Parameters
T = 310;
ph2 = 1;
po2 = 1;

A = 69.7;

z1 = -0.475;
z3 = 7.6e-5;
z4 = -1.0e-4;

Rc = 0.00019;
Rm = 0.08;

B = 0.0171;
Jmax = 1600;

% Number of cells in series
N = 52;

% Starting current
ifc = 0.1;

% Calculation
for i = 1:100

    % Nernst voltage
    E_N = 1.229 - (0.85e-3 * (T - 298.15)) ...
        + (1.31e-5 * T * (log(ph2) + 0.5 * log(po2)));

    % Oxygen concentration
    co2 = po2 / (5.08e6 * exp(-498/T));

    % Activation coefficient
    z2 = 0.00286 + 0.0002 * log(A) ...
        + (4.3e-5 * log(co2));

    % Activation voltage
    Vact = -(z1 + z2*T + z3*T*log(co2) ...
        + z4*T*log(ifc));

    % Ohmic voltage
    Vohmic = ifc * (Rm + Rc);

    % Current density
    J = ifc / A;

    % Concentration voltage
    Vcon = -B * log(1 - (J/Jmax));

    % Fuel cell stack voltage
    Vfc(i) = N * (E_N - Vact - Vohmic - Vcon);

    % Fuel cell current
    IFC(i) = ifc;

    % Increase current
    ifc = ifc + 0.1;

end

% Fuel cell power
Pfc = Vfc .* IFC;

% Plot
figure;

yyaxis left
plot(IFC, Vfc, 'LineWidth', 1.5);
ylim([0 300]);

xlabel('Fuel Cell Current (A)');
ylabel('Fuel Cell Voltage (V)');

yyaxis right
plot(IFC, Pfc, 'LineWidth', 1.5);
ylim([0 300]);

ylabel('Fuel Cell Power (W)');

grid on;

title('PEM Fuel Cell Voltage Current and Power Characteristics');