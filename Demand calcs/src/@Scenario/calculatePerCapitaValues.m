function [ obj ] = calculatePerCapitaValues( obj )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

populationVector = obj.population_vector;

for i = 1:length(obj.Variables)
    if length(obj.Variables(i).data_vector) == length(populationVector)
        obj.Variables(i).perCapita = obj.Variables(i).data_vector./populationVector;
    end
end

pos=0;
for i = 1:length(obj.time_vector)
   if obj.time_vector(i) == 2010
      pos = i; 
   end
end

for i = 1:length(obj.Variables)
    obj.Variables(i).data_vector_normalizedFrom2010 = obj.Variables(i).data_vector/obj.Variables(i).data_vector(pos);
    obj.Variables(i).perCapitaVector_normalizedFrom2010 = obj.Variables(i).perCapita/obj.Variables(i).perCapita(pos);
end

end

