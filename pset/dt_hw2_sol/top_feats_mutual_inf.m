function idx=feature_select_mutual_inf(p_X_giv_Y,pY,numfeats)
  pY=repmat(pY,1,size(p_X_giv_Y,2));

  %marginal probability of x
  p_X=sum(p_X_and_Y,1);

  %inner sum of conditional entropy
  cond_ent_tmp=-p_X_giv_Y.*log2(p_X_giv_Y)-(1-p_X_giv_Y).*log2(1-p_X_giv_Y);
  %outer sum of conditional entropy
  cond_ent=sum(cond_ent_tmp.*pY,1);
  marg_ent=-p_X.*log2(p_X)-(1-p_X).*log2(1-p_X);
  ent=marg_ent-cond_ent;

  [vals idx]=sort(ent,'descend');
  idx=idx(1:numfeats);
end
