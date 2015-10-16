setwd("~/projects/LIMAA/")
###PC plots###
x<-read.table("data/all-projected-to-pel.evec",h=F,stringsAsFactors = T)
df<-data.frame(x)

library(ggplot2)

EAS<-data.frame(shape=1,pop=c("CDX","CHB","JPT","KHV","CHS"),col=colorRampPalette(c("yellow","orange"),alpha=TRUE)( 5 ))
SAS<-data.frame(shape=2,pop=c("BEB","GIH","ITU","PJL","STU"),col=colorRampPalette(c("skyblue", "darkblue"),alpha=TRUE)( 5 ))
AFR<-data.frame(shape=3,pop=c("ASW","ACB","ESN","GWD","LWK","MSL","YRI"),col=colorRampPalette(c("grey", "black"),alpha=TRUE)( 7 ))
EUR<-data.frame(shape=4,pop=c("GBR","FIN","IBS","TSI","CEU"),col=colorRampPalette(c("yellowgreen","green"),alpha=TRUE)( 5 ))
AMR<-data.frame(shape=5,pop=c("CLM","MXL","PUR"),col=colorRampPalette(c("pink","hotpink4"),alpha=TRUE)( 3 ))
PEL<-data.frame(shape=6,pop="PEL",col="red")  

POP<-rbind(EAS,SAS,AFR,EUR,AMR,PEL)
#POP<-rbind(PEL,AMR)
df$shape<-as.character(POP[match(df$V8,POP$pop),]$shape)
df$col<-as.character(POP[match(df$V8,POP$pop),]$col)

df1<-df[df$V8 %in% POP$pop,]

cols<-as.vector(POP$col)[order(POP$pop)]
f1<-ggplot(df1,aes(x=V2,y=V3,colour=V8))+geom_point()+xlab("PC1")+ylab("PC2")
f1<-f1+scale_colour_manual(values=cols[sort(levels(POP$pop),index=T)$ix])+xlim(-0.25,0.5)+ylim(-0.25,0.25)
f1<-f1+theme_bw()+ theme(legend.position="none") #+ aes(shape = factor(shape)) 
print(f1)
ggsave(filename="pics/pel-ALL.pdf",width=5,height=4)

