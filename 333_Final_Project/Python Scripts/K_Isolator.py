import textgrid
import csv
from fileorganize import dir_to_df
import numpy as np
import pandas as pd
from pathlib import Path 
from pydub import AudioSegment
import platform

def getContainingWord(phone_interval, word_tier):
    """
    This function takes a particular phone from the textgrid package and a tier of words, 
    returning the index of the word interval containing the phone. 
    The function returns an integer index of the word containing the specified phone

    :phone_interval: is a praat interval tier taken from the textgrid package containing your phones.
    :word_tier: is a praat interval tier taken from the textgrid package containing your words.
    """
    s, e = phone_interval.minTime, phone_interval.maxTime
    for j, outer_int in enumerate(word_tier):
        if outer_int.minTime <= s and e <= outer_int.maxTime:
            return j
    return None

def getIsolatedTokens(filepath, csvfilepath, tgout):
    tg = textgrid.TextGrid.fromFile(filepath)
    f = open(csvfilepath, 'w', newline = '')#Open csv file, create new if not available

    fieldname = ['phone', 'minTime', 'maxTime', 'k total', 'kw total', 'g total', 'gw total']
    dictWriter = csv.DictWriter(f, fieldnames=fieldname)
    dictWriter.writeheader()
    #Initialising variables
    vowels = 'ioaeuIOAEU'
    excludedTargets = ['i','o','a','e','u','I','O','A','E','U', 'spn', 'ng', 'n', 'm']
    kept_intervals = []
    targets = ['k', 'g', 'kw', 'gw', 'K', 'G']
    kTally = 0
    kwTally = 0
    gTally = 0
    gwTally = 0
    tgPhones = tg[3]
    tgWords = tg[2]


    for x in range(len(tgPhones)):
        currentMark = tg[3][x].mark
        if currentMark in targets:
            if str(tgPhones[x-1].mark) != "" and str(tgPhones[x+1].mark) != "": #If the strings arent empty, check if intervocalic
                if str(tgPhones[x-1].mark)[0] not in excludedTargets:
                    if str(tgPhones[x+1].mark)[0] in vowels:   
                        word_index = getContainingWord(tgPhones[x], tgWords)
                        print(tg[2][word_index])
                        if tg[3][x].minTime == tg[2][word_index].minTime:
                            print('proper ' + tgPhones[x].mark + ' found')  
                            kept_intervals.append(textgrid.Interval(tg[3][x].minTime, tg[3][x].maxTime, tg[3][x].mark)) # Add interval with intervocalic target
                            dictWriter.writerow({ # Save the phone, minTime, and maxTime of the interval
                                'phone': str(tgPhones[x].mark), 
                                'minTime': str(tgPhones[x].minTime), 
                                'maxTime': str(tgPhones[x].maxTime)
                            })
                            if currentMark in 'kK':
                                kTally += 1 
                            if currentMark == 'kw':
                                kwTally += 1
                            if currentMark in 'gG':
                                gTally += 1 
                            if currentMark == 'gw':
                                gwTally += 1
                        
    dictWriter.writerow({ # Save tally
        'k total' : kTally,
        'kw total' : kwTally,
        'g total' : gTally,
        'gw total' : gwTally 
    })

    new_tier = textgrid.IntervalTier(name='k isolation', minTime=tg[3].minTime, maxTime=tg[3].maxTime) # Create a new tier just for K
    for inter in kept_intervals: # Loop through adding the old set to this new tier
        new_tier.addInterval(inter)
    tg.append(new_tier)
    tg.write(tgout) # Write to a new file with updated output

    f.close()

#Original filepath, csv output, and new textgrid output
path_to_input = r"D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\SpiCE Textgrids"


tg_input_df = dir_to_df(path_to_input,
                    fnpat = ".TextGrid",
                    addcols = ["dirname", "barename", "ext"])
tg_input_df.head()
#tg_input_df["dirname"][0]
filepath = ""
csvfilepath = ""
tgout = ""
print(filepath)
print(csvfilepath)
print(tgout)

for n in range(len(tg_input_df)):
    filepath = str(str(tg_input_df["dirname"][n]) + "\\" + str(tg_input_df["barename"][n])[0:5] + "\\" + str(tg_input_df["fname"][n]))
    if "Cantonese" in filepath:
        csvfilepath = str(str(tg_input_df["dirname"][n]) + "\\" + str(tg_input_df["barename"][n])[0:5] + "\\" + str(tg_input_df["barename"][n])[0:5]) + "_C.csv"
        tgout = str(str(tg_input_df["dirname"][n]) + "\\" + str(tg_input_df["barename"][n])[0:5] + "\\" + str(tg_input_df["barename"][n])[0:5]) + "_C.Textgrid"
    elif "English" in filepath:
        csvfilepath = str(str(tg_input_df["dirname"][n]) + "\\" + str(tg_input_df["barename"][n])[0:5] + "\\" + str(tg_input_df["barename"][n])[0:5]) + "_E.csv"
        tgout = str(str(tg_input_df["dirname"][n]) + "\\" + str(tg_input_df["barename"][n])[0:5] + "\\" + str(tg_input_df["barename"][n])[0:5]) + "_E.Textgrid"
    getIsolatedTokens(filepath, csvfilepath, tgout)
