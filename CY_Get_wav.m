function mic_data = CY_Get_wav()

wav_listing=dir(fullfile(pwd,'*.wav')); % Get all .wav files in directory, (eventually,  with proper signing.)
  wav_listing={wav_listing(:).name};
  filenames=wav_listing;

  for i = 1:length(wav_listing);

      [y,Fs] = audioread(filenames{i});

      mic_data{i} = y;

  end
