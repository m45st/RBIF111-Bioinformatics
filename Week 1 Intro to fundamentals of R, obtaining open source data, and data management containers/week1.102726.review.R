#102626
#packagae data

ggplot(iris, aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
  geom_point()

#loops and seqs.

var1 <- 1
for ( i in 1:5) var1+1

x <- 1
for ( i in 1:3 ) x+i

Inf-Inf #NaN

is.na(NA) # this is how we check if an object is NA!!

x <-c(3,5)
if ( any(x > 4) )"apples" else "oranges" # curly braces optional

if( any(x>6)){
  "apples"
}else{
  "oranges"
}


if( any( x>4)){
}else{
  x <- x*2
  print(x)
}


samp <- c(3,4,5,7,8,10)
ifelse( samp>5, "apples", "oranges" ) #fx


for ( i in 1:3 ) print(paste("iteration",i))

#scope is not applied to variables in R unlike in python, but local in function defs


i <- 1; while( i<5){print(i);i <- i+1
}
i # 5

#functions



my.max <- function( x , na.rm = F){
  x.max <- 0
  for( i in x){
    if(is.na(i)){
      if(na.rm){
        next
      }else{
        return(NA)
      }
    }
  }
  if (i > x.max){
    x.max <- i
  }
  return (x.max) # return max value
}



# || logical OR for single operands
# |. logical OR for e-by-e opernads

fx <- function(x, y = some.function(), z = some.var){
  if( x == 0) print("done")
  if( x == 1) print(y)
  if( x == 2) print(z)
}

fx(0) # first if gets executed

#trad loops vs vectors



clrs <- c("red","blue","gray","pink","cyan"); clrs

y = 2:6;y

clrs[c(T,F)]

names(y) <- clrs; y


dfr = c(1,1,2,1 , NA)
dfr
dfr[2]

tot =0
for( e in dfr){
  tot = tot+e
}
df_mean = tot / length(dfr)

mean(dfr)





