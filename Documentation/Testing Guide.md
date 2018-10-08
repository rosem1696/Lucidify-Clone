# Testing Guide

This document outlines the testing process for Lucidify, provides basic explanation and a step by step guide on how to create and run those tests.

## Table of Contents

- [Testing Guide](#testing-guide)
    - [Table of Contents](#table-of-contents)
    - [Overview](#overview)
    - [Unit Tests](#unit-tests)
        - [Writing Unit Tests](#writing-unit-tests)
        - [Running Unit Tests](#running-unit-tests)
        - [Understanding Unit Test Results](#understanding-unit-test-results)
    - [Integration Tests](#integration-tests)
        - [Writing Integration Tests](#writing-integration-tests)
            - [Writing a simple test](#writing-a-simple-test)
            - [Creating a Page Object](#creating-a-page-object)
                - [Simple Page Object](#simple-page-object)
                - [Sections](#sections)
                - [Commands](#commands)
            - [Custom assertions](#custom-assertions)
        - [Running Integration Tests](#running-integration-tests)
        - [Understanding Integration Tests Results](#understanding-integration-tests-results)

## Overview

The Lucidify project incorporates both unit and integration tests. The unit tests ensure functionality of internal methods and procedures and the integration tests provide an end-to-end functionality check on the UI level. Both type of tests are ran using continuous integration but can also be ran locally. This document will outline a step by step guide on how those tests are written and executed as well as understanding the results.

## Unit Tests

The unit tests ensure the individual internal functions of the Lucidify application are executing correctly. For the Lucidify project these tests are written in JavaScript using Mocha framework and ran with Karma.js. See links below for Mocha and Karma.js.

To learn more about Mocha framework: [Mocha](https://mochajs.org).

To learn more about Karma.js: [Karma.js](https://karma-runner.github.io/2.0/index.html).

### Writing Unit Tests

All unit tests are located in the Lucidify unit test folder under specs:

``` html
.../website/lucidify/test/unit/specs
```

All tests added to the specs folder will be ran by the CI and the local test command. In order to write a new test, create a new `.js` file in the specs folder.

In order to write a new unit test:

1. Create a new `.js` file in the specs folder under unit.
2. Encompass tests in a `describe` function that wil describe the tests.
3. Create an `it` function that will be the test itself.
4. Assert functionality.

Simple Mocha test example:

```javascript
var assert = require('assert');
describe('Array', function() {
  describe('testIndexOf', function() {
    it('should return -1 when the value is not present', function() {
      assert.equal([1,2,3].indexOf(4), -1);
    });
  });
});
```

Result:

```bash
Array
    testIndexOf
      ✓ should return -1 when the value is not present


  1 passing (9ms)
  ```

As seen in the above example `describe('testIndexOf', function() {}` is a test function declaration with `testIndexOf` being the name of the function that is also displayed during output.

`it('should return -1 when the value is not present', function() {}` is the test function itself with the text to be displayed for that test assert.

As seen in the example below `function()` can be replaced with just `()=>`

Example testing for web elements:

```javascript
import Vue from 'vue'
import navbar from '@/navbar'

describe('navbar.vue', () => {
  it('should render correct contents', () => {
    const Constructor = Vue.extend(navbar)
    const vm = new Constructor().$mount()
    expect(vm.$el.querySelector('.navbar-brand').textContent)
      .to.equal('Lucidify')
  })
})
```

When writing tests for certain web elements don't forget to import `vue` and the class you are testing against.

### Running Unit Tests

Every unit test that is added to the unit specs folder will be ran during the CI unit testing stage. Additionally unit tests can be ran locally using the command: `npm run unit`.

In order to run tests locally, in a command window:

1. Navigate to Lucidify folder.
2. Ensure all dependencies are installed ( run `npm install` if not ).
3. Run `npm run unit`.

Any run configurations can be modified by editing the karma.conf.js file located in the unit tests folder.

### Understanding Unit Test Results

The results of the unit tests consists of a command window output and coverage report( only local ). These can be viewed both on the CI and locally. This outputs the number of successes and failures as well as the success or failure state of each test. Additionally it outputs a short coverage report. When the tests are ran locally a full coverage report is generated and placed in the unit tests folder.

Example result

```bash
12 03 2018 20:09:00.809:INFO [karma]: Karma v1.7.1 server started at http://0.0.0.0:9876/
12 03 2018 20:09:00.809:INFO [launcher]: Launching browser PhantomJS with unlimited concurrency
12 03 2018 20:09:00.819:INFO [launcher]: Starting browser PhantomJS
12 03 2018 20:09:13.568:INFO [PhantomJS 2.1.1 (Windows 8.0.0)]: Connected on socket e-U4lQO0IFgZbpJKAAAA with id 37589288

  navbar.vue
    √ should render correct contents

PhantomJS 2.1.1 (Windows 8.0.0): Executed 1 of 1 SUCCESS (0.03 secs / 0.019 secs)
TOTAL: 1 SUCCESS


=============================== Coverage summary ===============================
Statements   : 100% ( 0/0 )
Branches     : 100% ( 0/0 )
Functions    : 100% ( 0/0 )
Lines        : 100% ( 0/0 )
================================================================================
```

## Integration Tests

The integration tests ensure the UI of the application functions correctly by automating tasks that would be performed by a user. These tests are written in JavaScript using Nightwatch.js framework and ran with Selenium webdrivers. See below links for Nightwatch.js and Selenium.

To learn more about Nightwatch.js: [Nightwatch.js](http://nightwatchjs.org).

To learn more about Selenium: [Selenium](https://www.seleniumhq.org/).

### Writing Integration Tests

All integration tests are located in the lucidify e2e test folder under specs

```html
.../website/lucidify/test/e2e/specs
```

All tests added to the specs folder will be ran by the CI and the local test command. In order to write a new test, create a new `.js` file in the specs folder.

#### Writing a simple test

1. Create a new `.js` file in the specs folder e.g `welcomeScreenTests.js`.
2. Encompass all tests in `module.exports = {}`.
3. Create a function e.g `Welcome Screen tests`. (see example below for syntax)
4. Use `browser` as the default object to test against.
5. Navigate to the desired url (in the example the default `devServerUrl` is used, which is `localhost:8080`)
6. Assert elements
7. **Always** close your tests with the `.end()` method to properly close the selenium session.

Example of simple test:

```javascript
module.exports = {
  'Welcome Screen tests': function (browser) {
    const devServer = browser.globals.devServerURL

    browser
      .url(devServer)
      .waitForElementVisible('#app', 5000)
      .assert.elementPresent('#welcomeMain')
      .assert.containsText('h1', 'A listening habits visualizer for Spotify users')
      .end()
  }
}
```

More info on using nightwatch: [Using Nightwatch](http://nightwatchjs.org/guide/#using-nightwatch).

#### Creating a Page Object

##### Simple Page Object

Page objects are objects with properties that describe the page. This is a good way of separating and organizing elements and should always be used when page elements are static and known.

1. Create a new `.js` file in the page-objects folder (`.../website/lucidify/test/e2e/page-objects`).
2. Name the file `welcomeScreen.js`.
3. Create an array of elements with their corresponding selectors.

Example of page object:

```javascript
module.exports = {
  elements: {
    welcome: '#welcome',
    background: '#background',
    main: '#welcomeMain',
    about:'#aboutLucidify'
  }
};
```

In order to use the created page object it must be initialized in your test. Then you can refer to the elements created in the object using `@`, as seen in the example below.

Example of test with page object:

```javascript
module.exports = {
  'welcome screen tests': function (browser) {
    const devServer = browser.globals.devServerURL

    //initialize page object
    var welcomeScreen = browser.page.welcomeScreen();

    browser
      .url(devServer)
      .waitForElementVisible('#app', 5000);

    //assert welcome screen main element
    welcomeScreen
      .assert.elementPresent('@main')
      .assert.containsText('h1', 'A listening habits visualizer for Spotify users');

    browser.end();
  }
}
```

**Don't** forget the `.end()` method!!

##### Sections

Additionally sections can be defined for element-level nesting.

Example of sections:

```javascript
module.exports = {
  sections: {
    welcomeMain :{
      selector: '#welcomeMain',
      elements: {
        welcomeMessage: '#welcomeMessage'
      }
    }
  }
};
```

Using in tests:

```javascript
module.exports = {
  'welcome screen tests': function (browser) {
    const devServer = browser.globals.devServerURL
    var welcomeScreen = browser.page.welcomeScreen();

    //initialize section object
    var main = welcomeScreen.section.welcomeMain;

    browser
      .url(devServer)
      .waitForElementVisible('#app', 5000);

    main
      .assert.elementPresent('@welcomeMessage');

    browser.end();
  }
}
```

**Warning**: Don't forget to add a selector for the section itself!

##### Commands

You can add commands to your page object in order to encapsulate some of your logic that would otherwise be in the test itself.

Example page object with command:

```javascript
module.exports = {
  sections: {
    welcomeMain :{
      selector: '#welcomeMain',
      elements: {
        welcomeMessage: '#welcomeMessage'
      }
    }
  },
  elements: {
    welcome: '#welcome',
    main: '#welcomeMain',
    about:'#aboutLucidify',
    app: '#app'
  }
};

var welcomeCommands = {
  waitForPage: function() {
    this.waitForElementVisible('#app', 5000);
  }
};
```

Example use in test:

```javascript
module.exports = {
  'welcome screen tests': function (browser) {
    const devServer = browser.globals.devServerURL
    var welcomeScreen = browser.page.welcomeScreen();
    var main = welcomeScreen.section.welcomeMain;

    browser
      .url(devServer);

    //use the command
    welcomeScreen.waitForPage;

    main
      .assert.elementPresent('@welcomeMessage');

    browser.end();
  }
}
```

More information on nightwatch page objects: [nightwatch page objects](http://nightwatchjs.org/guide/#page-objects).

#### Custom assertions

Sometimes the simple assertions provided are not sufficient enough and custom assertions need to be created. In order to create a custom assertion:

1. Create a new `.js` file in the custom-assertions folder (``.../website/lucidify/test/e2e/custom-assertions``).
2. Extend the `.assert` or `.verify` namespaces.
3. Create a new command.

For more details on how to write custom assertions visit: [nightwatch custom assertions](http://nightwatchjs.org/guide#writing-custom-assertions).

### Running Integration Tests

Every integration test that is added to the e2e specs folder will be ran during the CI integration testing stage. The tests are ran using Selenium server and browser drivers to mimic actual user interaction with the site. The CI run launches a headless chrome browser directed to the localhost instance of the site for tests to run against. Additionally these tests can be ran locally. A local run involves launching a browser directed to the local instance of the site and running tests against that.

In order to run tests locally, in a command window:

1. Navigate to Lucidify folder.
2. Ensure all dependencies are installed( run `npm install`, if not ).
3. Run `npm run e2e`.

By default the tests are ran using a chrome browser but the tests can be ran using a different one by setting the specific environment.

Specific environment run

```bash
npm run e2e -- --env firefox
```

Any run configuration can be modified by editing runner.js and nightwatch.conf.js, both located in the e2e specs folder.

### Understanding Integration Tests Results

The results of the integration tests consist of console output with each assert and its fail or success status printed followed by the general fail or success status of all the tests, number of assertions failed and execution time. Each passing assertion is marked with a tick and each failed assertion is marked with an 'x'. In the case of the failed assertion the expected and actual result is printed, as seen in the examples below.

Example output with failed tests:

```bash
Starting dev server...
Listening at http://localhost:8080

Starting selenium server... started - PID:  3928

[Test] Test Suite
=====================

Running:  default e2e tests
 √ Element <#app> was visible after 49 milliseconds.
 √ Testing if element <#welcomeMain> is present.
 × Testing if element <h1> contains text: "A listening habit visualizer for Spotify users".  - expected "A listening habit visualizer for Spotify users" but got: "A listening habits visualizer for Spotify users"
    at Object.defaultE2eTests [as default e2e tests] (C:/Users/hackert/Documents/SeniorDesign/website/lucidify/test/e2e/specs/test.js:15:15)
    at _combinedTickCallback (internal/process/next_tick.js:73:7)

FAILED:  1 assertions failed and 2 passed (4.604s)
```

Example output with all tests passing:

```bash
Starting dev server...
Listening at http://localhost:8080

Starting selenium server... started - PID:  12952

[Test] Test Suite
=====================

Running:  default e2e tests
 √ Element <#app> was visible after 41 milliseconds.
 √ Testing if element <#welcomeMain> is present.
 √ Testing if element <h1> contains text: "A listening habits visualizer for Spotify users".

OK. 3 assertions passed. (3.546s)
```