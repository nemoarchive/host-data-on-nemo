### R-3.6
.libPaths('/local/projects-t3/idea/bherb/software/R_lib/R_3_6')
library(BiocGenerics)
library(Seurat)
library(rhdf5)  ## for reading / writing h5 file from scanpy

## Human data was submitted to the NeMO team as RDS files

human=readRDS('/local/projects-t3/idea/bherb/NeMO_work/Lein_CrossSpecies_Paper/Human/human_corrected_UMI_data.RDS') #count data matrix - genes=rows, cells=columns

human_genes = rownames(human)
human_cells = colnames(human)

## save gene and cell names 
write.csv(human_cells,"/local/projects-t3/idea/bherb/NeMO_work/Lein_CrossSpecies_Paper/Human/Human_Lein_cells.csv",row.names=FALSE,quote=FALSE)

write.csv(human_genes,"/local/projects-t3/idea/bherb/NeMO_work/Lein_CrossSpecies_Paper/Human/Human_Lein_genes.csv",row.names=FALSE,quote=FALSE)

## write in format that can be read into scanpy in python
writeMM(human,file = "/local/projects-t3/idea/bherb/NeMO_work/Lein_CrossSpecies_Paper/Human/Human_Lein.mtx")


## tSNE coordinates were given as separate RDS file

human_all_tSNE=readRDS('/local/projects-t3/idea/bherb/NeMO_work/Lein_CrossSpecies_Paper/Human/tSNE_embeddings/All_cells/tsne_embeddings.RDS')

write.csv(human_all_tSNE,"/local/projects-t3/idea/bherb/NeMO_work/Lein_CrossSpecies_Paper/Human/human_allCells_tSNE.csv",row.names=TRUE,quote=FALSE)
