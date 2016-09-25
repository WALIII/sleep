function PullWavFiles(DATE)
  % PullWavFiles.m

  % Transfer Data from Recording Room every evening at midnight, and run
  % analysis on them. Requires the repository zftft from @jmarkow

  %   Created: 2015/12/22
  %   By: WALIII
  %   Updated: 2015/12/23
  %   By: WALIII


  % To set this up in chron:  http://www.nncron.ru/help/EN/working/cron-format.htm
  % In terminal, edit in crontab with nano: env EDITOR=nano crontab -e
  % To run every day, at 10PM:
  % 0 21  * * * /Applications/MATLAB_R2015a.app/bin/matlab  -nodisplay -nosplash -r "AR_DataTransfer; quit"  >> ~/.MATLAB_logfile.log 2>&1




  %% PATHS:
  START_DIR_ROOT = '/Volumes/raid//recording'; % Recording room computer, where all the main folders are kept.
  END_DIR_ROOT =  '/Users/wgillis/Recording_Room'; % Main analysis computer.
  TEXT_DIR = '/Users/wgillis/Desktop/RR_dashboard.txt'; % textfile for recording room input
  if nargin<1 | isempty(DATE), DATE=datetime('today'); end % by default, run on today's files

  %% Variables:
  INPUT = tdfread(TEXT_DIR,'\t'); % Assuimg that the .text file is in the path...
  BOX_ID = cellstr(INPUT.BOX_ID);
  STATUS = INPUT.STATUS; % should we extract, or not
  BIRD_ID = cellstr(INPUT.BIRD_ID); % what is the bird's ID?

  %% Process the data:
  disp('Processing Data...');

  % [nblanks formatstring]=fb_progressbar(100);
  % fprintf(1,['Progress:  ' blanks(nblanks)]);

  for i=1:length(BOX_ID)
    if STATUS(i) == 1;

  WAV_path = strcat(START_DIR_ROOT,'/',BOX_ID{i},'-WAV');
  IMG_path = strcat(START_DIR_ROOT,'/',BOX_ID{i},'-IMG');
  current_date =  datetime('today');
  current_date = datestr(current_date);

  file_ending = strcat(BIRD_ID{i},'/',current_date)
  % put a copy in a directory called: path. ../BIRD_DATA
  local_copy_path = strcat(START_DIR_ROOT,'/','BIRD_DATA','/',file_ending);
   % put processed data here... edit to actual path...
  destined_path = strcat(END_DIR_ROOT,'/',file_ending);

  cd(WAV_path) % GO into box, copy .mov data into the current date


   % datefile = strcat('*',DATE,'.wav'; % there is some strange format being used currently- might be hard to interperate...
   wav_listing=dir(fullfile(pwd,'*.wav')); % Get all .wav files in directory, (eventually,  with proper signing.)
   wav_listing={wav_listing(:).name};
   filenames=wav_listing;
   TotalFiles{i} = size(wav_listing);

  disp('Moving Files...');
  mkdir(local_copy_path);
  for ii = 1:length(wav_listing)
files=dir(strcat('/Users/wgillis/Recording_Room',filenames{ii}));
last_modified=files.date;
if last_modified >....DATE
     movefile(filenames{ii},local_copy_path)
  end


  mkdir(destined_path);
   copyfile(local_copy_path,destined_path)
  disp('Parsing Data...');
   cd(destined_path);
          song_chop();
          if STATUS(i) == 2
              % Automated template matching, and potentially more sophisticted
              % extraction methods...
          end
% rmdir(local_copy_path) % remove the local copy path
      cd(START_DIR_ROOT); % go back to the original folder in ARGO or calypso
  end
  end




mail = 'wal3lab'; %Your GMail email address
password = 'madlib3RD1989';  %Your GMail password
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');
% Send the email.  Note that the first input is the address you are sending the email to
txt1 = strcat('Box ',BOX_ID{:},'successfully moved, and contained: ',TotalFiles{:},' recordings')

TextBody = txt1;


sendmail('bliberti@bu.edu','Recording Room Summary',TextBody)
sendmail('dpleman@bu.edu','Recording Room Summary',TextBody)
end
