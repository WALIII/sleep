#ZF sleep Project
============

##Overview
The ZF_sleep project aims to see how song is disrupted during the acclimation to a blue light flashing at night, done in an effort to acclimate Zebra Finches to head mounted microscopes for nighttime imaging.

This repo is an internal guide to running the code and procedures for this experiment.


##Overview

### Necessary Repos:

The following repos are used for song clustering and Spectral Density Images ( also on Glab website)

The [Z]ebra [F]inch [T]ime [F]requency [T]ool[b]ox   https://github.com/jmarkow/zftftb
RoboFinch https://github.com/jmarkow/robofinch
MarkowLab https://github.com/jmarkow/markolab




### Automated Daily wav file extraction and song chunking

Set up automatic extraction on imac using crontab


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
