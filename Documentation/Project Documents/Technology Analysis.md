# Lucidify - Technology Requirements and Analysis

A multitude of technologies needed to be decided on before development of the system could commence. Several criteria needed to be taken into consideration before making each decision. Some criteria were specific to the type of technology being chosen, and some were applicable to every type of technology involved in the process.

## Table of Contents

- [Lucidify - Technology Requirements and Analysis](#lucidify---technology-requirements-and-analysis)
    - [Table of Contents](#table-of-contents)
    - [Introduction](#introduction)
    - [Technology Requirements](#technology-requirements)
        - [Universal Requirements](#universal-requirements)
        - [Infrastructure Platform Requirements](#infrastructure-platform-requirements)
        - [Database Requirements](#database-requirements)
        - [Backend Requirements](#backend-requirements)
        - [Frontend Requirements](#frontend-requirements)
        - [Continuous Integration Requirements](#continuous-integration-requirements)
    - [Analysis of Options](#analysis-of-options)
        - [Infrastructure Platform Analysis](#infrastructure-platform-analysis)
            - [On-Premises Analysis](#on-premises-analysis)
            - [Public Cloud Analysis](#public-cloud-analysis)
            - [The Infrastructure Verdict](#the-infrastructure-verdict)
        - [Database Analysis](#database-analysis)
            - [The Database Verdict](#the-database-verdict)
        - [Backend Analysis](#backend-analysis)
            - [Ruby on Rails Analysis](#ruby-on-rails-analysis)
            - [Django Analysis](#django-analysis)
            - [AWS Lambda Analysis](#aws-lambda-analysis)
            - [The Backend Verdict](#the-backend-verdict)
        - [Frontend Analysis](#frontend-analysis)
            - [Angular Analysis](#angular-analysis)
            - [React Analysis](#react-analysis)
            - [Vue Analysis](#vue-analysis)
            - [The Frontend Verdict](#the-frontend-verdict)
        - [Continuous Integration Analysis](#continuous-integration-analysis)
            - [Jenkins Analysis](#jenkins-analysis)
            - [GitLab CI Analysis](#gitlab-ci-analysis)
            - [Travis CI Analysis](#travis-ci-analysis)
            - [The Verdict](#the-verdict)
    - [Conclusion](#conclusion)
    - [Glossary](#glossary)

## Introduction

The purpose of Lucidify is to leverage data from Spotify that can be pulled from the service's developer API to create useful and navigable visualizations of user-specific listening habits and recommendations. In order to accomplish this at scale, i.e., accommodate multiple users and have reasonable site load times, a cross-cutting technology stack is necessary to run the application and ensure high levels of usability, maintainability, and reliability. This document details the decisions Team Lucidify made regarding the technical requirements and technologies that are deemed necessary to meet those requirements.

## Technology Requirements

The first step in the journey of building Lucidify is deciding what the technology requirements are. In other words, Team Lucidify needs to identify what types of technology need to be used and what is required from each one in order to build an application that supports all its use cases and a platform that can scale and provide fast access times.

The team expects that a technology, or set of technologies, will need to be decided to support every part of the application's stack:

- **Frontend** - JavaScript frameworks, visualization libraries
- **Backend** - Server-side logic, calling Spotify's API service, data transformation
- **Database** - Persistent and structured storage of the application's user data

In addition to simply building the application, the team needs to consider a few more parts of the system that will help support scalability, maintainability, and reliability:

- **Infrastructure platform** - The services and/or hardware being used to host the application and its services, such as the database
- **Continuous integration system** - The system(s) needed to continuously enforce a high level of code quality by building the application and running tests whenever new code is committed

### Universal Requirements

Any piece of technology that the team uses to build and/or support Lucidify needs to meet acceptable expectations (as agreed upon by the team) in the following areas. Each part of the technology stack will have its own requirements in addition to the following. However, these form a baseline that applies to all technologies.

- **Ease of use** - The technology must be easy to develop in, maintain, and monitor. This must be considered so the team doesn't waste time on "fighting the technology" instead of doing valuable work.
- **Cost** - Since the project is unfunded and provided to customers free of charge (under current design plan), cost is a major deciding factor in all technology decisions. The cost of any technology needs to be competitively priced and reasonable for a group of five college students. Existing opportunities for funding will be taken into account when analyzing this requirement for each technology.
- **Familiarity** - To make development of the system simpler, the team would like to choose technologies that are familiar to at least some of the team members. Furthermore, a familiar option would allow for more team learning opportunities, i.e., where a group of team members can learn from another. Choosing a familiar option will make the development and maintenance of the system more straightforward.

### Infrastructure Platform Requirements

At the basis of the entire Lucidify platform is the infrastructure it will be built on top of. This includes the servers the backend code will run on, the networking technology that will route requests to the application, and the storage devices needed for the database to store its data. The two infrastructure options the team is considering are an "on-premises" infrastructure, where the team would own and run the hardware the system would run on, and a public cloud infrastructure, where virtual servers and services rented from one of the "Big Three" cloud providers (Amazon, Google, and Microsoft) would be leveraged to run the application.

In order to support the requirements of the application in terms of scalability, maintainability, and reliability, the team decided that any infrastructure platform being considered for Lucidify must be viable in the following areas:

- **Breadth of Services** - Many cloud infrastructure providers offer a wealth of services that require little to no configuration by the user. The team would like to leverage an infrastructure provider that offers many of such services to reduce the engineering resources that need to be spent on creating custom solutions for database management, web services, etc.
- **Scalability** - In order to support a large amount of concurrent users on the system, the infrastructure provider needs to be able to scale its resources automatically. This consideration will ensure the system can handle the amount of usage that will occur without causing service outages or significant slowdowns.
- **Security** - Since users will be able to log on to the application using their Spotify credentials, the team has a legal and ethical responsibility to secure any data the system stores about its users. As such, it is a major deciding factor in the team's infrastructure platform decision.

### Database Requirements

Lucidify is an application that is driven by data. As such, it needs to be supported by a database backend that can support the type of structured data, i.e. song data, playlist data, and user data, that will be used to process and generate useful data visualizations for the user.

The data that Lucidify will consume is, by nature, relational. For example, songs are part of playlists, and playlists belong to users. Knowing this fact, Team Lucidify decided that a relational database engine would be required to store and retrieve the data efficiently and logically. After doing some research, the team discovered that the performance benchmarks of most well-known relational databases are similar enough to not matter in the performance of Lucidify. Therefore, read speed and write speed were not considered as major deciding factors in which engine to use. What matters most is that the engine meets the following requirements, in addition to the universal requirements for ease of use, cost, and familiarity:

- **Integration with infrastructure** - The database system must be easily integrated into the infrastructure platform the team decides on. This will keep development time low.
- **Scalability** - The database system must be built to automatically scale to the amount of users currently using the site. This is critical to ensuring a high level of reliability that our system requires.
- **Security** - Similar to the infrastructure security requirement, the database must also be secure so the team can guarantee its users that their data is out of reach of potential attackers.

### Backend Requirements

Lucidify will do a large amount of backend processing to analyze user data from Spotify and massage it into data that can be used for visualization. The logic that performs this work makes up the backend portion of the web application. Many popular backend web frameworks exist to fill this role, such as .NET, PHP, Python, and Node.JS. The team agrees that the following requirements must be met, in addition to the universal requirements, by every candidate backend framework for Lucidify:

- **Time to deploy** - Each backend framework must be able to deploy to the target infrastructure in a reasonable amount of time. The time required to push changes to the infrastructure and restart the application is considered here, along with considering how automating this process would impact it. Keeping this time low will allow more time to be spent on development, and less on "fighting with the technology".
- **Performance** - Similar to the database, the backend technology must make efficient use of processor time and memory to keep the site performance at its peak.
- **Scalability** - The backend framework must be able to respond to multiple page requests efficiently in order to keep the site responsive and reliable.
- **Security** - The backend framework must have a low amount of vulnerabilities in order to protect against potential attackers.

### Frontend Requirements

The frontend framework and how it is implemented ultimately determines what the end user will see when they log on to Lucidify. The frontend is arguably the most important aspect of the Lucidify platform. It is also the part of the stack the team collectively knows the least about. The team has agreed that any framework needs to meet the following requirements plus the universal requirements in order for it to be considered for use as Lucidify's frontend:

- **Maturity** - The framework's breadth of features must be wide and mature, as in, they must be fully tested and ready for use in a production use case. This factor will be influenced by testimonials by others using the framework as well as experiments done by the team.
- **Learning curve** - As mentioned earlier, frontend development is a weak point for the team. As such, the learning curve on any new frontend technology must not be steep, so it does not disrupt the time and effort required to meet deliverable dates.
- **Performance** - Lucidify will feature animated graphs and visualizations. The frontend framework must be able to keep up in order to produce smooth and beautiful visualizations for the user.
- **Community** - The framework must have an active community working to fix bugs and answer questions from users. Since frontend work is a weak point for the team, this is an important factor in determining how much time and effort will be required to develop the frontend part of the application.

### Continuous Integration Requirements

In order to keep the quality of the application high and the amount of defects low, a continuous integration (CI) system is required to build the project and run tests whenever new code is committed. There exist several well-known CI tools that the team can leverage, but they must meet the following two requirements in addition to cost, ease of use, and familiarity in order to be used in the Lucidify development cycle:

- **Time to deploy** - Since CI is not critical to the application itself, but critical to the development process, the team requires that it be easy to set up. This will allow more time to be spent on the application and less time troubleshooting non-essential components.
- **Integration** - Integrating with existing source control technologies/services, like GitLab, will help the team leverage automation, which leads to more time spent on development.

## Analysis of Options

Now that the requirements for each piece of technology have been defined, the team can analyze the potential options for each one and see how they each stack up to the requirements. Pugh matrices were created for each technology, rating each option against each requirement on a 5-point scale, with 5 being the best.

### Infrastructure Platform Analysis

Both an on-premise infrastructure and a public cloud infrastructure were rated against how they met the requirements. This is the weighted Pugh matrix with final scores assigned.

| Requirement         | Weight | On-premises | Public Cloud |
| ------------------- | :----: | :---------: | :----------: |
| Ease of use         | 2      | 2           | 4            |
| Cost                | 3      | 5           | 3            |
| Breadth of services | 2      | 1           | 5            |
| Familiarity         | 3      | 4           | 4            |
| Scalability         | 4      | 1           | 5            |
| Security            | 4      | 2           | 4            |
| Total               |        | **45**      | **79**       |

#### On-Premises Analysis

- **Ease-of-use** - Rating: 2 - The ease of use of a self-hosted infrastructure would most likely be low. Even though the team would be fairly familiar with its own equipment, configuring it to support a web-facing application would be difficult. This is because very many considerations would need to be made to ensure proper functionality. This process would be easily taken care of by any cloud provider.
- **Cost** - Rating: 5 - As mentioned before, most of the equipment is already owned by the team, and it would most-likely run on an existing internet connection. Therefore, the cost of a self-hosted infrastructure would be nearly zero.
- **Breadth of services** - Rating: 1 - Any services necessary to run the application and its services, such as a database and a web server, would need to be developed and deployed manually to the self-hosted infrastructure.
- **Familiarity** - Rating: 4 - The team would own most of the hardware in use and would have been working with it for a while. As such, it would be familiar to most of the team.
- **Scalability** - Rating: 1 - Self-hosting a web application offers absolutely no automatic scaling capabilities due to limitations of physical hardware.
- **Security** - Rating: 2 - It would take a significant amount of engineering resources to develop security that the team needs to be able to offer its customers.

#### Public Cloud Analysis

- **Ease-of-use** - Rating: 4 - Much server setup is abstracted by the cloud provider, only exposing a simple and powerful dashboard for the user to configure services.
- **Cost** - Rating: 3 - Public clouds are competitively priced, but it would be slightly more expensive than the sunk cost of running an on-premises solution.
- **Breadth of services** - Rating: 5 - All of the "Big Three" public cloud providers (Amazon, Google, Microsoft) offer a wide range of services. These include but are not limited to virtual web servers, virtual database servers, and a platform to run code without having to provision a server.
- **Familiarity** - Rating: 4 - Two of the team members have experience using public clouds, and the simplicity of the public cloud APIs will allow others to learn quickly.
- **Scalability** - Rating: 5 - All of the Big Three public clouds offer automatic scaling of most of their services. This allows the system to quickly respond to an increased or decreased user load.
- **Security** - Rating: 4 - All the "Big Three" public cloud providers pass audits by world-renowned security auditors.

#### The Infrastructure Verdict

The team has decided to build Lucidify on a public cloud platform, which beat out the on-premises strategy by 34 points. Most likely, the cloud provider used will be Amazon Web Services, as some funding has been procured for it, and their services are the most mature. More information on this will come in later design documents.

### Database Analysis

As mentioned in the database requirements, the performance benchmarks for most well-known relational database engines are close enough to each other that the comparative performance metric is irrelevant to building Lucidify.

Research was done on Amazon Web Service's Relational Database Service (RDS), the service AWS uses to provision managed database servers to developers. This service meets the requirements set forth for Lucidify's database:

- **Ease of use, cost, familiarity, scalability, and security** - Being an AWS service, these requirements are met in the same way the infrastructure requirements of the same name are met.
- **Integration with infrastructure** - If the rest of the Lucidify platform is built in AWS, integrating RDS with it will be seamless.

#### The Database Verdict

AWS RDS will most likely be used as the database backend, due to its seamless integration with the rest of the planned Lucidify platform.

### Backend Analysis

There is a vast array of backend options available, each with both advantages and disadvantages. The choices were narrowed down to three most relevant and useful to the project and team. This is the final weighted Pugh matrix with final scores assigned for each option.

| Requirement    | Weight | Ruby on Rails | Django | AWS Lambda |
| -------------- | :----: | :-----------: | :----: | :--------: |
| Ease of use    | 3      | 3             | 4      | 5          |
| Cost           | 4      | 3             | 3      | 5          |
| Time to deploy | 2      | 3             | 4      | 5          |
| Familiarity    | 2      | 1             | 1      | 1          |
| Performance    | 3      | 2             | 4      | 5          |
| Scalability    | 4      | 4             | 4      | 5          |
| Security       | 4      | 4             | 4      | 5          |
| Total          |        | **64**        | **78** | **98**     |

NOTE: All familiarity scores rank at 1 due to the team not having experience in writing applications in these frameworks.

#### Ruby on Rails Analysis

- **Ease of use** - Rating: 3 - The team agrees that there is a fairly steep learning curve to the Ruby on Rails framework.
- **Cost** - Rating: 3 - Costs the same as running any other server framework on a virtual private server.
- **Time to deploy** - Rating: 3 - Getting Ruby running on a virtual server is unfamiliar to the team.
- **Performance** - Rating: 2 - Ruby on Rails performs poorly in benchmark tests.
- **Scalability** - Rating: 4 - Judging by the well-known systems that run on Ruby on Rails, the framework can scale well.
- **Security** - Rating: 4 - Ruby on Rails has low-risk vulnerabilities that can be mitigated through well-designed infrastructure and code.

#### Django Analysis

- **Ease of use** - Rating: 4 - Django uses Python, which is a fairly easy-to-understand language.
- **Cost** - Rating: 3 - Costs the same as running any other server framework on a virtual private server.
- **Time to deploy** - Rating: 4 - Getting Django running on a virtual server is unfamiliar to the team, but some members have Python experience to lighten the load.
- **Performance** - Rating: 4 - Django is Python optimized for high-scale web applications.
- **Scalability** - Rating: 4 - Judging by the well-known systems that run on Django, the framework can scale well.
- **Security** - Rating: 4 - Similar to Ruby on Rails, Django has some low-risk vulnerabilities that can be mitigated through well-designed infrastructure and code.

#### AWS Lambda Analysis

- **Ease of use** - Rating: 5 - Lambdas can be written in a multitude of languages, such as Python, Node.JS, and C#.
- **Cost** - Rating: 5 - Lambdas are charged per execution time, so there's no fee for having inactive site time.
- **Time to deploy** - Rating: 5 - Lambdas can be deployed through Amazon's easy-to-use web console.
- **Performance** - Rating: 5 - Amazon promises a very high level of performance regarding lambdas in their end user service agreement.
- **Scalability** - Rating: 5 - Lambdas will spin up another instance of the function for each concurrent time it's called, so it's virtually unlimited in scaling capacity.
- **Security** - Rating: 5 - Lambdas offer the same excellent security agreement offered by all the services in the Amazon Web Services suite.

#### The Backend Verdict

Lucidify's backend will most likely be AWS Lambdas due to their cost and integration with other pieces of the Amazon service ecosystem.

### Frontend Analysis

The frontend framework will define the User Interface portion of our application; the most visible and likely most defining factor of any web application. Although many options exist for frontend Javascript frameworks, the choice was narrowed down to three modern, popular, and well supported options: Angular, React, and Vue. This is the weighted Pugh matrix comparing each option.

| Requirement    | Weight | Angular | React  | Vue    |
| -------------- | :----: | :-----: | :----: | :----: |
| Ease of use    | 2      | 2       | 4      | 5      |
| Familiarity    | 2      | 2       | 4      | 4      |
| Maturity       | 4      | 4       | 4      | 3      |
| Learning Curve | 4      | 2       | 4      | 5      |
| Performance    | 4      | 4       | 4      | 5      |
| Community      | 3      | 5       | 5      | 3      |
| Total          |        | **59**  | **75** | **75** |

Note: Since all options are open-source and free to utilize, the cost requirement has been left out of the above matrix.

#### Angular Analysis

- **Maturity** - Rating: 4 - First released by Google in 2010. Angular has had several major releases since and is a very widely used framework.
- **Community** - Rating: 5 - Angular is used in many applications, including several well known ones including Wolfram Alpha, weather.com, and healthcare.gov. The community is large, active, and has a strong history.
- **Ease-of-use** - Rating: 2 - Significantly more code and complexity is involved in development.
- **Familiarity** - Rating: 2 - Modern Angular uses Type-Script, which is a language the team has no experience using.
- **Learning Curve** - Rating: 1 - The general complexity and use of Type-Script results in a steep learning curve.
- **Performance** - Rating: 4 - Angular is generally fast but it also includes several tools that would likely not see use. This results in bloat that could cause performance deficit.

#### React Analysis

- **Maturity** - Rating: 4 - First released open-source by Facebook in 2013. React has an active development team that has also released additional framework add-ons for specific purposes, such as Android and IOS development.
- **Community** - Rating: 5 - React has a wide and dedicated user base as the framework is very popular. It is used in many well known applications (in addition to Facebook), such as Netflix, Twitter, and Reddit.
- **Ease-of-use** - Rating: 4 - React is a generally straight forward and simple framework to use. It's a large framework which can lead to some confusion in development.
- **Familiarity** - Rating: 4 - React uses Javascript which the team has experience with.
- **Learning Curve** - Rating: 3 - React being straight forward and using Javascript results in a smaller curve. Exploring the entirety of the framework could lead to increased learning time.
- **Performance** - Rating: 4 - React is generally very fast and includes performance tools and options for optimizing rendering.

#### Vue Analysis

- **Maturity** - Rating: 4 - Vue is a relatively new framework, first released by Evan You in 2014. It has been the fastest growing framework in 2017.
- **Community** - Rating: 4 - The Vue community is growing as the framework's use is increasing. However the community has considerably less history than Angular and React.
- **Ease-of-use** - Rating: 5 - Vue is designed to simplify web UI development, resulting in a developer friendly framework.
- **Familiarity** - Rating: 5 - Vue uses Javascript which the team has experience with.
- **Learning Curve** - Rating: 4 - Vue is a simple and small framework. It's design philosophy of simplifying web development means the curve should be small and approachable.
- **Performance** - Rating: 5 - Vue is a small and lightweight framework, resulting in good performance.

#### The Frontend Verdict

Lucidify will utilize the Vue Javascript framework for building it's frontend and user interface. The team is interested in using a tool that is both new and popular. This alongside Vue's other advantages make it the best choice for Lucidify.

### Continuous Integration Analysis

There are several available CI tools, each having a set of advantages and disadvantages. The choices were narrowed down to three most pertinent to the project and team. This is the final weighted Pugh matrix with final scores assigned for each option.

| Requirement    | Weight | Jenkins | GitLab CI | Travis |
| -------------- | :----: | :-----: | :-------: | :----: |
| Ease of use    | 3      | 2       | 4         | 3      |
| Cost           | 4      | 5       | 5         | 5      |
| Time to deploy | 4      | 3       | 4         | 3      |
| Familiarity    | 2      | 3       | 3         | 3      |
| Integration    | 3      | 4       | 5         | 1      |
| Total          |        | **56**  | **69**    | **50** |

A detailed description of each option and how they meet (or don't meet) each requirement follows.

#### Jenkins Analysis

- **Ease-of-use** - Rating: 2 - Although both powerful and flexible Jenkins is known to have a steep learning curve and take time to manage and configure. For this reason the rating for ease of use is low, since more time than necessary will be spent learning to use it.
- **Cost** - Rating: 5 - Jenkins is an entirely free, open-source tool that offers several free plugins as well.
- **Time to deploy** - Rating: 3 - As briefly stated in ease-of-use, although the actual builds may be fast, it would take time to configure and manage them.
- **Familiarity** - Rating: 3 - Although having a high learning curve, some of the team members have had brief interactions with the software before.
- **Integration** - Rating: 4 - Being extremely flexible, Jenkins either supports or has plugins to support any software or language, as well as specific support with GitLab itself.

#### GitLab CI Analysis

- **Ease-of-use** - Rating: 4 - Considering it would be directly integrated with the software the team is currently using, it would add the benefit of having all resources in one place. Additionally, it has a smaller learning curve and provides only the essential and minimal configuration.
- **Cost** - Rating: 5 - Although an Enterprise Version is available, all of the necessary features are offered for free.
- **Time to deploy** - Rating: 4 - Especially given that it is integrated in the teams current source control platform, setup would be seamless and simple.
- **Familiarity** - Rating: 3 - Even though our team is using GitLab for source control already, there are no team members familiar with the CI tools offered.
- **Integration** - Rating: 5 - As mentioned above the tools will perfectly integrate with our currently used software. Additionally it has a wide range of support for any languages that we intend to use.

#### Travis CI Analysis

- **Ease-of-use** - Rating: 3 - Although not as complex as Jenkins, Travis also has a bigger learning curve and a significant amount of additional manageability.
- **Cost** - Rating: 5 - Similarly to Jenkins the tool is entirely free and open-source.
- **Time to deploy** - Rating: 3 - Building and managing would be more time consuming, since the integration with GitLab would have to involve a third party.
- **Familiarity** - Rating: 3 - Team members do not have any experience using this tool.
- **Integration** - Rating: 1 - It would be difficult to integrate the tool with GitLab, since it was designed to primarily be used with GitHub.

#### The Verdict

The most useful CI tool available that meets the team's needs is GitLab CI. This will most likely be the CI tool used for the remainder of the project.

## Conclusion

After the team's analysis of the technologies available and suitable for use in the Lucidify platform was completed, a reasonable conclusion can be made that the following technologies are going to be used:

- Amazon Web Services or another, similar public cloud provider will be used for the base infrastructure of the platform.
- Amazon's Relational Database Service will be used to stand up and run a relational database engine.
- Luidify's backend logic will be handled mainly through Amazon's Lambda functions, serverless code applications.
- The frontend of the application will be written using the Vue.JS framework and various other modular JavaScript libraries.
- GitLab CI will be used to maintain quality of Lucidify's codebase.

As a more detailed design of the components of Lucidify comes about, these decisions may be augmented. These changes will be recorded in future design documentation.

## Glossary

- **Cloud** - Refers to systems and processing which is accessed over the internet.
- **Framework** - Software providing generic functionality that is supplemented and changed by user-written code.
- **Javascript Framework** - An application framework written in Javascript. Forms the base on which the UI and backend integration for an application are built.
- **Open-Source** - Refers to software which the owner has made the source code freely available. Open-Source projects may have their code redistributed and modified as wanted. Although many Open-Source projects are free to use, the term only refers to the availability of the source code, not the terms of use for the actual product.
- **Rendering** - The process of using a computer program to automatically draw/generate 2D or 3D images from models or descriptive code.
- **Use Case** - A list of actions or event steps defining the interactions between an actor (ie. user) and a system to achieve a goal.
- **User Interface (UI)** - The part of an application which a user interacts with to perform functions.
- **Virtual** - Refers to computer systems which are emulated on top of existing hardware and software. A virtual system does not have a one to one connection between the allocated system resources and the physical hardware running the system.