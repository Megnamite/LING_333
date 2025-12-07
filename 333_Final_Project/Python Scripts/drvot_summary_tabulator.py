'''
Docstring for 333_Final_Project.Python Scripts.drvot_summary_tabulator
File Name: drvot_summary_tabulator.py
Last Updated: 5/12/2025
Description: Creates a lookup table to transfer dr.vot's summary.csv to a more readable format for data sanitation
'''
import textgrid
import pandas as pd
import re
from pathlib import Path
from fileorganize import dir_to_df   

# Input paths
base_path = Path(r"D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\SpiCE Textgrids")
path_to_tg_input = base_path / "out_tg"
path_to_csv_input = base_path


# create pandas dataframes
out_tg_input = dir_to_df(path_to_tg_input, fnpat=".TextGrid", addcols=["dirname", "barename", "ext"])
can_csv_input = dir_to_df(path_to_csv_input, fnpat="_C.csv", addcols=["dirname", "barename", "ext"])
eng_csv_input = dir_to_df(path_to_csv_input, fnpat="_E.csv", addcols=["dirname", "barename", "ext"])


# Seperate strings into speaker code, language, and clip number
def parse_tg_name(basename):
    """
    Input: 'VF19A_C_clip(23)_predPOS'
    Output: ('VF19A', 'C', 23)
    """
    parts = basename.split("_")
    speaker = parts[0]        # VF19A
    lang = parts[1]           # C or E

    m = re.search(r"clip\((\d+)\)", basename)
    clip = int(m.group(1))

    return speaker, lang, clip



# Make lookup table for CSV files

def build_csv_lookup(df):
    lookup = {}
    for _, row in df.iterrows():
        base = row["barename"]         #speaker code
        speaker, lang = base.split("_") 
        csv_path = Path(row["dirname"]) / row["relpath"] / row["fname"]
        lookup[(speaker, lang)] = csv_path
    return lookup

csv_lookup_C = build_csv_lookup(can_csv_input)
csv_lookup_E = build_csv_lookup(eng_csv_input)



# Process all TextGrids
results = []

for _, row in out_tg_input.iterrows(): 
    basename = row["barename"]
    speaker, lang, clip = parse_tg_name(basename)

    tg_path = Path(row["dirname"]) / row["relpath"] / row["fname"]
    tg = textgrid.TextGrid.fromFile(str(tg_path))

    # Compute VOT
    vot_ms = (tg[1][1].maxTime - tg[1][1].minTime) * 1000

    # Load correct csv based on lookup table
    if lang == "C":
        df_phone = pd.read_csv(csv_lookup_C[(speaker, "C")])
    else:
        df_phone = pd.read_csv(csv_lookup_E[(speaker, "E")])

    phone = df_phone.loc[clip, "phone"]
    
    results.append({ # Write data to output CSV
        "speaker": speaker,
        "language": lang,
        "clip": clip,
        "phone": phone,
        "vot_ms": vot_ms
    })

# Create CSVs for each speaker
df_all = pd.DataFrame(results)

for speaker, group in df_all.groupby("speaker"): 
    out_path = base_path / speaker / f"{speaker}_vot.csv"
    group.to_csv(out_path, index=False)
    print(f"Saved to {out_path}")
