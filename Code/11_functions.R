#code to build your own functions

somma <- function(x,y) {
  z=x+y
  return(z)
  }

#exercise: make a new function called differenza
differenza <- function(x,y) {
  z=x-y
  return(z)
  }

mf <- function(nrow,ncol) {
  par(mfrow=c(nrow,ncol))
  }

positivo <- function(x) {
  if(x>0) {
    print("Questo numero è positivo")
    }
  else if(x<0) {
    print("Questo numero è negativo")
    }
  else if(x==0) {
    print("Questo numero è stato dimenticato da Dio")
    }
  }
  
