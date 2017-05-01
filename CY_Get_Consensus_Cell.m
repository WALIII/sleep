% Get_Consensus
function [Gconsensus,F,T,Auditory_contour] = CY_Get_Consensus_Cell(mic_data)


	[consensus F T,AUDITORY_CONTOUR]=acontour(mic_data{1},48000);
	% compute sdi, relevant quantities, store

	ntrials=size(mic_data,2);
	[rows,columns]=size(consensus);

	consensus=zeros(rows,columns,ntrials,'single');

	parfor j=1:ntrials
		disp([num2str(j) ' of ' num2str(ntrials)]);
		[consensus(:,:,j),F,T,AUDITORY_CONTOUR(:,:,j)]=acontour(mic_data{j},48000);
	end

Gconsensus{1}=consensus;
Auditory_contour{1} = AUDITORY_CONTOUR;
%     T{DAY} = t;
%     F{DAY} = f;

end
