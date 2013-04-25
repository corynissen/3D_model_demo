
library(rgl)

file <- "data.txt"
smooth <- TRUE

# this data file is a list of heights... z
# x and y are not given, I just create matrices for them
z <- read.delim(file, header=F, sep="|")
z[,1] <- NULL  # first column is all nulls... junk
z <- as.matrix(z)

z1 <- dim(z)[1]
z2 <- dim(z)[2]

# x and y are just indices, fabricated x,y data
x1 <- seq(1, z2*2, 2)
x <- t(matrix(rep(x1, z1), nrow=z2, ncol=z1))
y <- matrix(rep(seq(1,z1*2,2), z2), z1, z2)

zlim <- range(z)
zlen <- zlim[2] - zlim[1] + 1
     
colorlut <- terrain.colors(zlen) # height color lookup table
    
col <- colorlut[ z-zlim[1]+1 ] # assign colors to heights for each point

# laser scanner was too bumpy... smooth out some crazy readings.
if(smooth){
  z[z<800] <- 1000
  z[z>1300] <- 1000
  z <- z/10
}

rgl.open()
rgl.surface(x, y, max(z)-z, color=col, back="lines")
