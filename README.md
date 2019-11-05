Ecom UI tests based on Selenium
==============

Install Dependencies:
--------------
```bash
gem install bundler
bundler install
```

Environment setup:
------------------
* Please make sure you have installed Chrome or Firefox to be able to run tests on those platforms


Command line options:
------------------
* Basic command to run the test:
```bash
bundle exec cucumber --tags @feature.scenario ENVIRONMENT=prod BROWSER=chrome BROWSER_OPTIONS="disable_image" ATTACH_SCREENSHOT=true -f AllureCucumber::Formatter
```

Where:

```bash
--tags @login.registered_user: tag of the test you want to run
ENVIRONMENT: prod
browser: can be chrome/firefox
BROWSER_OPTIONS: must be passed as a string. Avaialble options: disable_image (to disable browser image loading)/headless (to run the browser headlessly)
For example: "disable_image,headless" will both disable loading image and make the browser run headlessly
ATTACH_SCREENSHOT: can be true/false, to have attached in allure report or not
-f AllureCucumber::Formatter: keep it if you want to run test with allure report, otherwise report is not generated 
```
