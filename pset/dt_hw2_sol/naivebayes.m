%only read the data if we don't have it loaded already
if(~exist('data_train'))
  readdata;
end

%alph may be set by the wrapper function, but if it's not, use default value
if(~exist('alph'))
  alph=1/numel(words);
end

%initialize with hallucinated counts
p_X_giv_Y=zeros(numel(newsgroup_names),size(data_train,2))+alph;
pY=zeros(numel(newsgroup_names),1);

%p_X_giv_Y(i,j) is the probability that the j'th word in the vocabulary will
%occurr at any given position in a document in the i'th class.
for(i=1:numel(newsgroup_names))
  p_X_giv_Y(i,:)=p_X_giv_Y(i,:)+sum(data_train(find(labels_train==i),:),1);
  p_X_giv_Y(i,:)=p_X_giv_Y(i,:)./sum(p_X_giv_Y(i,:));
  pY(i)=sum(labels_train==i);
end
pY=pY./sum(pY);

%compute top 100 words based on conditional entropy
tfeats=top_feats_cond_ent(p_X_giv_Y,pY,100);

%or compute top 100 words based on mutual information
%tfeats=top_feats_mutual_inf(probs,py,100);

%print top features
fprintf('``%s'''', ',words{tfeats});

%Note that the entire prediction procedure can be reduced to a single matrix
%multiply: we are summing simply over the count of each word times each word's
%log probability.  docprobs(i,j) is the probability that the j'th document
%is of the i'th class.
docprobs=log(p_X_giv_Y)*data_test'+repmat(log(pY),1,size(data_test,1));

[~,classes]=max(docprobs);
%print confusion matrix
C=confusionmat(labels_test,classes,'order',1:20)
%print overall performance
perf=sum(diag(C))./sum(sum(C))
