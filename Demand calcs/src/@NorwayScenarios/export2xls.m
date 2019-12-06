function  export2xls(obj, filename )
%EXPORT2XLS Summary of this function goes here
%   Detailed explanation goes here

matrixOut = cell(18,16);

matrixOut{1,1} = obj.scenarioName;
matrixOut{2,1} = 'RCP:';
matrixOut{2,2} = obj.RCP_number;
header1 = {'Year', 'Final energy', 'Final energy|i feed', 'Final energy|i spec', 'Final energy|i therm', 'Final energy|rc spec', 'Final energy|rc therm', 'Final energy|transport'};
header2 = {'Final energy per capita','Final energy per capita|i feed|normalized 2010', 'Final energy per capita|i spec|normalized 2010', 'Final energy per capita|i therm|normalized 2010', 'Final energy per capita|rc spec|normalized 2010', 'Final energy per capita|rc therm|normalized 2010', 'Final energy per capita|transport|normalized 2010'};

for i = 1:8
    matrixOut{4,i} = header1{i};
    if i > 1
        matrixOut{5,i} = 'GWa';
    end
    
end
for i = 9:15
        matrixOut{4,i} =  header2{i-8};
        matrixOut{5,i} = '-';
end

matrixOut{4,16} = 'Population';
matrixOut{5,16} = 'cap';

for i = 6:18
    matrixOut{i,1} = obj.time_vector(i-5);
    matrixOut{i,2} = obj.demand_finalEnergy_GWa(i-5);
    matrixOut{i,3} = obj.demand_finalEnergy_GWa_i_feed(i-5);
    matrixOut{i,4} = obj.demand_finalEnergy_GWa_i_spec(i-5);
    matrixOut{i,5} = obj.demand_finalEnergy_GWa_i_therm(i-5);
    matrixOut{i,6} = obj.demand_finalEnergy_GWa_rc_spec(i-5);
    matrixOut{i,7} = obj.demand_finalEnergy_GWa_rc_therm(i-5);
    matrixOut{i,8} = obj.demand_finalEnergy_GWa_transport(i-5);
    matrixOut{i,9} = obj.normalized2010_finalEnergyPerCapita(i-5);
    matrixOut{i,10} = obj.normalized2010_finalEnergyPerCapita_i_feed(i-5);
    matrixOut{i,11} = obj.normalized2010_finalEnergyPerCapita_i_spec(i-5);
    matrixOut{i,12} = obj.normalized2010_finalEnergyPerCapita_i_therm(i-5);
    matrixOut{i,13} = obj.normalized2010_finalEnergyPerCapita_rc_spec(i-5);
    matrixOut{i,14} = obj.normalized2010_finalEnergyPerCapita_rc_therm(i-5);
    matrixOut{i,15} = obj.normalized2010_finalEnergyPerCapita_transport(i-5);
    if length(obj.populationVector) == 13
        matrixOut{i,16} = obj.populationVector(i-5);
    end
end

xlswrite(['Output/' filename],matrixOut,[obj.scenarioName]);


end

