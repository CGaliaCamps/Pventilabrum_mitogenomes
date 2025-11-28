library(ggplot2)
library(gmodels)

setwd("F:/Phakellia/mitogenomes/intron_validation/Definitivo")
DNA <- read.table(file="DNA/WTR_01266.coverage")
RNA <- read.table(file="RNA/WTR_01266.coverage")
colnames(RNA) <- colnames(DNA) <- c("mitogenome", "position", "coverage")
RNA$species <- DNA$species <- "WTR_01266"


gff <-  read.table(file="Annotations/WTR_01266.gff",  skip = 6)
gff <- gff[which(gff$V3=="rRNA"| gff$V3=="origin_of_replication"| gff$V3=="gene"| gff$V3=="tRNA" | gff$V3=="intron"),]
gff <- gff[,c(3,4,5)]
colnames(gff) <- c("gene","start","end")


DNACI <- ci(DNA$coverage)
RNACI <- ci(RNA$coverage)


 plot <- ggplot() +
#  Add the geom_rect layer for rectangles based on gff data
  #geom_rect(data=gff, aes(xmin = start, xmax = end, ymin = 0, ymax = 1, fill=gene), alpha=0.75) +
  geom_rect(data=gff, aes(xmin = start, xmax = end, ymin = max(RNA$coverage)-1, ymax = Inf, fill=gene), alpha=0.75) +
    geom_rect(data=gff, aes(xmin = start, xmax = end, ymin = 0, ymax = Inf, fill=gene), alpha=0.2) +
  scale_fill_manual(values=c("green3","grey50","yellow3","indianred","#D50877")) +
  # geom_vline(xintercept=13537)+
   geom_line(data=DNA, aes(x=position, y=coverage, color=species), color="steelblue", lwd=0.75) +
  geom_line(data=RNA, aes(x=position, y=coverage, color=species), color="black", lwd=0.5, alpha=0.75) +
   scale_y_continuous(transform='log10', limits=c(-Inf, max(RNA$coverage))) +
  xlim(1, max(RNA$coverage)) +
  scale_x_continuous(breaks=c(min(DNA$position), 6000, 12000, 18000, max(DNA$position))) +
    theme_classic()+
   theme(legend.position="bottom")
 plot
 
svg(filename="WTR_01266_RNA&DNA_cov.svg", width=5, height=3)
plot
dev.off()

pdf("WTR_01266_RNA&DNA_cov.pdf", width=5, height=3)
plot
dev.off()

png(filename="WTR_01266_RNA&DNA_cov.png", width=2500, height=1500)
plot
dev.off()
 


rRNA <- gff[gff$gene=="rRNA",]
gene <- gff[gff$gene=="gene",]
tRNA <- gff[gff$gene=="tRNA",]

intron16 <-gff[gff$gene=="intron",]
intron16 <-intron16[intron16$end<=5000,]
exon16 <- rRNA[rRNA$end<=5000,]
  
introncox <- gff[gff$gene=="intron",]
introncox <- introncox[introncox$start>=5000,]
exoncox <- gene[gene$start>=12000 & gene$end<=16500,]

rRNA <- RNA[which(RNA$position>=rRNA$start & RNA$position<=rRNA$end),]
gene <- RNA[which(RNA$position>=gene$start & RNA$position<=gene$end),]
tRNA <- RNA[which(RNA$position>=tRNA$start & RNA$position<=tRNA$end),]
intron16 <- RNA[which(RNA$position>=intron16$start & RNA$position<=intron16$end),]
exon16 <- RNA[which(RNA$position>=exon16$start & RNA$position<=exon16$end),]
introncox <- RNA[which(RNA$position>=introncox$start & RNA$position<=introncox$end),]
exoncox <- RNA[which(RNA$position>=exoncox$start & RNA$position<=exoncox$end),]


mean(rRNA$coverage)
mean(gene$coverage)
mean(tRNA$coverage)

mean(intron16$coverage)
mean(exon16$coverage)

mean(introncox$coverage)
mean(exoncox$coverage)



S16_test <- t.test(x=intron16$coverage, y=exon16$coverage, alternative="two.sided", paired=F, conf.level = 0.95)
cox1_test <- t.test(x=introncox$coverage, y=exoncox$coverage, alternative="two.sided", paired=F, conf.level = 0.95)




gff <- gff[which(gff$gene=="rRNA"| gff$gene=="gene" | gff$gene=="intron"),]
gff <- gff[order(gff$start),]

for(n in 1:nrow(gff)){
  region <- gff[n,]
  subset <- RNA[which(RNA$position>=region$start & RNA$position<=region$end),]
  mean_coverage <- mean(subset$coverage, na.rm=TRUE)
  print(mean_coverage)}
