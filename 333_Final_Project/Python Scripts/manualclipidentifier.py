import os
from textgrid import TextGrid
import pandas as pd

# Directory containing TextGrid files
tg_dir = r"D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\manual textgrids"

# Tokens we care about for clipNo counting
tokens_set = {"k", "kw", "g", "gw", "G", "K"}

# List to store results
speakers = []
tokens = []
clipNo = []
votms = []
lang = []
# Loop through each TextGrid file
for tg_file in os.listdir(tg_dir):
    if tg_file.endswith(".TextGrid"):
        tg_path = os.path.join(tg_dir, tg_file)
        tg = TextGrid.fromFile(tg_path)
        
        speaker = os.path.splitext(tg_file)[0]  # file basename
        if "_C" in speaker:
            language = "C"
        if "_E" in speaker:
            language = "E"
        
        # Get the "k isolated" tier
        k_tier = next((tier for tier in tg.tiers if tier.name.lower() == "k isolation"), None)
        # Get the "vot" tier (assume lower tier)
        vot_tier = next((tier for tier in tg.tiers if tier.name.lower() == "vot"), None)
        
        count = 0  # clipNo counter
        
        for k_interval in k_tier.intervals:
            if k_interval.mark in tokens_set:
                count += 1  # increment clipNo

                # Find any VOT interval that falls within this token
                vot_interval = None
                for v in vot_tier.intervals:
                    # Check if vot start is within token interval
                    if k_interval.minTime<= v.minTime <= k_interval.maxTime:
                        vot_interval = v
                        break
                
                if vot_interval:
                    vot = round((vot_interval.maxTime - vot_interval.minTime) * 1000)

                    speakers.append(speaker[0:5])
                    tokens.append(k_interval.mark)
                    clipNo.append(count)
                    votms.append(vot)
                    lang.append(language)

data = {
    "speaker" : speakers,
    "language" : lang,
    "phone" : tokens,
    "clip number" : clipNo,
    "vot_ms" : votms
}

df = pd.DataFrame(data)
df.to_csv('manual presanitise with clips.csv')
