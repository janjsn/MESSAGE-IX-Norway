function [ HydroData ] = importHydropowerData( )
%IMPORTHYDROPOWERDATA Summary of this function goes here
%   Detailed explanation goes here

[num,txt,raw] = xlsread('Vannkraftverk.csv');

HydroData = HydropowerCapacities;

HydroData.raw_data_matrix = raw;
mSize = size(raw);

yearsBounds = [1900:5:2015
    1905:5:2020];
mSize_yearsBounds = size(yearsBounds);
col_capacity = 12;
col_meanProduction = 13;
col_year = 11;
col_type = 3;

capacityVector = zeros(1,mSize_yearsBounds(2));
meanProductionVector = zeros(1,mSize_yearsBounds(2));
c=0;
c1=0;
for row = 4:mSize(1)
    if strcmp(raw{row,col_type},'Kraftverk') ==  1
        identified = 1;
    elseif strcmp(raw{row,col_type},'Pumpekraftverk') == 1
        identified = 1;
    else
        identified = 0;
    end
    
    if identified == 1
        %find years bounds position
        c1=c1+1;
        
        for i = 1:mSize_yearsBounds(2)
            year_this_string = raw{row,col_year};
            year_this = 10000*str2double(year_this_string(end-4:end));
            year_this = floor(year_this);
            
            
            
            if ~isnan(year_this)
                if yearsBounds(1,i) <= year_this
                    if yearsBounds(2,i) > year_this
                        c=c+1;
                        %raw{row,col_capacity}
                        if ~isnan(raw{row,col_capacity})
                            %raw{row,col_capacity}
                            capacity2add = raw{row,col_capacity};
                            %capacity2add
                        else
                            capacity2add = 0;
                        end
                        if ~isnan(raw{row,col_meanProduction})
                            meanProd2add = raw{row,col_meanProduction};
                        else
                            meanProd2add = 0;
                        end
                        capacityVector(i) = capacityVector(i)+ capacity2add;
                        meanProductionVector(i) = meanProductionVector(i)+meanProd2add;
                        %break
                    end
                end
            end
        end
        
    end
    
end
HydroData.yearBounds = yearsBounds;
HydroData.capacityVector = capacityVector;
HydroData.meanProductionVector = meanProductionVector;

end

