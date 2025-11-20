# Procedure for autoVOT Training
## Setup:
- Download audio files and paired intervocalic textgrids
- Mark down in the google sheet what file you are annotating
- Create a new interval tier called "vot"
  - Open the textgrids and audio in praat
  - Go to Tier on the toolbar
  - Add interval tier
  - Leave position as it (the new tier will be a the bottom)
  - Change the name to "vot"

## Marking VOT
- Add a point to the textgrid at the start of voicing
  - This can be done either by clicking the circle on the appropriate tear by the cursor location, or selecting the desired location and pressing `enter` with the desired tier selected.
- Add a point to the textgrid at the point of closure release
- Change the interval marking to "vot"
- Start with "kw" tokens if the selected audio file contains one
- To move straight to the token:
  - Look at the time from the CSV file 
    - Can use `cmd/ctrl + F` plus "kw" to find the exact interval time
  - Open praat, go to `time -> set selection subcategory -> select -> put in start and end time of selection from the csv file -> ok`
    - This will move the selection straight to the desired token
      - Press `cmd/ctrl + N` to move the view window straight to the selected window
  - Annotate VOT as specified above, with interval at start of voicing, interval at closure release, and add "vot" to the text
    - If you do not add "vot" the training will not train off of the data!

## Submitting data to GitHub
