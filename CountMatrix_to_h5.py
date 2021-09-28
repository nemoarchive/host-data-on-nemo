### this is an example from the Lein cross species paper. Data was originally given to us in Rdata objects, so there was some prep work done in R - see Prep_CountMatrix_for_Scanpy.R for details. 

import matplotlib
matplotlib.use('agg')
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import scanpy.api as sc
import os
import copy 
from numpy import asarray as ar
from scipy import stats
import json
import pyensembl
import uuid

### gene references - need ensembl to gene symbol lookup table - obtained from ensembl site 

## human 
hs96 = pd.read_csv('./bherb/annotation/Hsapiens/HS_Ensembl96.csv')
hs96.columns = ['ensembl_id','ensembl_version','gene_symbol']

## mouse 
mus96 = pd.read_csv('./bherb/annotation/Mus_Ensembl96.csv')
mus96.columns = ['ensembl_id','ensembl_version','gene_symbol']

cj99 = pd.read_csv('./bherb/annotation/Marmoset/CJ_Ensembl99.csv')
cj99.columns = ['ensembl_id','ensembl_version','gene_symbol']



### NeMO team was given a separate list of cells that were included in the downsample set
dnsamp = pd.read_csv("./bherb/NeMO_work/Lein_CrossSpecies_Paper/Final_annotation_and_downsampling/downsampled_ids/final_downsampled_ids.csv",index_col=0) # 64350 tot cells - this is more than total of all 200 max cell per cluster downsample lists (total =53233)

### human
human = sc.read_mtx("./bherb/NeMO_work/Lein_CrossSpecies_Paper/Human/Human_Lein.mtx") #created in Prep_CountMatrix_for_Scanpy.R
human = human.T ## somewhere we need to transform to cells x genes
human_genes = pd.read_csv("./bherb/NeMO_work/Lein_CrossSpecies_Paper/Human/Human_Lein_genes.csv") #created in Prep_CountMatrix_for_Scanpy.R

gs = human_genes.x.tolist() ## truly gene symbol....
gsl = {'gene_symbol':gs} ## create dictionary

en96Gene = ['NA']*len(gs)
engs96 = hs96.gene_symbol.tolist()

for i in range(0,len(gs)):
 print(str(i) + ',')
 try:
  en96Gene[i] = hs96.ensembl_id[engs96.index(gs[i])]
 except:
  print(',oops')

es=en96Gene

## Joshua wants .var to have gene symbol in 'gene_symbol' column, and ensembl in index

geneDF = pd.DataFrame(data=gsl,index=es)
naind=np.where(np.array(geneDF.index.tolist())!='NA')

human = human[:,naind[0].tolist()]
geneDF = geneDF.iloc[naind[0].tolist(),:]

human.var.index = np.array(geneDF.index.tolist())
human.var['gene_symbol'] = geneDF.gene_symbol.tolist()
human_cells = pd.read_csv("./bherb/NeMO_work/Lein_CrossSpecies_Paper/Human/Human_Lein_cells.csv") #created in Prep_CountMatrix_for_Scanpy.R
human.obs.index = np.array(human_cells.iloc[:,0]).tolist()

human_meta = pd.read_csv("./bherb/NeMO_work/Lein_CrossSpecies_Paper/Final_annotation_and_downsampling/human_anno.csv") #76533  - this is less than mtx file

human_meta.index = np.array(human_meta.loc[:,'sample_id']).tolist()
human_meta = human_meta.drop(labels = 'Unnamed: 0',axis=1) 
human = human[np.array(human_meta.loc[:,'sample_id']).tolist(),:]
human.obs = human_meta

for i in list(set(human_meta)):
 human.obs[i] = human_meta[i].values

### tSNE coordinates

human_allCells_tSNE = pd.read_csv("./bherb/NeMO_work/Lein_CrossSpecies_Paper/Human/human_allCells_tSNE.csv",index_col=0) #created in Prep_CountMatrix_for_Scanpy.R

human_allCells_tSNE = human_allCells_tSNE.loc[human.obs.index.tolist(),:]
human.obs['tSNE_1'] = human_allCells_tSNE['tSNE_1'].values
human.obs['tSNE_2'] = human_allCells_tSNE['tSNE_2'].values

human.write('./bherb/NeMO_work/Lein_CrossSpecies_Paper/Human/Human_Lein_AllCells.h5ad')
#human = sc.read_h5ad('/local/projects-t3/idea/bherb/NeMO_work/Lein_CrossSpecies_Paper/Human/Human_Lein_AllCells.h5ad')

## downsample lists 
human_ds = copy.deepcopy(human)
human_ds = human_ds[list(dnsamp.iloc[np.where(np.array(dnsamp.species)=='human')[0],0]),:]

human_ds.write('./bherb/NeMO_work/Lein_CrossSpecies_Paper/Human/Human_Lein_Downsample.h5ad')

### uuid
str(uuid.uuid4()) #'aab7a4ac-a569-4d6e-9173-23a48950231f'

human_ds.write('./bherb/NeMO_work/Lein_CrossSpecies_Paper/Human/aab7a4ac-a569-4d6e-9173-23a48950231f.h5ad')
