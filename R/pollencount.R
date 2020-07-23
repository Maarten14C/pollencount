#' pollencount
#'
#' Simulate the counting of pollen or other palaeoecological 'proxies'
#' This package is meant to facilitate learning to identify pollen or other microfossils under microscope slides. It is not a replacement of the real thing, as in counting real pollen under a real microscope, but aims to introduce students and researchers to how a slide of pollen grains could be identified. Possibly helpful therefore for on-line teaching.
#' This package was inspired by a (closed-source) software to simulate pollen counting, developed by Dr Jane Bunting (University of Hull, UK) and presented at the virtual Palaeoscience Workshop https://virtualpalaeoscience.wordpress.com/ in May, 2020.
#' @docType package
#' @author Maarten Blaauw <maarten.blaauw@qub.ac.uk>
#' @importFrom graphics plot points 
#' @importFrom stats runif
#' @importFrom utils read.table packageName select.list
#' @importFrom graphics locator rasterImage
#' @importFrom jpeg readJPEG
#' @importFrom png readPNG
#' @importFrom caTools read.gif write.gif
#' @importFrom magick image_read image_write
#' @name pollencount
NULL  

# do: make a larger (and higher-quality) image pop up of the selected grain? Would cause issues with getting back to the original device...

# done: automatically produce thumbnails to load images faster

# internal function to speed up the plotting of images, by producing smaller gifs of them
make_thumbnails = function(dirloc=c(), size="100x100") {
  if(length(dirloc) == 0) # if not provided by the user, then use the photos of the package
    dirloc = system.file("extdata", package="pollencount")

  folders = list.dirs(paste0(dirloc, "/images"), full.names=FALSE)
  folders = folders[-which(folders=="")]
  for(i in folders)  {
    if(!dir.exists(paste0(dirloc, "/thumbnails/", i)))
      dir.create(paste0(dirloc, "/thumbnails/", i)) # make thumbnail folders if required

    files = list.files(paste0(dirloc, "/images/", i, "/"))
    for(j in files) {
      if(length(grep(".jpg", j)) > 0)  ext = ".jpg" else
        if(length(grep(".jpeg", j)) > 0)  ext = ".jpeg" else
          if(length(grep(".png", j)) > 0)  ext = ".png" else
            stop("unexpected file names, should be .jpg, .jpeg or .png (note lowercase)", FALSE)
    base = strsplit(j, ext)[[1]][1]  # filename without the extension
    img =  image_read(paste0(dirloc, "/images/", i, "/", j)) # read the image
    image_write(image_scale(img, size), # write a thumbnail of the image
      paste0(dirloc, "/thumbnails/", i, "/", base, ".png"), format="png")
    }
  }
}
 


#' @name slide
#' @title Simulate a slide of pollen grains
#' @description Simulate a slide of pollen or other palaeoecological 'proxies', to be counted by the user
#' @details This is the first function to type. Simulates a slide with randomly chosen pollen grains. These are chosen from folders of photos. The same folder should have a file proportions.csv, which has two columns: the names of the types (e.g., Quercus, Pinus), and their proportions among the population of sampled pollen.
#' @param n the number of pollen grains to simulate
#' @param dirloc the location of the folder with images (...). Currently the folder is filled with only a few pollen types and each folder has only a few roughly selected images of the pollen type as downloaded from various google searches. For future development, this would require more official sources.
#' @param size the size of the photos as drawn on the device. Keep small for slightly more realistic simulations of the real thing. 
#' thumb size of the thumbnail photos
#' @examples 
#' slide(20)
#' @export
slide = function(n=50, dirloc=c() , size=0.05, thumb="100x100") {
  # location of the photos of the pollen or other proxies
  # This folder should contain a folder 'images', which contain folders with the pollen types, and in those folders are multiple images of said pollen types. 
  # Some photos could be made be more difficult to ID than others - this still needs work. Identify difficulty with a code in the photo's filename? Or simply have a constant mix of easy and difficult grains in the folders?
  if(length(dirloc) == 0) # if not provided by the user, then use the photos of the package
    dirloc = system.file("extdata", package="pollencount")
    
  make_thumbnails(dirloc, thumb)  # make smaller images so they load faster

  # proportions of the pollen types to be drawn randomly from the pictures. Column 1 contains the type names, column 2 their proportions. Separated by commas. The proportions do not necessarily have to sum to 1
  #  this file should live in the folder of dirloc, next to (but not within) the folder 'images'
  # It is very important that the names of the types in the proportions.csv file coincide exactly with the names in the folders living in the 'images' folder!
  props = read.table(paste0(dirloc, "/proportions.csv"), sep=",")
  props = props[order(props[,1]),] # sort alphabetically

  # now find the different types, located as folders within the umbrella folder 'images'
  types = list.dirs(paste0(dirloc, "/thumbnails"), full.names=FALSE)
  types = types[-which(types=="")]
  types = sort(types) # sort alphabetically
  
  # simulate which grains will be visible in the 'field'
  polsim = sample( 1:length(types), size=n, replace=TRUE, prob=props[,2] )

  # now get the photos for each simulated grain
  photos <- c()
  for(i in 1:n) {
    files = list.files(paste0(dirloc, "/thumbnails/", types[ polsim[i] ]), full.names=TRUE)
    photos[i] = files[sample(1:length(files), 1)]
  }
  
  photos <<- photos
  
  # simulate the x and y locations of the grains on the slide
  xloc = runif(n)
  yloc = runif(n)

  # save the simulation for future use (e.g., IDing)
  dat = list(dirloc=dirloc, types=types, photos=photos, polsim=polsim, xloc=xloc, yloc=yloc)
  .assign_to_global('info', dat)
  
  # plot the photos of the pollen grains
  plot(0, type="n", xlim=c(0,1), ylim=c(0,1), xlab="", ylab="")  
  for(i in 1:n)
    rasterImage(image_read(photos[i]),
      xloc[i]-size, yloc[i]-size, xloc[i]+size, yloc[i]+size)
}



#' @name select
#' @title Select a single grain
#' @description Select one of the grains simulated by the 'slide' function
#' @details Select one of the grains. This activates a selection feature where you click once with the pointer on one of the grains. This grain is then selected. 
#' @return the type selected (invisible) and its coordinates
#' @param dat the underlying locations and names of the simulated grains
#' @export
select = function(dat=info) {
  if(!interactive())
    message("This function can only run in an interactive session.")	
  loc = unlist(locator(1)) # click once on the 'slide' to select a grain
  x = dat$xloc - loc[1]
  y = dat$yloc - loc[2]
  pyth = sqrt(x^2 + y^2) # distance between the clicked point and each grain...
  this = which(pyth == min(pyth) ) # ... closest grain wins!
  invisible(c(dat$polsim[this], loc)) # return the chosen type (number) and its location
}
 
 
 
#' @name ID
#' @title Identify a single grain
#' @description Identify the selected grain
#' @details Gives you the opportunity to interactively try and identify a specific grain. 
#' @return Whether or not the grain was identified correctly
#' @param dat the underlying locations and names of the simulated grains
#' @param mark Draw a green tick mark or red cross for correctly or wrongly identified grains. Set to FALSE for no drawing
#' @param cex size of the tick mark or cross
#' @param graphics Use a fancy list (default is to use the basic one within the R terminal)
#' @export
ID = function(dat=info, mark=TRUE, cex=2, graphics=FALSE) {
  if(!interactive())
    message("This function can only run in an interactive session.")	
  this = select(dat) # select a grain
  ans = select.list(dat$types, graphics=graphics) # choose the pollen type you think it is
  ans = which(dat$types == ans) # not the name but the number of the pollen type
  if(this[1] == ans) { # answer matches the selected grain's type 
      message(dat$types[ans], " is correct!") 
      if(mark)
        points(this[2], this[3], pch="v", col="green", cex=cex)
      return(this[1])
    } else {
        message("Sorry, it's not ", dat$types[ans])
        if(mark)
          points(this[2], this[3], pch="x", col="red", cex=cex)
        return(0)
      }
  }



#' @name count
#' @title Count several grains
#' @description Count several grains and obtain the results
#' @details Gives you the opportunity to interactively try and identify a number of  pollen grains. 
#' @return A list of pollen types and how many of each were identified correctly
#' @param m The number of grains to be identified
#' @param dat the underlying locations and names of the simulated grains
#' @param mark Draw a green tick mark or red cross for correctly or wrongly identified grains. Set to FALSE for no drawing
#' @param cex size of the tick mark or cross
#' @param graphics Use a fancy list (default is to use the basic one within the R terminal, but you could try tcltk)
#' @param round rounding of percentage, default 0 digits
#' @export
count = function(m=10, dat=info, mark=TRUE, cex=2, graphics=FALSE, round=0) {
  if(!interactive())
    message("This function can only run in an interactive session.")	
  message("Click on a grain, choose among the list, click on another grain, etc., until you're finished")
  result = numeric(m)
  for(i in 1:m)
    result[i] = ID(dat, mark, cex, graphics)

  out = numeric(length(dat$types)+1)
  for(i in 0:length(dat$types))
    out[i+1] = length(which(result == i))
  out = cbind(c("(wrong)", dat$types), as.numeric(out))
  colnames(out) = c("type", "count")
  return(noquote(out))
}



globalVariables("info")
# internal function, copied from my clam package
# function to load results into global environment
# parameter position defaults to 1, the global environment
.assign_to_global <- function(key, val, pos=1)
  assign(key, val, envir=as.environment(pos) )
