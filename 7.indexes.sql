CREATE INDEX documentation_ind
ON History_T (doc);
/

CREATE INDEX prtr_keyFeat_ind
ON PrtrHighlightStorage(keyFeat);
/

CREATE INDEX depl_keyFeat_ind
ON DeplHighlightStorage(keyFeat);
/

CREATE INDEX keyFeat_ind
ON Deployed_T
/

CREATE INDEX prtr_accuracy_ind
ON PreTrained_T (accuracy);
/

CREATE INDEX depl_accuracy_ind
ON Deployed_T (accuracy);
/