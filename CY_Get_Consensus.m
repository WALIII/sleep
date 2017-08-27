% Get_Consensus
function [Gconsensus,f,t] = CY_Get_Consensus(mic_data)


	[consensus,f,t]=ccontour(mic_data(:,1),48000);
	% compute sdi, relevant quantities, store

	ntrials=size(mic_data,2);
	[rows,columns]=size(consensus);

	consensus=zeros(rows,columns,ntrials,'single');

	parfor j=1:ntrials
		disp([num2str(j) ' of ' num2str(ntrials)]);
		[consensus(:,:,j)]=ccontour(mic_data(:,j),48000);
	end

Gconsensus{1}=consensus;
%     T{DAY} = t;
%     F{DAY} = f;

end
