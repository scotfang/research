%%%%% Fo2pca.m
%%%%% project the original data onto the pca axises
%%%%% odata: original data 1*d
%%%%% pca_axis: pca axises, d*d data, each column is a principal component
%%%%% pca_sigma: 1*d
%%%%% pca_mu: 1*d
%%%%% pcn: desired nmber of pca principal component
%%%%% pcadata: 1*pcn output vector

function pcadata = Fo2pca(odata,pca_axis,pca_sigma,pca_mu,pcn)

odata = (odata-pca_mu)./pca_sigma;
pcadata = ((pca_axis(:,1:pcn))'*odata')';
