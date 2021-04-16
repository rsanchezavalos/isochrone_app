# isochrone_app

## Overview

### Installation Guide
---
Using the rocker/rstudio container

#### Using the rocker/geospatial image

##### Quickstart

Build image (aprox 5 GB)

```
    docker build --tag rocker_geospatial  . 
```

Run container

```
    sudo docker run -d -p 8787:8787 -e ROOT=TRUE  -e PASSWORD=geotest -v $(pwd):/home/rstudio rocker_geospatial
```

Visit `localhost:8787` in your browser and log in with username `rstudio` and the password you set. **NB: Setting a password is now REQUIRED.**  Container will error otherwise.

