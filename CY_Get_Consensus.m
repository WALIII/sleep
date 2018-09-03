% Get_Consensus
function [Gconsensus,f,t] = CY_Get_Consensus(mic_data,fs)
FFT_LENGTH = 1024; %1024
FFT_OVERLAP = 1016;

	[consensus,f,t]=ccontour(mic_data(:,1),fs,'fft_length', FFT_LENGTH,'fft_overlap', FFT_OVERLAP);
	% compute sdi, relevant quantities, store

	ntrials=size(mic_data,2);
	[rows,columns]=size(consensus);

	consensus=zeros(rows,columns,ntrials,'single');

	parfor j=1:ntrials
		disp([num2str(j) ' of ' num2str(ntrials)]);
		[consensus(:,:,j)]=ccontour(mic_data(:,j),fs,'fft_length', FFT_LENGTH,'fft_overlap', FFT_OVERLAP);
	end

Gconsensus{1}=consensus;
%     T{DAY} = t;
%     F{DAY} = f;

end
