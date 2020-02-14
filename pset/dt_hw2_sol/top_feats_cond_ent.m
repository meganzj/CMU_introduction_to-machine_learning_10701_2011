function idx=feature_select(p_X_giv_Y,pY,numfeats)
  p_X_and_Y=bsxfun(@times,p_X_giv_Y,pY);
  p_Y_giv_X=bsxfun(@rdivide,p_X_and_Y,sum(p_X_and_Y,1));
%  ent=-sum(bsxfun(@times,p_X_giv_Y.*log2(p_Y_giv_X),pY),1);
  ent=-sum(p_Y_giv_X.*log2(p_Y_giv_X),1);

  [vals idx]=sort(ent,'ascend');
  idx=idx(1:numfeats);
end
