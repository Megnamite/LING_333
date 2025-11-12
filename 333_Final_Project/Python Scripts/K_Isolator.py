import textgrid
import csv

filepath = r"D:\\UBC Coding Environment\VIsual Studio\LING_333_Github_Clone\LING_333\333_Final_Project\SpiCE Textgrids\VM34A_Cantonese_I1_20191028.TextGrid"
csvfilepath = r"D:\\UBC Coding Environment\VIsual Studio\LING_333_Github_Clone\LING_333\333_Final_Project\SpiCE Textgrids\VM34A.csv"
tgout = r"D:\\UBC Coding Environment\VIsual Studio\LING_333_Github_Clone\LING_333\333_Final_Project\SpiCE Textgrids\VM34A_intervocalic.Textgrid"

tg = textgrid.TextGrid.fromFile(filepath)
f = open(csvfilepath, 'w', newline = '')

fieldname = ['phone', 'minTime', 'maxTime']
dictWriter = csv.DictWriter(f, fieldnames=fieldname)
dictWriter.writeheader()
vowels = 'ioaeu'
kept_intervals = []

for x in range(len(tg[3])):
    iT = textgrid.Interval(tg[3][x].minTime, tg[3][x].maxTime, tg[3][x].mark)
    if tg[3][x].mark == 'k':
        if str(tg[3][x-1].mark)[0] in vowels:
            if str(tg[3][x+1].mark)[0] in vowels:
                print('intervocalic K found')  
                kept_intervals.append(textgrid.Interval(tg[3][x].minTime, tg[3][x].maxTime, tg[3][x].mark)) # Add interval with intervocalic K
                dictWriter.writerow({
                    'phone': str(tg[3][x].mark), 
                    'minTime': str(tg[3][x].minTime), 
                    'maxTime': str(tg[3][x].maxTime)
                })

new_tier = textgrid.IntervalTier(name='k isolation', minTime=tg[3].minTime, maxTime=tg[3].maxTime) # Create a new tier just for K
for inter in kept_intervals: # Loop through adding the old set to this new tier
    new_tier.addInterval(inter)
tg.append(new_tier)
tg.write(tgout) # Write to a new file with updated output

f.close()
