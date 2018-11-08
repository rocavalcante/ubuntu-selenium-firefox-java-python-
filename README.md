IMAGE from ubuntu16.04

Packages Installed:

    * JAVA 8;
    * Firefox;
    * vim;
    * Geckodriver;
    * Selenium web driver;
    * git;
    * pip;
    * virtualenv;
    * python-3.6;

Ports:

    `Selenium`: 4444:4444;
    `app`: 8080:8080;

#Download IMAGE

docker pull rodrigoibka/ubuntu-selenium-firefox-node-webdriver

#Test IMAGE
`docker run --name foobar --rm -p 8080:8080 -p 4444:4444 -it rodrigoibka/ubuntu-selenium-firefox-node-webdriver:1.0 /bin/bash`

And HAVE FUN :)
