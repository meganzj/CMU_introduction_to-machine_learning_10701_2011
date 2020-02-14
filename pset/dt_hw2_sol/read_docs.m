%returns a sparse matrix where rows are documents and cols are words
function counts=read_docs(fname,ndocs,nwords);
  [docid wordid counts]=textread(fname,'%d %d %d');
  counts=sparse(docid, wordid, counts, ndocs, nwords);
end
