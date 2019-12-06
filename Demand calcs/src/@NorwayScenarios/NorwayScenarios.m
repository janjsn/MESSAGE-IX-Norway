classdef NorwayScenarios
    %NORWAYSCENARIOS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        scenarioName
        RCP_number
        time_vector
        populationVector
        Variables = Variable;
        
        demand_finalEnergy_GWa
        demand_finalEnergy_GWa_i_feed
        demand_finalEnergy_GWa_i_spec
        demand_finalEnergy_GWa_i_therm
        demand_finalEnergy_GWa_rc_spec
        demand_finalEnergy_GWa_rc_therm
        demand_finalEnergy_GWa_transport
        
        demand_finalEnergyPerCapita_GWaPerC
        demand_finalEnergyPerCapita_GWaPerC_i_feed
        demand_finalEnergyPerCapita_GWaPerC_i_spec
        demand_finalEnergyPerCapita_GWaPerC_i_therm
        demand_finalEnergyPerCapita_GWaPerC_rc_spec
        demand_finalEnergyPerCapita_GWaPerC_rc_therm
        demand_finalEnergyPerCapita_GWaPerC_transport
        
        normalized2010_finalEnergyPerCapita
        normalized2010_finalEnergyPerCapita_i_feed
        normalized2010_finalEnergyPerCapita_i_spec
        normalized2010_finalEnergyPerCapita_i_therm
        normalized2010_finalEnergyPerCapita_rc_spec
        normalized2010_finalEnergyPerCapita_rc_therm
        normalized2010_finalEnergyPerCapita_transport
        
        
    end
    
    methods
        function vector_out = interpolate_normalized_vectors(obj, vector_in, time_vector)
            binary_vectorIsLargerThanZero = vector_in > 0;
            vector_out = vector_in;
            for i = 1:length(vector_in)
                if vector_in(i) == 0
                   if i == 1
                        time_initial = time_vector(1);
                        c=1;
                        for j = 1:length(time_vector)
                           if binary_vectorIsLargerThanZero(j) == 1
                               if c==1
                               time_next = time_vector(j);
                               value_next = vector_in(j);
                               c=c+1;
                               elseif c == 2
                                   time_last = time_vector(j);
                                   value_last = time_vector(j);
                                   break
                               end
                           end
                        end %for j
                        stigningstall = (value_last - value_next)/(time_last-time_next);
                        vector_out(i) = value_next - (time_next-time_initial)*stigningstall;
                        vector_in(i) = vector_out(i);
                        
                   elseif i == length(vector_in)
                       time_initial = time_vector(i);
                       c=1;
                       for j = length(time_vector):-1:1
                          if binary_vectorIsLargerThanZero(j) == 1 
                              if c==1
                               time_next = time_vector(j);
                               value_next = vector_in(j);
                               c=c+1;
                               elseif c == 2
                                   time_last = time_vector(j);
                                   value_last = time_vector(j);
                                   break
                               end
                              stigningstall = (value_next - value_last)/(time_next-time_last);
                              vector_out(i) = value_next + (time_initial-time_next)*stigningstall;
                              vector_in(i) = vector_out(i);
                          end
                       end
                       
                   else
                       time_initial = time_vector(i);
                       %finding lower value
                       for j = i:-1:1
                           if binary_vectorIsLargerThanZero(j) == 1
                              lower_value = vector_in(j);
                              lower_time = time_vector(j);
                              break
                           end
                       end
                       %finding higher value
                       for j = i:1:length(time_vector)
                           if binary_vectorIsLargerThanZero(j) == 1
                              higher_value = vector_in(j);
                              higher_time = time_vector(j);
                              break
                           end
                       end
                       stigningstall = (higher_value-lower_value)/(higher_time-lower_time);
                       vector_out(i) = lower_value+stigningstall*(time_initial-lower_time);
                       vector_in(i) = vector_out(i);
                   end %if
                    
                end %if vector_in(i) == 0
            end %for
            
        end
        
        export2xls(obj, filename )
        
    end
    
end

