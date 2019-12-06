function DataArray = importFromXls( filename, sheetname )
%IMPORTFROMXLS Summary of this function goes here
%   Detailed explanation goes here

%Define:
n_scenarios = 6;

%Import from xls
[num, txt, raw] = xlsread(filename, sheetname);


mSize = size(raw);

%Define where to find what data, columns
regionCol = 1;
modelCol = 2;
variableCol = 3;
unitCol = 4;
dataVector_cols = [5,15];



DataArray(1:2) = Data;
DataArray(1).region = raw{2,1};
DataArray(1).model_scenario = raw{3,1};
DataArray(1).time_vector = [raw{1,5:15}];

%Getting scenario names, hardcoded!!!
DataArray(1).Scenarios(1:n_scenarios) = Scenario;
DataArray(1).Scenarios(1).scenarioName = raw{7,2};
DataArray(1).Scenarios(2).scenarioName = raw{6,2};
DataArray(1).Scenarios(3).scenarioName = raw{5,2};
DataArray(1).Scenarios(4).scenarioName = raw{4,2};
DataArray(1).Scenarios(5).scenarioName = raw{3,2};
DataArray(1).Scenarios(6).scenarioName = raw{2,2};

for i = 1:length(DataArray(1).Scenarios)
   rcp_n = str2double(DataArray(1).Scenarios(i).scenarioName(end-1:end));
   if ~isempty(rcp_n)
       DataArray(1).Scenarios(i).RCP_number = rcp_n;
   else
       DataArray(1).Scenarios(i).RCP_number = 0;
   end
end

%% Import data, OECD
c_vars=1; %counter
previous_variable = raw{2,variableCol}; %preset
%Loop and get data from matrix
for row = 2:mSize(1)
    for col = regionCol:dataVector_cols(2)
        %get variable name
        current_variable = raw{row,variableCol};
        %check if its new (only against previous variable)
        if ~strcmp(current_variable,previous_variable)
            c_vars=c_vars+1;
        end
        %check what scenario
        if ischar(raw{row,1}) 
            current_scenario = 0;
            for scens = 1:n_scenarios
               if strcmp(raw{row,modelCol}, DataArray(1).Scenarios(scens).scenarioName)
                  current_scenario = scens; 
               end
            end
            if current_scenario == 0
               error('Could not find scenario'); 
            end
            
            %import
            DataArray(1).Scenarios(current_scenario).Variables(c_vars).name = raw{row,variableCol};
            DataArray(1).Scenarios(current_scenario).Variables(c_vars).unit = raw{row,unitCol};
            DataArray(1).Scenarios(current_scenario).Variables(c_vars).data_vector = [raw{row,dataVector_cols(1):dataVector_cols(2)}];
            DataArray(1).Scenarios(current_scenario).Variables(c_vars).time_vector = DataArray(1).time_vector;
            if strcmp(current_variable, 'Population')
                DataArray(1).Scenarios(current_scenario).population_vector = [raw{row,dataVector_cols(1):dataVector_cols(2)}];
                DataArray(1).Scenarios(current_scenario).time_vector = DataArray(1).Scenarios(current_scenario).Variables(c_vars).time_vector;
            end
            
            previous_variable = current_variable;
            
        end
    end
end

%% IMPORT DATA NORWAY
DataArray(2).region = raw{2,17};

%counting scenarios
scenario_nor_array = cell(1);
c=1;
for i = 2:mSize(1)
    if ~isnan(raw{i,18})
        if ischar(raw{i,18})
            scenario_nor_array{c} = raw{i,18};
            c=c+1;
        end
    end
    
end
uniqueScenarios = unique(scenario_nor_array);
n_scenarios = length(uniqueScenarios);
DataArray(2).Scenarios(1:n_scenarios) = Scenario;
DataArray(2).time_vector = [raw{1,21:40}];

for i = 1:n_scenarios
   DataArray(2).Scenarios(i).scenarioName = uniqueScenarios{i};
end


%Adding data
c_vector(1:n_scenarios) = 1;%position counter

for row = 1:mSize(1)
    if ischar(raw{row,18})
        %find right scenario
        for scen = 1:n_scenarios
            if strcmp(DataArray(2).Scenarios(scen).scenarioName, raw{row,18})
                DataArray(2).Scenarios(scen).Variables(c_vector(scen)).data_vector = [raw{row,21:40}];
                DataArray(2).Scenarios(scen).Variables(c_vector(scen)).unit = raw{row,20};
                DataArray(2).Scenarios(scen).Variables(c_vector(scen)).name = raw{row,19};
                DataArray(2).Scenarios(scen).Variables(c_vector(scen)).time_vector = DataArray(2).time_vector;
                DataArray(2).Scenarios(scen).RCP_number = str2double(DataArray(2).Scenarios(scen).scenarioName(end-1:end));
                
                if strcmp(DataArray(2).Scenarios(scen).Variables(c_vector(scen)).name, 'Population')
                    DataArray(2).Scenarios(scen).population_vector = DataArray(2).Scenarios(scen).Variables(c_vector(scen)).data_vector;
                    DataArray(2).Scenarios(scen).time_vector = DataArray(2).Scenarios(scen).Variables(c_vector(scen)).time_vector;
                end
                
                c_vector(scen) = c_vector(scen)+1;
                
            end
        end
    end
end
%DataArray(1:2) = Data;
%DataArray(1).region = raw{2,1};
%DataArray(1).model_scenario = raw{3,1};
%DataArray(1).time_vector = [raw{1,5:15}];

end

