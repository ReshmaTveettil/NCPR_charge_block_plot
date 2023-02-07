thisFile <- function() {
    cmdArgs <- commandArgs(trailingOnly = FALSE)
    needle <- "--file="
    match <- grep(needle, cmdArgs)
    if (length(match) > 0) {
        # Rscript
        return(normalizePath(sub(needle, "", cmdArgs[match])))
    } else {
        # 'source'd via R console
        return(normalizePath(sys.frames()[[1]]$ofile))
    }
}
script.dir <- dirname(thisFile())
setwd(script.dir)
print(getwd())




fileName <- "processed_files/header.txt"
conn <- file(fileName,open="r")
linn <-readLines(conn)
for (i in 1:length(linn)){
 t= print(linn)
pdf(paste(t[i], ".pdf", sep = "")) 
path<-paste("processed_files/acidic/", t[i] ,sep="")
path1<-paste("processed_files/basic/",t[i] ,sep="")
path2<-paste("processed_files/sliding_window/final-out_",t[i] ,sep="")
path3<-paste("processed_files/sliding_window/blocks/plot_acidic_patch_final-out_",t[i] ,sep="")
path4<-paste("processed_files/sliding_window/blocks/plot_basic_patch_final-out_",t[i] ,sep="")
 A = read.table(path)
 B = read.table(path1)
 D = read.table(path2)
 E = read.table(path3)
 G = read.table(path4)

 C = A$V3[1]
 x= A$V5+-9
 y = B$V5+9
 z= D$V5-5
 ap = E$V5-5
 bp = G$V5-5
 
 plot(A$V4, x, axes = F , xlim = c(0, C), ylim = c(-20,20), type = "h", col = "brown1", lwd = 1.5 ,  xlab = "", ylab = "", frame= F, xaxs="i", yaxs="i", main = t[i])
 
 lines(B$V4, y, col = "dodgerblue2", type = "h", lwd = 1.5)
 lines(z, D$V4, lwd =2, col = "black")
 abline(v = C, col = "black", lwd = 2, frame = T)
 points(bp, G$V6 , col = "darkblue", type = "p", lwd = 1.5, pch = "-", cex = 2)
 points(ap, E$V6 , col = "brown", type = "p", lwd = 1.5, pch = "-", cex = 2)
 
 
 abline(h = c(-10,0), col = "black", lwd = 2, frame = T)
 abline(h = c(10,0), col = "black", lwd = 2, frame = T )
 abline(h = c(-5,5), col = "black", lwd = 1, frame = T, lty= 3)
 abline(h = c(5,5), col = "black", lwd = 1, frame = T, lty= 3)
 #abline(h = c(-13,0), col = "black", lwd = 2, frame = T)
 #abline(h = c(13,0), col = "black", lwd = 2, frame = T)
 
 #axis(side=1 , pos = -10, lwd = 2)
 axis(side=2 , pos = 0, lwd = 2, ylim = c(-10,10))
 dev.off()
 }
 



