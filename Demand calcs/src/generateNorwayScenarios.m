function [ Norway_scenarioArray ] = generateNorwayScenarios( DataArray_SSP_RCP_scenarios )
%GENERATENORWAYSCENARIOS Summary of this function goes here
%   Detailed explanation goes here

n_scenarios = length(DataArray_SSP_RCP_scenarios);

Norway_scenarioArray(1:n_scenarios) = NorwayScenarios;

region = 'Norway';

%% Baseline info pre 2020
% demand_finalEnergy_2010_GWh_i_spec = 44525;
% demand_finalEnergy_2010_GWh_i_therm = 28524;
% demand_finalEnergy_2010_GWh_rc_spec = 68477;
% demand_finalEnergy_2010_GWh_rc_therm = 24945;
% demand_finalEnergy_2010_GWh_transport = 54910;
% 
% demand_finalEnergy_2015_GWh_i_spec = 45013;
% demand_finalEnergy_2015_GWh_i_therm = 25451;
% demand_finalEnergy_2015_GWh_rc_spec = 65887;
% demand_finalEnergy_2015_GWh_rc_therm = 18576;
% demand_finalEnergy_2015_GWh_transport = 53769;

demand_finalEnergy_2010_GWh_i_feed = 21874;
demand_finalEnergy_2010_GWh_i_spec = 44525;
demand_finalEnergy_2010_GWh_i_therm = 6650;
demand_finalEnergy_2010_GWh_rc_spec = 68477;
demand_finalEnergy_2010_GWh_rc_therm = 24945;
demand_finalEnergy_2010_GWh_transport = 54910;

demand_finalEnergy_2015_GWh_i_feed = 20946;
demand_finalEnergy_2015_GWh_i_spec = 45013;
demand_finalEnergy_2015_GWh_i_therm = 4505;
demand_finalEnergy_2015_GWh_rc_spec = 65887;
demand_finalEnergy_2015_GWh_rc_therm = 18576;
demand_finalEnergy_2015_GWh_transport = 53769;

timeVector_population = [2005:5:2100];
populationVector = [4.623	4.858	5.166	5.37	5.55	5.74	5.91	6.06	6.19	6.3	6.41	6.51	6.61	6.71	6.81	6.92	7.01	7.1	7.19	7.29]*10^6;
populationVector_normalized_2010 = populationVector/populationVector(2);

for i = 1:n_scenarios
    n_variables = length(DataArray_SSP_RCP_scenarios(i).Variables);
    Norway_scenarioArray(i).Variables(1:n_variables) = Variable;
    Norway_scenarioArray(i).time_vector = [2010:5:2070];
    n_years = length(Norway_scenarioArray(i).time_vector);
    
    Norway_scenarioArray(i).scenarioName = DataArray_SSP_RCP_scenarios(i).scenarioName;
    Norway_scenarioArray(i).RCP_number = DataArray_SSP_RCP_scenarios(i).RCP_number;
    
    
%     for j = 1:n_variables
%         Norway_scenarioArray(i).Variables(j).name = DataArray_SSP_RCP_scenarios(i).Variables(j).name;
%         Norway_scenarioArray(i).Variables(j).unit = DataArray_SSP_RCP_scenarios(i).Variables(j).unit;
%         Norway_scenarioArray(i).Variables(j).data_vector = zeros(1,n_years);
%         Norway_scenarioArray(i).Variables(j).time_vector = Norway_scenarioArray(i).time_vector;
%         
%     end
    

%find baseline oecd ssp2
    
    for j = 1:length(DataArray_SSP_RCP_scenarios(i).Variables)
        if strcmp(DataArray_SSP_RCP_scenarios(i).Variables(j).name ,'Final Energy') == 1
            ssp2_base_finalEnergy_pos = j;
            finalEnergyPerCapita_normalized2010 = zeros(1,n_years);
            for k = 1:n_years
                currentYear = Norway_scenarioArray(i).time_vector(k);
                for time_var = 1:length(DataArray_SSP_RCP_scenarios(i).Variables(j).time_vector)
                    if DataArray_SSP_RCP_scenarios(i).Variables(j).time_vector(time_var) == currentYear
                        finalEnergyPerCapita_normalized2010(k) = DataArray_SSP_RCP_scenarios(i).Variables(j).perCapitaVector_normalizedFrom2010(time_var);
                    end
                    
                    %finalEnergyPerCapita_normalized2010
                end
            end
            %finalEnergyPerCapita_normalized2010 = DataArray_SSP_RCP_scenarios(i).Variables(j).perCapitaVector_normalizedFrom2010;
            
        end
        if strcmp(DataArray_SSP_RCP_scenarios(i).Variables(j).name ,'Final Energy|Transportation') == 1
            finalEnergy_transport_PerCapita_normalized2010 = zeros(1,n_years);
            for k = 1:n_years
                currentYear = Norway_scenarioArray(i).time_vector(k);
                for time_var = 1:length(DataArray_SSP_RCP_scenarios(i).Variables(j).time_vector)
                    if DataArray_SSP_RCP_scenarios(i).Variables(j).time_vector(time_var) == currentYear
                        finalEnergy_transport_PerCapita_normalized2010(k) = DataArray_SSP_RCP_scenarios(i).Variables(j).perCapitaVector_normalizedFrom2010(time_var);
                    end
                    
                    %finalEnergyPerCapita_normalized2010
                end
            end
        end
        if strcmp(DataArray_SSP_RCP_scenarios(i).Variables(j).name ,'Final Energy|Residential and Commercial') == 1
            finalEnergy_rc_PerCapita_normalized2010 = zeros(1,n_years);
            for k = 1:n_years
                currentYear = Norway_scenarioArray(i).time_vector(k);
                for time_var = 1:length(DataArray_SSP_RCP_scenarios(i).Variables(j).time_vector)
                    if DataArray_SSP_RCP_scenarios(i).Variables(j).time_vector(time_var) == currentYear
                        finalEnergy_rc_PerCapita_normalized2010(k) = DataArray_SSP_RCP_scenarios(i).Variables(j).perCapitaVector_normalizedFrom2010(time_var);
                    end
                    
                    %finalEnergyPerCapita_normalized2010
                end
            end
        end
        if strcmp(DataArray_SSP_RCP_scenarios(i).Variables(j).name ,'Final Energy|Industry') == 1
            finalEnergy_i_PerCapita_normalized2010 = zeros(1,n_years);
            for k = 1:n_years
                currentYear = Norway_scenarioArray(i).time_vector(k);
                for time_var = 1:length(DataArray_SSP_RCP_scenarios(i).Variables(j).time_vector)
                    if DataArray_SSP_RCP_scenarios(i).Variables(j).time_vector(time_var) == currentYear
                        finalEnergy_i_PerCapita_normalized2010(k) = DataArray_SSP_RCP_scenarios(i).Variables(j).perCapitaVector_normalizedFrom2010(time_var);
                    end
                    
                    %finalEnergyPerCapita_normalized2010
                end
            end
        end
    end
        Norway_scenarioArray(i).demand_finalEnergy_GWa_i_feed = zeros(1,n_years);
    Norway_scenarioArray(i).demand_finalEnergy_GWa_i_spec(1:2) = [demand_finalEnergy_2010_GWh_i_spec demand_finalEnergy_2015_GWh_i_spec]/8760;
    Norway_scenarioArray(i).demand_finalEnergy_GWa_i_therm(1:2) = [demand_finalEnergy_2010_GWh_i_therm demand_finalEnergy_2015_GWh_i_therm]/8760;
    Norway_scenarioArray(i).demand_finalEnergy_GWa_rc_spec(1:2) = [demand_finalEnergy_2010_GWh_rc_spec demand_finalEnergy_2015_GWh_rc_spec]/8760;
    Norway_scenarioArray(i).demand_finalEnergy_GWa_rc_therm(1:2) = [demand_finalEnergy_2010_GWh_rc_therm demand_finalEnergy_2015_GWh_rc_therm]/8760;
    Norway_scenarioArray(i).demand_finalEnergy_GWa_transport(1:2) = [demand_finalEnergy_2010_GWh_transport demand_finalEnergy_2015_GWh_transport]/8760;
    Norway_scenarioArray(i).demand_finalEnergy_GWa_i_feed(1:2) = [demand_finalEnergy_2010_GWh_i_feed demand_finalEnergy_2015_GWh_i_feed]/8760;
   
    
    demand_i = (demand_finalEnergy_2015_GWh_i_spec+demand_finalEnergy_2015_GWh_i_therm+demand_finalEnergy_2015_GWh_i_feed)/8760;
    demand_rc = (demand_finalEnergy_2015_GWh_rc_spec+demand_finalEnergy_2015_GWh_rc_therm)/8760;
    demand_transport = (demand_finalEnergy_2010_GWh_transport)/8760;
    
    share_i_feed = demand_finalEnergy_2015_GWh_i_feed/(demand_i);
    share_i_spec = demand_finalEnergy_2015_GWh_i_spec/(demand_i);
    share_i_therm = demand_finalEnergy_2015_GWh_i_therm/demand_i;
    share_rc_spec = demand_finalEnergy_2015_GWh_rc_spec/demand_rc;
    share_rc_therm = demand_finalEnergy_2015_GWh_rc_therm/demand_rc;
    share_transport = demand_transport/demand_transport;
    
    %get data
    Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita = finalEnergyPerCapita_normalized2010;
    Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_i_feed = finalEnergy_i_PerCapita_normalized2010;
    Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_i_spec = finalEnergy_i_PerCapita_normalized2010;
    Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_i_therm = finalEnergy_i_PerCapita_normalized2010;
    Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_rc_spec = finalEnergy_rc_PerCapita_normalized2010;
    Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_rc_therm = finalEnergy_rc_PerCapita_normalized2010;
    %interpolate
    Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_transport = finalEnergy_transport_PerCapita_normalized2010*share_transport;
    Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita = Norway_scenarioArray(i).interpolate_normalized_vectors(Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita, Norway_scenarioArray(i).time_vector);
   Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_i_feed = Norway_scenarioArray(i).interpolate_normalized_vectors(Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_i_feed, Norway_scenarioArray(i).time_vector);
   Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_i_spec = Norway_scenarioArray(i).interpolate_normalized_vectors(Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_i_spec, Norway_scenarioArray(i).time_vector);
   Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_i_therm = Norway_scenarioArray(i).interpolate_normalized_vectors(Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_i_therm, Norway_scenarioArray(i).time_vector);
   Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_rc_spec = Norway_scenarioArray(i).interpolate_normalized_vectors(Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_rc_spec, Norway_scenarioArray(i).time_vector);
   Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_rc_therm = Norway_scenarioArray(i).interpolate_normalized_vectors(Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_rc_therm, Norway_scenarioArray(i).time_vector);
   Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_transport = Norway_scenarioArray(i).interpolate_normalized_vectors(Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_transport, Norway_scenarioArray(i).time_vector);
   
   %Estimate GWa
   for yr = 3:n_years
      Norway_scenarioArray(i).demand_finalEnergy_GWa_i_spec(yr) =  Norway_scenarioArray(i).demand_finalEnergy_GWa_i_spec(1)*Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_i_spec(yr)*populationVector_normalized_2010(yr);
      Norway_scenarioArray(i).demand_finalEnergy_GWa_i_therm(yr) =  Norway_scenarioArray(i).demand_finalEnergy_GWa_i_therm(1)*Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_i_therm(yr)*populationVector_normalized_2010(yr);
      Norway_scenarioArray(i).demand_finalEnergy_GWa_i_feed(yr) =  Norway_scenarioArray(i).demand_finalEnergy_GWa_i_feed(1)*Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_i_feed(yr)*populationVector_normalized_2010(yr);
      Norway_scenarioArray(i).demand_finalEnergy_GWa_rc_spec(yr) =  Norway_scenarioArray(i).demand_finalEnergy_GWa_rc_spec(1)*Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_rc_spec(yr)*populationVector_normalized_2010(yr);
      Norway_scenarioArray(i).demand_finalEnergy_GWa_rc_therm(yr) =  Norway_scenarioArray(i).demand_finalEnergy_GWa_rc_therm(1)*Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_rc_therm(yr)*populationVector_normalized_2010(yr);
      Norway_scenarioArray(i).demand_finalEnergy_GWa_transport(yr) =  Norway_scenarioArray(i).demand_finalEnergy_GWa_transport(1)*Norway_scenarioArray(i).normalized2010_finalEnergyPerCapita_transport(yr)*populationVector_normalized_2010(yr);
      
   end
   Norway_scenarioArray(i).demand_finalEnergy_GWa = Norway_scenarioArray(i).demand_finalEnergy_GWa_i_spec+Norway_scenarioArray(i).demand_finalEnergy_GWa_i_therm+Norway_scenarioArray(i).demand_finalEnergy_GWa_i_feed+Norway_scenarioArray(i).demand_finalEnergy_GWa_rc_spec+Norway_scenarioArray(i).demand_finalEnergy_GWa_rc_therm+Norway_scenarioArray(i).demand_finalEnergy_GWa_transport;
   Norway_scenarioArray(i).populationVector = populationVector(2:n_years+1);
   
end


   
    
    
%     for years = 3:n_years
%        Norway_scenarioArray(i).demand_finalEnergy_GWa_i_spec(years)
%         
%     end
    
end






