import textgrid
import csv

#Original filepath, csv output, and new textgrid output
filepath = r"D:\\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\SpiCE Textgrids\VF19A\VF19A_English_I1_20181114.TextGrid"
csvfilepath = r"D:\\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\SpiCE Textgrids\VF19A\VF19A_E.csv"
tgout = r"D:\\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\SpiCE Textgrids\VF19A\VF19A_E_intervocalic.TextGrid"

tg = textgrid.TextGrid.fromFile(filepath)
f = open(csvfilepath, 'w', newline = '')#Open csv file, create new if not available

fieldname = ['phone', 'minTime', 'maxTime', 'k total', 'kw total', 'g total', 'gw total']
dictWriter = csv.DictWriter(f, fieldnames=fieldname)
dictWriter.writeheader()
#Initialising variables
vowels = 'ioaeuIOAEU'
kept_intervals = []
targets = ['k', 'g', 'kw', 'gw', 'K', 'G']
kTally = 0
kwTally = 0
gTally = 0
gwTally = 0

for x in range(len(tg[3])):
    currentMark = tg[3][x].mark
    if currentMark in targets:
        if str(tg[3][x-1].mark) != "" and str(tg[3][x+1].mark) != "": #If the strings arent empty, check if intervocalic
            if str(tg[3][x-1].mark)[0] in vowels:
                if str(tg[3][x+1].mark)[0] in vowels:                    
                    print('intervocalic ' + tg[3][x].mark + ' found')  
                    kept_intervals.append(textgrid.Interval(tg[3][x].minTime, tg[3][x].maxTime, tg[3][x].mark)) # Add interval with intervocalic target
                    dictWriter.writerow({ # Save the phone, minTime, and maxTime of the interval
                        'phone': str(tg[3][x].mark), 
                        'minTime': str(tg[3][x].minTime), 
                        'maxTime': str(tg[3][x].maxTime)
                    })
                    if currentMark == 'k':
                       kTally += 1 
                    if currentMark == 'kw':
                        kwTally += 1
                    if currentMark == 'g':
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
