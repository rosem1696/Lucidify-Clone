# Team Lucidify - Project Proposal

This document outlines Team Lucidify's composition, project proposal, and detailed Fall quarter development plan.

## Table of Contents

- [Team Lucidify - Project Proposal](#team-lucidify---project-proposal)
    - [Table of Contents](#table-of-contents)
    - [Team Composition](#team-composition)
    - [Project Details](#project-details)
        - [Project Description](#project-description)
        - [Knowledge From Other Courses To Be Used](#knowledge-from-other-courses-to-be-used)
        - [Project Technologies and Support Facilities](#project-technologies-and-support-facilities)
        - [Preliminary Development Plan](#preliminary-development-plan)
    - [Detailed Development Plan - Fall Quarter](#detailed-development-plan---fall-quarter)
        - [Glossary](#glossary)

## Team Composition

Team Lucidify is composed of:

- Jack Schlederer - CE - Product Owner/Project Lead
- Mitchell Rose - CE - Project Manager
- Dylan Kuchcinski - SE - Flex Developer
- Anthony Henderson - SE - Flex Developer
- Trevor Hacker - SE - Flex Developer/Tester

## Project Details

This segment outlines Team Lucidify's project proposal, complete with a project description and project deliverables, to be completed throughout the year.

### Project Description

The objective of Team Lucidify's design project is to solve the problem of Spotify’s lack of user data transparency, as the service does not display to users any data about their listening habits other than recommended songs, which may or may not correlate to what they were listening to most recently. Team Lucidify plans to build a music analytics and recommendation engine that funnels data from Spotify’s (and other) developer APIs to build a meaningful web “dashboard” that Spotify (and perhaps other streaming services) users can log on to in order to view visualizations of their listening habits and a web of their friends’ listening habits. Furthermore, the application will be able to recommend public user-generated playlists to the user, based on their average, calculated song-related metrics (i.e., danceability, energy, acousticness). All of this will be presented in a graphical way, using cluster graphs and radar charts. The primary audience for this application will be Spotify users, as they will use those credentials to log in to the site. There are some similar products on the market that use Spotify data to graphically show how artists are related, but there are no products that make a graph to display a ranking of genres on a per-user basis. Since this project is entirely software, it meets the requirements for both the CEs and SEs on our team.

### Knowledge From Other Courses To Be Used

Knowledge and skills gained in previous coursework on the CE track and the SE track, specifically the following, will prove valuable and necessary in the design of this project.

- CE/SE courses
    - **SE1011, SE1021, CS2852** – The project will entail developing a fast and scalable web application. Knowledge from the foundational software development and data structures courses will prove useful in architecting a fast and well-designed system.
    - **SE2030, SE2890** – The project will be source-controlled using software configuration management tools, such as Git, and the project will be developed on the Scrum lifecycle. Knowledge of these was gained in the foundational software engineering processes courses.
    - **CS3841, CS3844** – The application will be hosted on a collection of cloud servers, and knowledge of operating systems gained in these courses will aid in architecting the underlying infrastructure for the system and troubleshooting the application.
- CE courses
    - **CE2811, CE2930, CE3910** – Topics from the embedded systems and computer architecture courses will aid in designing a well-segmented and highly cohesive system, even though the nature of the project is not as low-level as what was taught in those courses.
- SE courses
    - **SE2832** – Automated testing will aid in verifying the functionality of the system. Skills taught in Introduction to Software Verification can be leveraged to more completely test the system and its component applications.
    - **SE2840** - Web development will aid in the creation of the whole project since we plan on making this solely a web application.
    - **SE3191** – The Scrum process followed in SDL will be closely emulated in this project, so the software development process skills learned in this course will be valuable.

### Project Technologies and Support Facilities

For successful project completion, Team Lucidify anticipates the use of the following technologies:

- Support facilities and processes
    - Scrum for project management
    - Trello for task/backlog management
    - Discord for team communication/synergy
- Management technologies
    - Git and Gitlab for software configuration management
- Key technologies
    - Spotify REST developer API for data ingestion
    - Terraform for infrastructure-as-code
    - Amazon Web Services for cloud infrastructure
- Technologies to be determined
    - Backend web framework for the web application
    - Frontend JavaScript frameworks for data visualization
    - Database technology for backend data storage
    - CI system for building the application/infrastructure

Since this project focuses entirely on web and cloud technologies, no support from EECS or CCSD is required, nor is any device fabrication required.

### Preliminary Development Plan

The following are the milestones we plan to design and develop throughout the project. No milestone will be considered “done” until it has been implemented and tested.

- Fall quarter
    - Fall quarter development plan
    - Project documents
        - Technology requirements
        - System requirements & specifications
    - Cloud infrastructure design
        - No user-facing deliverable
        - Detailed layout of cloud infrastructure services to be used in the project
        - Cost analysis of cloud resources
    - Welcome page/Login screen
        - The user should be able to browse to the site and see a login screen
        - The should see a “Coming Soon” page with a list of features
    - Preparation for mini-presentation
    - Detailed development plan for winter quarter
- Winter quarter
    - User authentication and data load POC
        - The user should be able to log on to the site using their Spotify credentials
        - The user should be able to see data pulled from the Spotify API regarding their recently listened-to artists and songs
        - Recommendation or visualization will not be ready at this point
    - Visualization POC
        - The user should be able to see their music and related artists as a cluster/web graph
        - Other visualizations TBD
    - Visualizations with friends
        - Users should be able to see the related artists/songs web, integrating songs from their friends’ recently played and most popularly played music
    - Preparation for mini-presentation
    - Detailed development plan for spring quarter
- Spring quarter
    - Public playlist recommendations (stretch goal)
        - Users will be able to view public playlists that closely resemble their listening habits
        - This may be integrated into a web visualization or just a list
    - Poster
    - Preparation, practice for senior design show
    - Final report

## Detailed Development Plan - Fall Quarter

Team Lucidify will be operating on one-week sprints, beginning and ending every Monday. The following lists what development work is planned and what will be delivered each sprint.

- **Sprint 1 - Week 2 (9/11)** - Project Proposal
    - Deliverable: Project Proposal and Detailed Development Plan for the Fall Quarter
- **Sprint 2 - Week 3 (9/18)** - Project Documents, phase I
    - Work on Technology Requirements document and System Specifications and Requirements document
    - No deliverable this sprint
- **Sprint 3 - Week 4 (9/25)** - Project Documents, phase II
    - Finish Technology and Concept Investigation Report started last sprint
    - Deliverable: Technology and Concept Investigation Report
- **Sprint 4 - Week 5 (10/2)** - System Requirements and Specifications Document
    - Write up System Requirements and Specifications Document
    - Deliverable: System Requirements and Specifications Document
- **Sprint 5 - Week 6 (10/9)** - UI Design
    - Finish basic user interface design for welcome and login screen
    - Deliverable: Document detailing the proposed look and feel for the web application, and mockups for the login screen
- **Sprint 6 - Week 7 (10/16)** - Login Screen Implementation, phase I
    - Write automatable infrastructure-as-code to stand up cloud resources necessary for the web application to show the login screen
        - Web server instance running the team's chosen web server software
        - No database infrastructure at this stage
    - Deliverable: Web server running in the cloud, showing default landing page
- **Sprint 7 - Week 8 (10/23)** - Login Screen Implementation, phase II
    - Implement the proposed UI design for the login screen
    - Deploy the login screen to the web server running in the cloud
    - Deliverable: The login page is accessible through the team's chosen domain name
- **Sprit 8 - Week 9 (10/30)** - Prepare for End-of-Quarter Presentation
    - Put together slide deck/talking points for the End-of-Quarter SD Presentation
    - No deliverable or development work done this sprint
- **Sprint 9 - Week 10 (10/6)** - Detailed Development Plan for the Winter Quarter
    - Put together a plan (similar to this one) for next quarter's development
    - Deliverable: Detailed Development Plan for the Winter Quarter

### Glossary

- **Acousticness** -  Spotify metric that rates the acoustics of the song, the higher the value the more acoustic the song is.  

- **CE** - Computer Engineer  

- **CE2811** -  Embedded Systems II

- **CE2930** -  Introduction to Computer Architecture

- **CE3910** -  Embedded Systems III

- **CI** - Continuos Integration system that runs tests on the code when it gets pushed to the repository.

- **CS2852** - Data Structures

- **CS3841** - Design of Operating Systems  

- **CS3844** -  Operating Systems

- **Danceability** - Spotify metric that rates the higher the value, the easier it is to dance to this song.

- **Discord** -  Voice and Text communication platform. Reference link: <https://discordapp.com/>

- **Energy** -  Spotify metric that rates the energy of a song - the higher the value, the more energetic. song  

- **Gitlab** -  Version control system. Reference link: <https://gitlab.com/>

- **SE** - Software Engineer  

- **SE1011** -  Software Development I

- **SE1021** -  Software Development II

- **SE2030** -  Software Engineering Tools and Practices

- **SE2840** -  Web Application Development

- **SE2890** -  Software Engineering Practices

- **SE2832** -  Introduction to Software Verification

- **SE3191** -  Software Development Laboratory I

- **Spotify** -   Music, podcast, and video streaming service. Reference link : <https://www.spotify.com/us/>

- **Trello** -  Web-based project management system. Reference link: <https://trello.com/>
