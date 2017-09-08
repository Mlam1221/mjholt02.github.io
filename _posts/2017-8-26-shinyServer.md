---
title: 'Shiny Server and Rstudio setup on Ubuntu 16.04.3'
tags: [R, Shiny, Rstudio]
---

I was fortunate enough to stumble across a great guide over at 
[<u>this site</u>](http://deanattali.com/2015/05/09/setup-rstudio-shiny-server-digital-ocean/). Below is basically a modified 
version that I've used recently to deploy a shiny server on Digital Ocean using Ubuntu 16.04.3 and my DB driver as SQL Server.

``` bash

##add a new user so you're not root all the time
adduser <name>
gpasswd -a <name> sudo
su - <name>

##Install nginx
sudo apt-get update
sudo apt-get -y install nginx

##Install R
sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -

sudo apt-get -y install r-base


##Create swap disc since our RAM is really small
sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024;
sudo /sbin/mkswap /var/swap.1;
sudo /sbin/swapon /var/swap.1;
sudo sh -c 'echo "/var/swap.1 swap swap defaults 0 0 " >> /etc/fstab'

##install Rstudio server
sudo apt-get install gdebi-core;
wget https://download2.rstudio.org/rstudio-server-1.0.153-amd64.deb;
sudo gdebi rstudio-server-1.0.153-amd64.deb

##install dependencies and R libraries
sudo apt-get install libcurl4-openssl-dev
sudo apt-get install libxml2 libxml2-dev
sudo su - -c "R -e \"install.packages(c('rmarkdown','shiny','shinyjs','knitr'), repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages(c('RODBC','tidyverse','lubridate','stringr','forcats','hms'), repos='http://cran.rstudio.com/')\""

##install shiny server
sudo apt-get install gdebi-core
wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.3.838-amd64.deb
sudo gdebi shiny-server-1.5.3.838-amd64.deb


##create a permissions group and apply to folder so <name> can access the server folder
sudo groupadd shiny-apps
sudo usermod -aG shiny-apps <name>
sudo usermod -aG shiny-apps shiny
cd /srv/shiny-server
sudo chown -R <name>:shiny-apps .
sudo chmod g+w .
sudo chmod g+s .




##Install Microsoft® ODBC Driver 13.1 for SQL Server
#Follow instructions here:https://www.microsoft.com/en-us/download/details.aspx?id=53339

sudo su  
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - 
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > etc/apt/sources.list.d/mssqlrelease.list 
exit 
sudo apt-get update 
sudo ACCEPT_EULA=Y apt-get install msodbcsql=13.1.4.0-1  
sudo apt-get install unixodbc-dev 
```
