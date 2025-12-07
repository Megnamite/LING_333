'''
Docstring for 333_Final_Project.Python Scripts.ManualDataTabulation
Compile manually measured data into a singular CSV.
'''


import os
import textgrid
import pandas as pd


FOLDER = r"D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\manual textgrids"    # folder containing all .TextGrid files
TOKEN_TIER = "k isolation"      # tier where lexical tokens (k, g, kw, gw…) appear
VOT_TIER = "vot"         # tier that contains VOT intervals

# tokens of interest -> output file names
TARGET_TOKENS = {
    "k":      "k.csv",
    "g":      "g.csv",
    "kw":     "kw.csv",
    "gw":     "gw.csv",
    "K":      "K_english.csv",
    "G":      "G_english.csv"
}


results = {token: [] for token in TARGET_TOKENS}


def extract_speaker_id(filename):
    """Assumes filenames contain speaker IDs like VF19A, VM22A, etc."""
    base = os.path.basename(filename)
    return os.path.splitext(base)[0].split("_")[0]


def find_interval_containing(tier, time):
    """Return interval whose span contains a given time."""
    for interval in tier.intervals:
        if interval.minTime <= time <= interval.maxTime:
            return interval
    return None



# MAIN LOOP

for fname in os.listdir(FOLDER):
    if not fname.endswith(".TextGrid"):
        continue

    filepath = os.path.join(FOLDER, fname)
    tg = textgrid.TextGrid.fromFile(filepath)

    speaker = extract_speaker_id(fname)

    token_tier = tg.getFirst(TOKEN_TIER)
    vot_tier = tg.getFirst(VOT_TIER)

    # loop through all VOT intervals
    for interval in vot_tier.intervals:
        if not interval.mark or interval.mark.lower() != "vot":
            continue

        vot_start = interval.minTime
        vot_duration = round((interval.maxTime - interval.minTime)*1000)

        # find token active at VOT start
        token_interval = find_interval_containing(token_tier, vot_start)
        if token_interval is None:
            continue

        token = token_interval.mark.strip()

        # match only target tokens
        if token in TARGET_TOKENS:
            results[token].append({
                "speaker": speaker,
                "token": token,
                "VOT": vot_duration,
                "file": fname
            })

# SAVE OUTPUT FILES
for token, rows in results.items():
    df = pd.DataFrame(rows)
    output_name = TARGET_TOKENS[token]
    df.to_csv(output_name, index=False)
    print(f"Saved {output_name} with {len(rows)} rows")

print("Finished.")

