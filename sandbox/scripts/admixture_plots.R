####ADMIXTURE#####

setwd("~/projects/LIMAA/")
cv<-read.table("data/cv.txt")
f1<-ggplot(data=cv,aes(x=1:6,y=V4,size=3))+geom_point()+ylab("Cross-validation erorr")+xlab("K")+ylim(0.25,0.28)+theme_bw()+ theme(legend.position="none")
print(f1)
ggsave("pics/pel-cv.pdf",width=6,height=5)

pdf("pics/admixture.pdf",width=7,height=6)
par(mfrow=c(5,1), mai = c(0, 0.1, 0.1, 0.1), tcl=-0.5)
for (n in 2:6){
tbl=read.table(paste("data/prunedAmericas.",n,".Q",sep=""))

pop<-read.table("data/prunedAmericas.pop",h=F,stringsAsFactors = F)
num<-table(pop$V7)

df<-t(tbl[sort(pop$V7,index.return=TRUE)$ix,])
barplot(df, space=0,col=c("red","blue","green","orange","yellow","brown"), border=NA,xaxt="n",yaxt="n")
text( -10,.4, srt=90,cex=1.5, adj = 0, labels = paste("K=",n,sep=""))
abline(v=num[1],lwd=2)
abline(v=num[1]+num[2],lwd=2)
abline(v=num[1]+num[3]+num[2],lwd=2)
}
mtext("Colombian", side=1, outer=T, at=.15)
mtext("Mexican", side=1, outer=T, at=.36)
mtext("Peruvian", side=1, outer=T, at=.58)
mtext("Puerto Rican", side=1, outer=T, at=.82)
dev.off()
