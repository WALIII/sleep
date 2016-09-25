#ZF sleep Project
============

The ZF_sleep project aims to see how song is disrupted during the acclimation to a blue light flashing at night, done in an effort to acclimate Zebra Finches to head mounted microscopes for nighttime imaging.

This repo is an internal guide to running the code and procedures for this experiment.


##Overview

### Necessary Repos:

The following repos are used for song clustering and Spectral Density Images ( also on Glab website)

The [Z]ebra [F]inch [T]ime [F]requency [T]ool[b]ox   https://github.com/jmarkow/zftftb

RoboFinch https://github.com/jmarkow/robofinch

MarkowLab https://github.com/jmarkow/markolab




### Automated Daily wav file extraction and song chunking

Set up automatic extraction on the lab's imac using crontab


To parse the data everyday, set up a crontab. To set this up in chron:, this is a useful URL: http://www.nncron.ru/help/EN/working/cron-format.htm

In terminal, edit in crontab with nano:
```
$  env EDITOR=nano crontab -e
 ```
To run every day, at 10PM, insert this into the crontab:
```
 0 21  * * * /Applications/MATLAB_R2014b.app/bin/matlab  -nodisplay -nosplash -r "PullWavFiles; quit"  >> ~/.MATLAB_logfile.log 2>&1
```

To monitor the output of this function, in a new terminal window:

```
tail -f ~/.MATLAB_logfile.log
```

This will read a ever-increasing .log file, which has the output of the matlab script directed to it. Good for troubleshooting as well.

### Automated Daily wav file extraction and song chunking

The data will be pulled and chunked, automatically, as follows:

DATA-> BIRD-> DATE-> chop_data-> mat-> ...
                             \
                               -> gif->
### Manual Song clustering.

in the mat folder, run, in MATLAB:
```
zftftb_song_clust
```
Follow the great tutorial on how to use this, listed here: https://github.com/jmarkow/zftftb/blob/master/docs/usage.rst

This needs to be done every day, for every bird, using the SAME TEMPLATE as used on day one.

### Spectral Density Images.

Once the data is aligned, you can make spectral density images- first go to the directory with all the .wav files, and run:

```
WAVS = CY_Get_wav;
```

then, to get the auditory contours, run:

```
[consensus,F,T] = CY_Get_Consensus(WAVS);
```

To plot the SDI, which is the average of the contour representation of song, run:

```
G = mean(consensus{1},3)
figure(); image(flipdim(G,1)); ylim([700, 1000]);
```


Make sure you SAVE the consensus, F, and T for every day that you generate it ,otherwise you will have to recalculate them.
