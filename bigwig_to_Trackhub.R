### this is an example from the Lein cross species paper
## R-3.6
library("RColorBrewer")

flexsplit <- function(dat,char){
test=strsplit(as.character(dat),char,fixed=TRUE)
n.obs <- sapply(test, length)
seq.max <- seq_len(max(n.obs))
mat <- t(sapply(test, "[", i = seq.max))
mat
}

## Cell class - ATAC data example 

intclust = data.frame(sample=c("GABAergic","Glutamatergic","Non-Neuronal"),color=c('#3EA185','#C95170','#6D7A67'),stringsAsFactors=FALSE)

tmpdir = './nemoHub/CrossSpeciesPaperMOp/Human/ATAC/Class' ## location of bigwigs provided by author

k= 'Human_MOp_ATAC_Class'

tmpGen = 'hg38'

bwFiles = list.files(path=paste(tmpdir,tmpGen,sep="/"),pattern='.bw',full.names=TRUE

samples = flexsplit(bwFiles,'_')[,6]
samples = gsub('.bw','',samples)

## create trackDb.txt file
sink(file=paste(tmpdir,'/',tmpGen,'/trackDb.txt',sep=""))
cat(paste('track ',k,'\n','container multiWig','\n','shortLabel ',k,'\n','longLabel ',k,'\n','type bigWig 0 30000','\n','viewLimits 0:100','\n','visibility full','\n','maxHeightPixels 150:30:11','\n','aggregate transparentOverlay','\n','showSubtrackColorOnUi on','\n','windowingFunction mean','\n','priority 1.4','\n','configurable on','\n','autoScale on','\n\n',sep=""))

for(i in samples){
tmpfile=bwFiles[grep(i,bwFiles)]
if(length(tmpfile)==0) next
intInd = grep(i,intclust$sample)
hexcolor = unique(intclust$color[intInd])
rgbcolor = col2rgb(hexcolor[1])
rgbcol = paste(rgbcolor[,1],collapse=', ')
bigurl = gsub('./nemoHub','http://data.nemoarchive.org/nemoHub',tmpfile)
cat(paste('track ',i,'\n','bigDataUrl ',bigurl,'\n','shortLabel ',i,'\n','longLabel ',k,'-',i,'\n','parent ',k,'\n','type bigWig','\n','color ',rgbcol,'\n\n',sep=""))
}
sink()

## create hub.txt file
sink(file=paste(tmpdir,'/hub.txt',sep=""))
cat(paste('hub ',k,'\n','shortLabel ',k,'\n','longLabel ',k,'\n','genomesFile genomes.txt','\n','email  bherb@som.umaryland.edu','\n\n',sep=""))
sink()

## create genomes.txt file
sink(file=paste(tmpdir,'/genomes.txt',sep=""))
cat(paste('genome ',tmpGen,'\n','trackDb ',tmpGen,'/trackDb.txt',sep=""))
sink()


## http://data.nemoarchive.org/nemoHub/CrossSpeciesPaperMOp/Human/ATAC/Class/hub.txt  URL that can be used for UCSC browser trackhub 



#### DNA methylation example

## MajorClust - random color for now, but make consistent bw CHN and CGN

tmpdir = './nemoHub/CrossSpeciesPaperMOp/Human/dnaMethylation/MajorCluster/CGN'

k= 'Human_MOp_CGN_Meth_MajorCluster'

tmpGen = 'hg19'

bwFiles = list.files(path=paste(tmpdir,tmpGen,sep="/"),pattern='rate.bw',full.names=TRUE)

samples = flexsplit(bwFiles,'/hg19/')[,2]
samples = gsub('.CGN-Both.rate.bw','',samples)

cols=rev(colorRampPalette(brewer.pal(11,"RdYlBu"))(length(samples)))

intclust=data.frame(sample=samples,color=cols)

sink(file=paste(tmpdir,'/',tmpGen,'/trackDb.txt',sep=""))
cat(paste('track ',k,'\n','container multiWig','\n','shortLabel ',k,'\n','longLabel ',k,'\n','type bigWig 0 30000','\n','viewLimits 0:100','\n','visibility full','\n','maxHeightPixels 150:30:11','\n','aggregate transparentOverlay','\n','showSubtrackColorOnUi on','\n','windowingFunction mean','\n','priority 1.4','\n','configurable on','\n','autoScale on','\n\n',sep=""))

for(i in samples){
tmpfile=bwFiles[which(intclust$sample==i)]
if(length(tmpfile)==0) next
intInd = which(intclust$sample==i)
hexcolor = unique(intclust$color[intInd])
rgbcolor = col2rgb(hexcolor[1])
rgbcol = paste(rgbcolor[,1],collapse=', ')
bigurl = gsub('./nemoHub','http://data.nemoarchive.org/nemoHub',tmpfile)
cat(paste('track ',i,'\n','bigDataUrl ',bigurl,'\n','shortLabel ',i,'\n','longLabel ',k,'-',i,'\n','parent ',k,'\n','type bigWig','\n','color ',rgbcol,'\n\n',sep=""))
}
sink()

sink(file=paste(tmpdir,'/hub.txt',sep=""))
cat(paste('hub ',k,'\n','shortLabel ',k,'\n','longLabel ',k,'\n','genomesFile genomes.txt','\n','email  bherb@som.umaryland.edu','\n\n',sep=""))
sink()

sink(file=paste(tmpdir,'/genomes.txt',sep=""))
cat(paste('genome ',tmpGen,'\n','trackDb ',tmpGen,'/trackDb.txt',sep=""))
sink()


http://data.nemoarchive.org/nemoHub/CrossSpeciesPaperMOp/Human/dnaMethylation/MajorCluster/CGN/hub.txt

