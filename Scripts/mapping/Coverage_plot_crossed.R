library(ggplot2)
library(gmodels)

setwd("F:/Phakellia/mitogenomes/intron_validation/Definitivo")
DNA <- read.table(file="DNA/refNwK_KB_61_2_readDeep_094_05.coverage")
colnames(DNA) <- c("mitogenome", "position", "coverage")
DNA$species <- "NwK_KB_61_2"


gff <- read.table(file="Annotations/NwK_KB_61_2.gff",  skip = 7)
gff <- gff[which(gff$V3=="rRNA"| gff$V3=="origin_of_replication"| gff$V3=="gene"| gff$V3=="tRNA" | gff$V3=="intron"),]
gff <- gff[,c(3,4,5)]
colnames(gff) <- c("gene","start","end")


DNACI <- ci(DNA$coverage)
#RNACI <- ci(RNA$coverage)


 plot <- ggplot() +
#  Add the geom_rect layer for rectangles based on gff data
  #geom_rect(data=gff, aes(xmin = start, xmax = end, ymin = 0, ymax = -1, fill=gene), alpha=0.5) +
  geom_rect(data=gff, aes(xmin = start, xmax = end, ymin = max(DNA$coverage)-1, ymax = Inf, fill=gene), alpha=0.75) +
    geom_rect(data=gff, aes(xmin = start, xmax = end, ymin = 0, ymax = Inf, fill=gene), alpha=0.2) +
  scale_fill_manual(values=c("green3","grey50", "yellow3", "indianred", "#D50877")) +
   geom_line(data=DNA, aes(x=position, y=coverage, color=species), color="steelblue", lwd=0.75) +
   #geom_line(data=RNA, aes(x=position, y=coverage, color=species), color="black", lwd=0.5, alpha=0.75) +
  #scale_y_continuous(trans='log10', limits=c(-Inf, (max(DNA$coverage)*2))) +
  xlim(1, max(DNA$coverage)) +
  scale_x_continuous(breaks=c(min(DNA$position), 6000, 12000, 18000, max(DNA$position))) +
    theme_classic()+
   theme(legend.position="bottom")
 plot
 
svg(filename="refNwK_KB_61_2_readDeep_094_05_cov.svg", width=5, height=3)
plot
dev.off()

pdf("refNwK_KB_61_2_readDeep_094_05_cov.pdf", width=5, height=3)
plot
dev.off()

png(filename="refNwK_KB_61_2_readDeep_094_05_cov.png", width=2500, height=1500)
plot
dev.off()
 
 

####way around

DNA <- read.table(file="DNA/refDeep_094_05_readNwK_KB_61_2.coverage")
colnames(DNA) <- c("mitogenome", "position", "coverage")
DNA$species <- "Deep_094_05"


gff <- read.table(file="Annotations/Deep_094_05.gff",  skip = 7)
gff <- gff[which(gff$V3=="rRNA"| gff$V3=="origin_of_replication"| gff$V3=="gene"| gff$V3=="tRNA" | gff$V3=="intron"),]
gff <- gff[,c(3,4,5)]
colnames(gff) <- c("gene","start","end")


DNACI <- ci(DNA$coverage)
#RNACI <- ci(RNA$coverage)


plot <- ggplot() +
  #  Add the geom_rect layer for rectangles based on gff data
  #geom_rect(data=gff, aes(xmin = start, xmax = end, ymin = 0, ymax = -1, fill=gene), alpha=0.5) +
  geom_rect(data=gff, aes(xmin = start, xmax = end, ymin = max(DNA$coverage)-1, ymax = Inf, fill=gene), alpha=0.75) +
  geom_rect(data=gff, aes(xmin = start, xmax = end, ymin = 0, ymax = Inf, fill=gene), alpha=0.2) +
  scale_fill_manual(values=c("green3","grey50", "yellow3", "indianred", "#D50877")) +
  geom_line(data=DNA, aes(x=position, y=coverage, color=species), color="steelblue", lwd=0.75) +
  #geom_line(data=RNA, aes(x=position, y=coverage, color=species), color="black", lwd=0.5, alpha=0.75) +
  #scale_y_continuous(trans='log10', limits=c(-Inf, (max(DNA$coverage)*2))) +
  scale_x_continuous(breaks=c(min(DNA$position), 6000, 12000, 18000, max(DNA$position))) +
  theme_classic()+
  theme(legend.position="bottom")
plot

svg(filename="refDeep_094_05_readNwK_KB_61_2_cov.svg", width=5, height=3)
plot
dev.off()

pdf("refDeep_094_05_readNwK_KB_61_2_cov.pdf", width=5, height=3)
plot
dev.off()

png(filename="refDeep_094_05_readNwK_KB_61_2_cov.png", width=2500, height=1500)
plot
dev.off()



