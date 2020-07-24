# Pollencount

Counting pollen from a slide under a microscope can be hard to learn. This simulation tool aims to help students and researchers to start to see what pollen looks like under the microscope, and start to identify common pollen grains. Some grains are more difficult than others, and this is also simulated. The user can see how well they did in identifying the pollen grains. Photos of pollen grains were found using google, but they can be replaced with other photos/databases.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

You need to have a recent version of R installed (best >= 4.0.0), and have sufficient user privileges to be able to install additional R packages. 

### Installing

Within R, type the following commands:

To install the *devtools* R package (if you haven't already done so):
```
install.packages('devtools')
```

Then load devtools:
```
library(devtools)
```

Now you should be able to install packages that are hosted on github, such as pollencount:
```
install_github('maarten14C/pollencount')
```

Next, load the package into your session:
```
library(pollencount)
```

## Running pollencount

Now we're going to simulate a slide view with 50 randomly selected pollen types. For now, pollencount uses an in-built very basic and small database of pictures of only 4 pollen types (*Quercus*, *Pinus*, *Alnus*, *Poaceae*), with only a few photos for each pollen type. By default, only 50 types are selected randomly (according to the proportions listed in the file proportions.csv; see later). The command to simulate a slide is:

```
slide()
```

The small database that comes with this package could either be expanded in the future, or more likely you can build your own database and link to it, through providing the directory of the database (in this example it's at "~/MyPollenPictures"):
```
slide(dirloc="~/MyPollenPictures")
```
The database should have folders containing the photos of the pollen types. The name of each folder is the name of the pollen type. The photos should be saved, within their respective folder, as .png or .jpg files. Also provide a file proportions.csv in the top folder, which gives the to-be-simulated proportions of each pollen type. In the example database, this causes *Pinus* grains to be simulated at 10% abundance, *Alnus* at 30%, etc. 

You can change the number of simulated grains to, say, 100:
```
slide(n=100)
```

Now it's time for you to have a go at identifying some of the pollen grains in this slide, i.e., count them. By default, we count *m=10* at a time.
```
count()
```

Click on the device which shows the pollen grains, then once your cursor has changed to a + (or something similar), click on one of the grains to identify it. A list of options will appear in the terminal. Select the number of the pollen type you think it is, and press enter. Then click on another grain and repeat the identification process until you've counted 10 grains. 

At the end, a list will appear telling which grains you got wrong, and which ones correct for each of the pollen types in the database.

## Versioning

This is version 0.1.0

## Authors

* **Maarten Blaauw** - *Initial work* - [https://github.com/maarten14C] [www.qub.ac.uk/chrono/blaauw]

This package is inspired by the *colpol* pollen counting software developed by Dr. Jane Bunting at the University of Hull. This package is aimed to provide an open-source, more platform-independent approach to learning pollen counting. 

## License

This project is licensed under the MIT licence.

## Acknowledgments

* Dr. Jane Bunting [https://www.hull.ac.uk/staff-directory/jane-bunting] for the original idea
* the ViPs Network [https://virtualpalaeoscience.wordpress.com/] 
