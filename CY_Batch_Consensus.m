function CY_Batch_Consensus()
% CY_Batch_Consensus.m


%   Created: 2016/10/01
%   By: WALIII
%   Updated: 2016/10/201
%   By: WALIII

% Compute consensus contours, and SDI images for the sleep experiments.


% [nblanks formatstring]=fb_progressbar(100);
% fprintf(1,['Progress:  ' blanks(nblanks)]);


% Root is where the script is run... should contain folders that have the
START_DIR_ROOT = pwd;

[parentdir,~,~]=fileparts(START_DIR_ROOT);

%% Get a list of all files and folders in this folder.
files = dir(START_DIR_ROOT)
files(1:2) = [] % Exclude parent directories.
dirFlags = [files.isdir]% Get a logical vector that tells which is a directory.
subFolders = files(dirFlags)% Extract only those that are directories.

%% Go through list of subfolders to compute the SDI
for i = 1:length(subFolders)
  clear nextDir % clear the old directory information
  nextDir = strcat(subFolders(i).name,'/chop_data/wav/n_MANCLUST/wav');

    cd(nextDir) % Enter the next directory

   if exist('consensus_data') == 7; % if data has already been calculated, go back to the next direcotry
    disp( 'Consensus Already calculated-' )
    cd(START_DIR_ROOT)
       continue
   else


try
  mic_data = CY_Get_wav; % Gather all the aligned .wav files
  [consensus,F,T] = CY_Get_Consensus(mic_data); % try to calculate the consensus data

catch
  disp('could not perform function')
  send_text_message('617-529-0762','Verizon', ...
         'ERROR','Could not perform function')
end
    disp(strcat('Processing for day ', subFolders(i).name, 'moving to the next day'));

      AVG = mean(consensus{1},3); % calculate the SDI, which is the average of the contour representations.
        save('consensus_data','consensus','F','T','AVG','-v7.3') % Save the data

        clear mic_data; clear consensus; clear F; clear T; clear AVG; % clear matalb workspace

        cd(START_DIR_ROOT)
   end
  end

send_text_message('617-529-0762','Verizon', ...
         'Calculation Complete','Consensus Contours, and SDI images have been computed.')
