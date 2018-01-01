## Prerequisite
Download and install virtualbox (https://www.virtualbox.org/)
Download and install vagrant (http://vagrantup.com)

## Summary

This project simulates real world problems a Dev/Ops Engineer may face and have to solve. With this utilities one can create sandbox with a single command which will have a sample flask app which will show memcached stats, apache webserver with ssl. 


```vagrant up``` cammand will launch the vagrant VM with CentOS 6 (Note: this will take some time to download the VM image the first time)
That's all.... vagrant up cammand will ensure VM is up, httpd and memcached are installed, apache is running and you should be able to see a test page going here in your browser: https://localhost:8080/app . It will reconfigure apache to run using HTTPS rather than HTTP. Any HTTP links will redirect to HTTPS. You should be able to see the exact same test page as above by going here in your browser: https://localhost:8443/app
You will get an exception about an insecure connection due to the self-signed cert. Feel free to ignore this.
It will also add a cronjob that runs with script name /home/vagrant/exercise-memcached.sh which will run once per minute # Modify it as per you requirement if you need it.
Python (flask) web application outputs memcached stats along with following -
		- It will additionally calculate the "get" hit rate and show it as a percentage ("X% of gets missed the cache") 
    - It will additionally show the percentage of memcached memory used 




## Steps to follow :

### Clone repo and change working directory to cloned repo directory
```
git clone git@github.com:AkshaySiwal/akshay_assignment.git
cd akshay_assignment/
```

### Run vagrant up to create virtual machine
```
vagrant up
```

### Open browser and access flask tool [Click Here][flask-url]
```
https://localhost:8443/app/ 
```

<a href="https://github.com/AkshaySiwal/akshay_assignment/blob/master/static_file/web_page.png"><img align="right" src="https://github.com/AkshaySiwal/akshay_assignment/blob/master/static_file/web_page.png" width="100%" alt="App page"/></a>




[flask-url]: https://localhost:8443/app/
