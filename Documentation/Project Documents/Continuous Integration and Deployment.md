# Continuous Integration and Deployment Documentation

This document outlines the process and tools used for continuous integration and continuous deployment ( CI/CD ) for Lucidify website.

## Table of Contents

- [Continuous Integration and Deployment Documentation](#continuous-integration-and-deployment-documentation)
    - [Table of Contents](#table-of-contents)
    - [Overview](#overview)
    - [Stages](#stages)
        - [Build](#build)
        - [Testing](#testing)
            - [Unit](#unit)
            - [Integration](#integration)
        - [Deploy](#deploy)
    - [Glossary](#glossary)

## Overview

The continuous integration and deployment is performed using GitLab CI/CD which is configured with a .yml file. The CI/CD process is ran on GitLab shared runners that invokes a pipeline run every time a change is pushed to a given branch. The process is split into three separate stages: build, testing and deploy. Each stage cannot be invoked without the other passing and the final stage deploys, artifacts gathered in the build stage, directly to the live site.

## Stages

The CI/CD process is split into three stages. The build, testing and deploy stages. Whenever a change is pushed to a branch these stages are invoked respectively and the next stage cannot be invoked without the previous stage having passed. On each push the build stage is initially ran and when it passes the testing stage is started. When a change is pushed directly to the master branch, upon successful passes from both the build and testing stages, a manual deploy stage is available.

![CI/CD Stages](/Images/CI%20Documentation/ci%20stages.png)

### Build

The build stage consists of installing all necessary dependencies and running a full build process for the Lucidify Vue.js application. Upon successful build the required artifacts for a front-end deploy are gathered into one folder and stored for later. This stage ensures there are no underlying issues with the app itself, that it conforms to a Vue.js application and gathers all artifacts for the deploy stage.

### Testing

The testing stage is invoked after a successful build of the application in the build stage. It consists of two sub-stages: Unit and Integration testing that are both ran in parallel. This stage ensures that the application is working as intended and all tests pass before a deploy is available.

#### Unit

The unit testing stage ensures a set of unit tests fully passes. The unit tests are written in JavaScript Mocha and ran using Karma.js. Unit tests are used to verify correct functionality of internal software or source code functions or procedures.

#### Integration

The integration testing stage runs a series of end-to-end tests that ensure the UI of the application is functioning as desired. The integration tests are written in Nightwatch.js and ran using Selenium server and a headless Chrome browser. Integration tests are used to verify the UI of the application and the functionality of methods and procedures working in unison.

### Deploy

The deploy stage consists of gathering the build artifacts collected in the build stage and adding it directly to the Amazon S3 bucket for the live site. This stage is only invoked when a change is pushed to master and the previous stages have passed. Additionally this stage has a manual invoke, meaning upon success of the previous stages this stage becomes available but does not automatically deploy to S3 unless directly clicked by a developer. This eliminates any unnecessary or unwanted deploys when pushing to master.

## Glossary

- **GitLab** - Version control tool used for Lucidify project. GitLab CI/CD is a set of internal used provided by GitLab for Continuous Integration and deployment.
- **.yml file** - File type used for CI/CD configuration.
- **Vue.js** - Frontend framework used for Lucidify project. Mentioned for clarification on specificity of artifacts produced in build stage.
- **Karma.js** - Execution and reporting tool for unit tests.
- **Mocha** - JavaScript Unit testing framework.
- **End-to-end** - Testing methodology describing testing the flow of an application from end to finish.
- **Nightwatch.js** - JavaScript end-to-end or Integration testing framework.
- **Selenium** - Web browser automation tool used for end-to-end testing
- **Headless Chrome** - Method of running Chrome Web browser in a headless environment.
- **Amazon S3 bucket** - Amazon's web site storage service. Where the Lucidify web site is stored.