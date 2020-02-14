words=textread('data/vocabulary.txt','%s');
newsgroup_names=textread('data/newsgrouplabels.txt','%s');
labels_train=textread('data/train.label','%d');
labels_test=textread('data/test.label','%d');
data_train=read_docs('data/train.data',numel(labels_train),numel(words));
data_test=read_docs('data/test.data',numel(labels_test),numel(words));

