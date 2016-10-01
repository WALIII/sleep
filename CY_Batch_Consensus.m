function CY_Batch_Consensus()
% CY_Batch_Consensus.m


%   Created: 2016/10/01
%   By: WALIII
%   Updated: 2016/10/201
%   By: WALIII


% [nblanks formatstring]=fb_progressbar(100);
% fprintf(1,['Progress:  ' blanks(nblanks)]);


% Root is where the script is run...
START_DIR_ROOT = pwd;

% myfile = '/template/template_data.mat';
[parentdir,~,~]=fileparts(START_DIR_ROOT);

% load(fullfile(START_DIR_ROOT,myfile),'TEMPLATE');


% Get a list of all files and folders in this folder.

files = dir(START_DIR_ROOT)
files(1:2) = [] % Exclude parent directories.
dirFlags = [files.isdir]% Get a logical vector that tells which is a directory.
subFolders = files(dirFlags)% Extract only those that are directories.


for i = 1:length(subFolders)
  clear nextDir
  nextDir = strcat(subFolders(i).name,'/chop_data/mat/n_MANCLUST/wav');


    cd(nextDir)

   if exist('consensus_data') == 7;
    disp( 'Consensus Already calculated-' )

% send_text_message('617-529-0762','Verizon', ...
%           'Error','mat file detected- skipped dir')
       continue
   else




try
  mic_data = CY_Get_wav;
[consensus,F,T] = CY_Get_Consensus(mic_data); % try to calculate the consensus data

catch
  disp('could not perform function')
  send_text_message('617-529-0762','Verizon', ...
         'ERROR','Could not perform function')
end
disp('Processing for day X moving to the next day')

AVG = mean(consensus{1},3);
save('consensus_data','consensus','F','T','AVG','-v7.3') % Save the data

clear mic_data; clear consensus; clear F; clear T; clear AVG;
cd(START_DIR_ROOT)
  end
% end

send_text_message('617-529-0762','Verizon', ...
         'Calculation Complete','FS_BatchJob_Pt01 has completed')
