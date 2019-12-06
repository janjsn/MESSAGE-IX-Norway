addpath(genpath(pwd()));
DataArray = importFromXls('Energibalanse.xlsx','Data_various');
[ HydroData ] = importHydropowerData( );


%Find OECD and NOR pos
oecd_pos = 0;
for regions = 1:length(DataArray)
   if  strcmp(DataArray(regions).region,'R5.2OECD')
       oecd_pos = regions;
   elseif strcmp(DataArray(regions).region,'NOR')
       nor_pos = regions;
   end 
end

if oecd_pos == 0 || nor_pos == 0
    error('Could not find region positions in array')
end



%% Estimate values per capita
for regions = 1:length(DataArray)
    for scenarios = 1:length(DataArray(regions).Scenarios)
        DataArray(regions).Scenarios(scenarios) = DataArray(regions).Scenarios(scenarios).calculatePerCapitaValues;
    end
end

ssp2_base_pos=0;

NorwayScenarios = generateNorwayScenarios(DataArray(oecd_pos).Scenarios);




clear('regions','nor_pos','oecd_pos')

