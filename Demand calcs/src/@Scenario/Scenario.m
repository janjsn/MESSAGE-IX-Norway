classdef Scenario
    %MITIGATIONSCENARIO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        scenarioName
        RCP_number
        Variables = Variable;
        population_vector
        time_vector
    end
    
    methods
        [ obj ] = calculatePerCapitaValues( obj )
    end
    
end

