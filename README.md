# Pollencount

Counting pollen from a slide under a microscope can be hard to learn. This simulation tool aims to help students and researchers to start to see what pollen looks like under the microscope, and start to identify common pollen grains. Some grains are more difficult than others, and this is also simulated. The user can see how well they did in identifying the pollen grains. Photos of pollen grains were found using google, but they can be replaced with other photos/databases.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

You need to have a recent version of R installed (best >= 4.0.0), and have sufficient user privileges to be able to install additional R packages. 

### Installing

Within R, type the following commands:

To install the $devtools$ R package (if you haven't already done so):
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

Now we're going to simulate a slide view with 50 randomly selected pollen types. For now, pollencount uses an in-built very basic and small database of pictures of only 4 pollen types (Quercus, Pinus, Alnus, Poaceae), with only a few photos for each pollen type. By default, only 50 types are selected, randomly (according to the proportions listed in the file proportions.csv; see later). The command to simulate a slide is:

```
slide()
```

The small database that comes with this package could either be expanded in the future, or more likely you can build your own database and link to it, through providing the directory of the database (in this example it's at "~/MyPollenPictures"):
```
slide(dirloc="~/MyPollenPictures")
```
The database should have folders containing the photos of the pollen types. The name of each folder is the name of the pollen type. Also provide a file proportions.csv in the top folder, which gives the to-be-simulated proportions of each pollen type. In the example database, this causes /Pinus/

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc

