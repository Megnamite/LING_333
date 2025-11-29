import textgrid
import csv
from fileorganize import dir_to_df
import numpy as np
import pandas as pd
from pathlib import Path 
from pydub import AudioSegment
import platform
import os

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

def splitAudio(filepath, minTime, maxTime, outputpath = None, makeMono = None, selectMonoChannel = None):
    """
    Function takes a segment of a larger audio file and extracts it, 
    returning an audio file unless output path is explicitly set

    :filepath: specifies the input file.
    :minTime: specifies the start of the clip you want to extract in s.
    :maxTime: specifies the end of the clip you want to extract in s.
    :outputpath: optional argument that specifies where the output should be saved to.
    :makeMono: integer that decides whether or not the file should be exported as mono or stay as stereo, set to 1 if you want mono
    :selectMonoChannel: Decides the mono channel, 0 = left, 1 = right.
    """
    audio = AudioSegment.from_file(filepath)

    #convert time from s to ms
    minTime = minTime * 1000
    maxTime = maxTime * 1000

    # Safety checks
    if minTime < 0:
        raise ValueError("minTime cannot be negative.")
    if maxTime > len(audio):
        raise ValueError("maxTime exceeds audio length.")
    if minTime >= maxTime:
        raise ValueError("minTime must be less than maxTime.")
    
    extracted = audio[minTime-30:maxTime+30] # Chodroff and wilson 2017

    if makeMono == 1:
        extracted = extracted.split_to_mono()
    
    if outputpath:
        extracted = extracted[selectMonoChannel]
        extracted.export(outputpath, format=outputpath.split('.')[-1])
        return None

    return extracted


path_to_input = Path(r'D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project')
audio_input_df = dir_to_df(path_to_input,
                    fnpat= r".wav",
                    addcols = ["dirname", "barename", "ext"])
    
tg_input_df = dir_to_df(path_to_input,
                    fnpat= ".Textgrid",
                    addcols = ["dirname", "barename", "ext"])

audio_input_df.tail() # Get Dataframe of all files in directory
tg_input_df.head()
#eng_input_df.head()

print(audio_input_df["barename"][5])

for n in range(len(tg_input_df)):
    audioInputFile = str(audio_input_df["dirname"][n]) + "\\" + 'SpiCE Textgrids\\' + str(audio_input_df["barename"][n])[0:5] + "\\" + str(audio_input_df["fname"][n])
    audio_clip_file = str(audio_input_df["dirname"][n]) + "\\" + 'SpiCE Textgrids\\' + str(audio_input_df["barename"][n])[0:5]
    print('importing audio from ' + audioInputFile)
                                                                    
    tgin = str(tg_input_df["dirname"][n]) + "\\" + 'SpiCE Textgrids\\' + str(audio_input_df["barename"][n])[0:5] + "\\"  + str(tg_input_df["fname"][n])
    print('importing tg from ' + tgin)
    
    tg = textgrid.TextGrid.fromFile(tgin)
    tgIsolatedPhones = tg[4]
    tgWords = tg[2]
    print(tgIsolatedPhones)

    targets = ['k', 'g', 'kw', 'gw', 'K', 'G']

    print('starting loop')

    counter = 0
    for x in range(len(tg[4])):
        if tgIsolatedPhones[x].mark in targets:
            idx = getContainingWord(tgIsolatedPhones[x], tgWords)
            if "_C" in audio_input_df["barename"][n]:
                outputpath = f"{audio_clip_file}\\{str(audio_input_df['barename'][n])[0:5]}_C"
                
                if not os.path.isdir(outputpath):
                    os.makedirs(outputpath)
                    
                outputfile = f"{outputpath}\\{str(audio_input_df['barename'][n])[0:5]}_C_clip({counter}).wav"
                
            elif "_E" in audio_input_df["barename"][n]:
                outputpath = f"{audio_clip_file}\\{str(audio_input_df['barename'][n])[0:5]}_E"
                
                if not os.path.isdir(outputpath):
                    os.makedirs(outputpath)
                    
                outputfile = f"{outputpath}\\{str(audio_input_df['barename'][n])[0:5]}_E_clip({counter}).wav"    
            else:
                print('somethings gone wrong with the input files')
                break       
            print("Splitting Audio")
            segment = splitAudio(str(audioInputFile), 
                    tgWords[idx].minTime, 
                    tgWords[idx].maxTime,
                    outputfile,
                    1, 0)
            counter += 1
print('Done splitting audio!')