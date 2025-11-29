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

def splitAudio(filepath, minTime, maxTime, outputpath = None):
    """
    Function takes a segment of a larger audio file and extracts it, 
    returning an audio file unless output path is explicitly set

    :filepath: specifies the input file.
    :minTime: specifies the start of the clip you want to extract in s.
    :maxTime: specifies the end of the clip you want to extract in s.
    :outputpath: optional argument that specifies where the output should be saved to.
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
    
    extracted = audio[minTime:maxTime]

    if outputpath:
        extracted.export(outputpath, format=outputpath.split('.')[-1])
        return None

    return extracted


path_to_input = Path(r'C:\Users\Maria\Documents\UNI\Visual Studio UBC Workspace\LING333GithubClone\LING_333\333_Final_Project\SpiCE Textgrids')
canto_audio_input_df = dir_to_df(path_to_input,
                    fnpat= r"Cantonese.wav",
                    addcols = ["dirname", "barename", "ext"])

eng_audio_input_df = dir_to_df(path_to_input,
                    fnpat= r"English.wav",
                    addcols = ["dirname", "barename", "ext"])

canto_input_df = dir_to_df(path_to_input,
                    fnpat= "Cantonese.Textgrid",
                    addcols = ["dirname", "barename", "ext"])

eng_input_df = dir_to_df(path_to_input,
                    fnpat= r'English\s+,.Textgrid',
                    addcols = ["dirname", "barename", "ext"])


#audio_input_df.tail() # Get Dataframe of all files in directory
#canto_input_df.head()
eng_input_df.head()

for n in range(len(canto_input_df)):
    print('importing audio from ' + str(canto_audio_input_df["dirname"][n]) + "\\" + str(canto_audio_input_df["barename"][n])[0:5] + "\\" + str(canto_audio_input_df["fname"][n]))
    audioInputFile = str(canto_audio_input_df["dirname"][n]) + "\\" + str(canto_audio_input_df["barename"][n])[0:5] + "\\" + str(canto_audio_input_df["fname"][n])
    audio_clip_file = str(canto_audio_input_df["dirname"][n]) + "\\" + str(canto_audio_input_df["barename"][n])[0:5] + "\\" + str(canto_audio_input_df["barename"][n])[0:5]
                                                                    
    tgin = str(canto_input_df["dirname"][n]) + "\\" + str(canto_audio_input_df["barename"][n])[0:5] + "\\" + str(canto_audio_input_df["fname"][n])

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
            print("Splitting Audio")
            segment = splitAudio(str(audioInputFile), 
                    tgWords[idx].minTime, 
                    tgWords[idx].maxTime)
            segment.export(f"{audio_clip_file}\\{str(canto_audio_input_df['barename'][n])[0:5]}_clip({counter}).wav", format = "wav")
            counter += 1

