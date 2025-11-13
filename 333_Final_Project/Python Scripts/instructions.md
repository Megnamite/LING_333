# Instructions for use

## Prerequisites
- Python 3.14 or greater
- [TextGrid python package](https://github.com/kylebgorman/textgrid/tree/master)
- Textgrids for the Cantonese and English taken from [the SpiCE corpus](https://borealisdata.ca/dataset.xhtml?persistentId=doi:10.5683/SP2/MJOXP3)

## Getting set up
Make sure you install the textgrid python package (pip install textgrid). This is done in your cmd prompt on windows or terminal on mac. To get this to work make sure you have added python to your PATH variables on windows, [instructions here](https://realpython.com/add-python-to-path/)

If you downloaded the files from this GitHub page you shouldn't need to download anything else, if not make sure you have the Cantonese and English textgrids from the SpiCE corpus listed above.

## Running the code
1. Change the `filepath` variable to your computers filepath to the original textgrid from the corpus.
2. Change the `csvfilepath` variable to the CSV output, this will be found in a folder matching the speaker code. e.g. Speaker VF19A's CSV is found in folder VF19A.
3. Change the `tgout` variable to the output intervocalic textgrid filepath, also found in the speakers matching folder.
4. CMD/CTRl-A, run the code with the updated variables, and you should be done!

### **Any changes you make or files you add should added to a branch, not committed to main!!**
