Ecom UI tests based on Selenium
==============
Demo stand: http://ec2-13-229-72-25.ap-southeast-1.compute.amazonaws.com:8080/job/run-tests/
Execution is done on AWS instances using dockerised Chrome browser.

Install Dependencies:
--------------
```bash
# Install RVM according to instructions for your system
# https://rvm.io/rvm/install
rvm install 2.6.5
rvm --default use 2.6.5
# navigate to a project dir
gem install bundler
bundler install
```

Environment setup:
------------------
* Please make sure you have installed Chrome or Firefox to be able to run tests locally.
* Or use docker in cloud: http://ec2-52-77-239-188.ap-southeast-1.compute.amazonaws.com:4444/wd/hub


Command line options:
------------------
* Basic command to run the test locally:
```bash
bundle exec cucumber --color -r features BROWSER=chrome BROWSER_OPTIONS="disable_image" -f pretty -f AllureCucumber::CucumberFormatter --out gen/allure-results
```
* Basic command to run the test on remote browser:
```bash
bundle exec cucumber --color -r features BROWSER=chrome BROWSER_OPTIONS="headless" REMOTE_URL="http://ec2-52-77-239-188.ap-southeast-1.compute.amazonaws.com:4444/wd/hub" -f pretty -f AllureCucumber::CucumberFormatter --out gen/allure-results
```

Where:

* --tags @conversion.basic_conversion # Tag of the test you want to run. Skip if you want to execute all
* BROWSER=chrome # Can be chrome/firefox. Currently tested only with Chrome
* BROWSER_OPTIONS="disable_image,headless" # Must be passed as a string. Avaialble options: disable_image (to disable browser image loading)/headless (to run the browser headlessly)
* -f pretty -f AllureCucumber::CucumberFormatter --out gen/allure-results # Formatters remove this part if you want to get standard Cucumber report

To generate Allure report:
* Install Allure-cli: https://docs.qameta.io/allure/#_installing_a_commandline
* Use Allure formatter during execution
* Run `allure serve gen/allure-results`

