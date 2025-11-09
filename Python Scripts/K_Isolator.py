import textgrid
import csv

filepath = r"D:\\UBC Coding Environment\VIsual Studio\LING_333_Github_Clone\LING_333\333_Final_Project\SpiCE Textgrids\VM34A_Cantonese_I1_20191028.Textgrid"
csvfilepath = r"D:\\UBC Coding Environment\VIsual Studio\LING_333_Github_Clone\LING_333\333_Final_Project\SpiCE Textgrids\VM34A.csv"

tg = textgrid.TextGrid.fromFile(filepath)
f = open(csvfilepath, 'w', newline = '')

fieldname = ['phone', 'minTime', 'maxTime'] # Define headers
dictWriter = csv.DictWriter(f, fieldnames=fieldname) # Initialise object
dictWriter.writeheader()
for x in range(len(tg[3])): # For how many items in phone tier
    print(x) # Testing sake
    if tg[3][x].mark == 'k': 
        dictWriter.writerow({'phone': str(tg[3][x].mark), 'minTime': str(tg[3][x].minTime), 'maxTime': str(tg[3][x].maxTime)}) # Write a dict, each value assigned to a header
f.close()