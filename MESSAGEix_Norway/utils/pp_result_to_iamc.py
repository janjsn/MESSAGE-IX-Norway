import pandas as pd
from itertools import product
import ixmp
import message_ix
import os


def create_timeseries(data, name, model, scenario, region, unit, groupby):
    ts = data.groupby([groupby, 'year'], as_index=False).sum()
    ts = pd.pivot_table(ts, columns='year', values='lvl').reset_index(
        drop=True)
    ts['model'] = model
    ts['scenario'] = scenario
    ts['region'] = region
    ts['variable'] = name
    ts['unit'] = unit
    return ts


def results_to_iamc(model, scenario, region, database, l_year=2050, folder='results/' ):
    # Launch data base and load baseline
    mp = ixmp.Platform(dbprops=f'db/{database}', dbtype='HSQLDB')
    scen = message_ix.Scenario(mp, model=model, scenario=scenario)

    year = scen.set('year').astype(int)
    f_mod_year = scen.cat('year', 'firstmodelyear').astype(int)
    years = [year for year in year if(year >= f_mod_year) & (year <= int(l_year))]
    
    columns = ['model', 'scenario', 'region', 'variable', 'unit'] + years
    all_ts = pd.DataFrame(columns=columns)

    # retrieve data from scenarios
    ##################################
    # EMISSION DATA
    data = scen.var('EMISS', {'node': region, 'year': years}
                    ).drop(['type_tec', 'mrg'], axis=1)
    ts = create_timeseries(data, 'Emissions|GHG', model, scenario, region, 'MtCO2eq', 'node')
    all_ts = all_ts.append(ts, sort=True)

    # POWER SECTOR DATA
    act_dic = {'Electricity|Coal|w/o CCS': ['coal_adv', 'coal_ppl', 'igcc'],
               'Electricity|Coal|w/ CCS': ['coal_adv_ccs', 'igcc_ccs'],
               'Electricity|Gas|w/o CCS': ['gas_cc', 'gas_ct', 'gas_ppl'],
               'Electricity|Gas|w/ CCS': ['gas_cc_ccs'],
               'Electricity|Oil|w/o CCS': ['foil_ppl', 'loil_ppl'],
               'Electricity|Import': ['elec_imp'],
               'Electricity|Wind': ['wind_ppl'],
               'Electricity|Solar': ['solar_th_ppl_base', 'solar_th_ppl', 'solar_pv_ppl'],
               'Electricity|Hydro': ['hydro_ppl'],
               'Electricity|Nuclear': ['nuc_ppl']}

    for k, t in act_dic.items():
        data = scen.var('ACT', {'node_loc': region,
                                'year_act': years, 'technology': t})
        data = data.rename(columns={'year_act': 'year'})
        ts = create_timeseries(data, f'Secondary Energy|{k}', model, scenario, region, 'GWa', 'node_loc')
        all_ts = all_ts.append(ts, sort=True)

        data = scen.var('CAP', {'node_loc': region,
                                'year_vtg': years, 'technology': t})
        data = data.rename(columns={'year_vtg': 'year'})
        ts = create_timeseries(data, f'Capacity|{k}', model, scenario, region, 'GW', 'node_loc')
        all_ts = all_ts.append(ts, sort=True)

    # ENERGY USE DATA
    act_dic = {'shale_extr': 'shale_extr', 'coal_extr': 'coal_extr',
               'all_extr': ['shale_extr', 'coal_extr', 'gas_extr',
                            'oil_extr'],
               'all_imp': ['coal_imp', 'gas_imp', 'oil_imp',
                           'loil_imp', 'foil_imp', 'elec_imp'],
               'all_exp': ['coal_exp', 'gas_exp', 'oil_exp', 'loil_exp',
                           'foil_exp', 'elec_exp'],
               'renewable_energy': ['solar_th_ppl_base', 'solar_i',
                                    'bio_extr', 'solar_rc', 'wind_ppl',
                                    'solar_pv_ppl', 'hydro_ppl',
                                    'solar_th_ppl']}

    for k, t in act_dic.items():
        data = scen.var('ACT', {'node_loc': region,
                                'year_act': years, 'technology': t})
        data = data.rename(columns={'year_act': 'year'})
        ts = create_timeseries(data, f'Activity|{k}', model, scenario, region, 'GWa', 'node_loc')
        all_ts = all_ts.append(ts, sort=True)

    all_ts = all_ts[columns]

    if not os.path.exists(folder):
        os.makedirs(folder)

    all_ts.to_excel(folder+'timeseries_%s.xlsx' % scenario)
