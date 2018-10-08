# Lucidify - System Requirements and Specifications

- [Lucidify - System Requirements and Specifications](#lucidify---system-requirements-and-specifications)
    - [Description](#description)
    - [Stakeholders](#stakeholders)
    - [System Architecture](#system-architecture)
    - [Constraints](#constraints)
        - [Product Constraints](#product-constraints)
        - [Project Constraints](#project-constraints)
    - [Requirements](#requirements)
        - [Functional Requirements](#functional-requirements)
        - [Non-Functional Requirements](#non-functional-requirements)
    - [Use Cases](#use-cases)
    - [Sequence Diagrams](#sequence-diagrams)
        - [Login](#login)
        - [View User Playlist](#view-user-playlist)
        - [View All Genres in a Web Graph](#view-all-genres-in-a-web-graph)
        - [View All Songs in a Selected Genre Bubble](#view-all-songs-in-a-selected-genre-bubble)
        - [View Artist Info](#view-artist-info)
        - [View Song Statistics](#view-song-statistics)
        - [Select a Date Range for the Genre Web Graph](#select-a-date-range-for-the-genre-web-graph)
        - [View a Time-lapse of the Genre Graph](#view-a-time-lapse-of-the-genre-graph)
        - [View Recommended Songs from Friend's Playlists](#view-recommended-songs-from-friends-playlists)
    - [Architectural Drivers](#architectural-drivers)
    - [Quality Attribute Scenarios](#quality-attribute-scenarios)
    - [Glossary](#glossary)

## Description

Lucidify will be a web application that Spotify users can logon to in order to interact with visualizations that represent their listening patterns. The application will provide users with multi-functional, embedded web graphs representing relations between genres, songs and artists as well as provide general statistics for specific songs. Each respective graph will be accessed through the related higher level graph node. Additionally the application will provide song recommendations to the user based on their friends' similar listening habits. Overall, the product will provide users with a beautiful, secure, easy-to-use web application for displaying information on user listening habits. This document delineates the requirements and specifications Team Lucidify plans on following for the further, more granular design of Lucidify’s components and infrastructure.

## Stakeholders

- Spotify
- Spotify Users
- Amazon
- Development Team
- Spotify Artists

## System Architecture

The Lucidify platform will operate as a serverless web application that leverages many of AWS’s advanced services. The static website (including HTML, CSS, and JavaScript) will reside in S3, Amazon’s object storage service. When a client logs on to the site through the public URL, AWS’s DNS service Route 53 will resolve the URL to the location of the S3 bucket, and the static site will be downloaded. The client-side JavaScript code will make requests to the Lucidify API. The API will be composed of many functions written on AWS Lambda, an innovative serverless compute platform. Each function in AWS Lambda will be responsible for a small part of the application logic, with all of them coming together to form a highly cohesive service layer. Lambda functions will execute various commands on the Lucidify database, hosted in Amazon’s Relational Database Service (RDS). This database will store user’s listening data that will be used to create the graphs and statistics that will be shown to the user. The API will also make calls to the Spotify web API, where song and user data will initially be sourced from.

![Lucidify System Overview](/Images/System%20Requirements/Lucidify%20System%20Overview.png)

## Constraints

### Product Constraints

- **Adaptability** Because of the nature of the application, which will provide the user feedback on their listening habits, the application must be easily adaptable to handle new feature requests from users.

- **Reliability** - It is not crucial for the application to have 100% availability, but the team agrees to maintain a service level of 95%, so the application must be unavailable for no longer than 5% of any measured time period.

- **Scalability** - As the number of users and their listening history grow, the application must be ready to handle increasing amounts of traffic and stored data.

- **Security** - The platform will be dealing with Spotify user data that can only be obtained with the user’s credentials. Team Lucidify needs to ensure that the authentication method used is secure. In addition to authentication, database security must also be a consideration.

- **Usability** - The application must be usable on most modern web browsers. Specifically, the latest versions of Firefox, Chrome, and Safari. The application does not need to be usable via mobile browsers.

- **Maintainability** - Team Lucidify must implement a policy of strict coding standards and rigorous testing to ensure the delivery of not only a high quality initial product, but also the timely delivery of new features.

### Project Constraints

- **Schedule** - The team has a final project deadline of May 18, 2018 and has planned the development of the application accordingly.

- **Budget** - The product's budget is the total of what each of the five Team Lucidify members can realistically contribute to the project, which is estimated at $25 from each team member, plus a $100 educational grant from Amazon.

## Requirements

### Functional Requirements

**Description** - The product must show the user a web graph whose nodes represent the user’s listened genres, connected to similar genres.  
**Rationale** - In order to allow the user to explore what genres they’ve listened to and how much they listen to each one.  
**Fit Criteria** - On user login, the application opens up to a web graph of all listened genres with 0* connected nodes depending on how closely genres relate to each other.  

**Description** - The product must recommend songs from friends' playlists that the user may like.  
**Rationale** - In order to allow the user to explore what music tastes they have in common with their friends and to find new music.  
**Fit Criteria** - Given a user has a friend who has used our application, recommend songs from that friend to the user that closely mimics the user's listening tastes.  

**Description** - The product must display songs listened to by the user, that fall within a specific genre.  
**Rationale** - In order for the user to understand why certain genre bubbles are larger than others, they should be able to view what songs they listened to that fall under that genre.  
**Fit Criteria** - Given a user clicks a genre bubble from the genre web graph, all songs they’ve listened to of that genre are displayed.  

**Description** - The product must display song info including, but not limited to, the danceability level, acousticness level, and energy level of the song.  
**Rationale** - To give the user data on specific songs to understand how they relate to other songs.  
**Fit Criteria** - Given a user clicks on a specific song title, the song metrics are displayed along with other basic song info such as the artist.  

**Description** - The product must be able to display different versions of their web graph based on date ranges.  
**Rationale** - To understand how a user's listening habits have changed over time.  
**Fit Criteria** - Given the user is looking at the web graph, there should be an option to change the date range from the last day, the last week, the last month, or all time and the web graph should accurately reflect the data gathered during those time periods.  

**Description** - The product must display an animated time lapse of the growth of the genre web graph over a period of time.  
**Rationale** - To visualize how a user’s listening habits have changed over time.  
**Fit Criteria** - Given the user starts the time lapse, the genre web graph grows and shrinks based on each days genre web graph within the given date range.  
**Description** - The product must display a genre web graph for a selected playlist.  
**Rationale** - To understand the genre diversity in specific playlists.  
**Fit Criteria** - Given the user clicks on a playlist, a genre web graph is generated and displayed for the songs within that playlist.  

**Description** - The product shall pull the user history from Spotify and store it in a database.  
**Rationale** - Spotify limits the size of a user's listening history to the last 50 songs, so we need to store that history so we can access it later.  
**Fit Criteria** - Given a user logged into our application a week ago and gave us permission to view their listening history, the product should use a week's worth of listening history for all the data analytics.  

**Description** - The product must allow the user to login using their Spotify credentials.  
**Rationale** - Since we are relying on Spotify listening history for all the data analytics, we should allow the user to sign in with their Spotify credentials and ask permission to use their data.  
**Fit Criteria** - Given a user is accessing our site, they should be able to use their Spotify credentials to log into it.  

### Non-Functional Requirements

**Description** - The product must have an intuitive and easy to use interface.  
**Rationale** - The user must be comfortable using the application and not run into any issues navigating the interface.  
**Fit Criteria** - 9/10 users should be able to find their way around the interface and all provided features within 30 seconds of initial use.  

**Description** - The product must have a fluid transition between graphs and graph functions.  
**Rationale** - The product should not lose any performance or cause users any frustration while navigating through graphs and their functions.  
**Fit Criteria** - Navigate through graphs, performing multiple updates and ensure no updates take longer than 50 milliseconds

**Description** - The product shall effortlessly update user data.  
**Rationale** - The users should not have to wait a long period of time whenever an update to their data is required.  
**Fit Criteria** - Perform a multitude of updates on a select user base and ensure no updates take longer than 50 milliseconds.  

**Description** - The product must maintain full interoperability with Spotify API.  
**Rationale** - Given that most data will be pulled from Spotify API the product should not have any difficulty in obtaining that data and consequently slowing any interactions or updates down.  
**Fit Criteria** - Ensure 95% of calls to Spotify API are successfully made.  

**Description** - The product must be able to handle a large (1,000’s of users) concurrent user base.  
**Rationale** - The product should not lose any functionality under stress and should be available to all users no matter how large the user base becomes.  
**Fit Criteria** - Simulate large number of user requests, making sure the product stays functional through all of the requests.  

**Description** - The product shall not have a latency of more than 1 second when navigating through the site.  
**Rationale** - Long site response times can cause frustration among users, leading to lower user satisfaction.  
**Fit Criteria** - Perform several requests and product navigation actions, ensuring the latencies never exceed 1 second.  

**Description** - The product shall not store any sensitive user information.  
**Rationale** - Users will not want any of their sensitive information being easily accessible.   The product should leave all security handling to Spotify and thus not store any of potentially sensitive information.  
**Fit Criteria** - Store only information required for product use and none that would be considered sensitive.

**Description** - The product must be engaging and hold the user's attention.  
**Rationale** - The user should enjoy the product and use it frequently to maintain consistent graphs.  
**Fit Criteria** - 9/10 users should use the application, 5/7 days of the week.  

**Description** - The product must be visually appealing to users.  
**Rationale** - The user should find the product attractive, which will increase their desire to use it.  
**Fit Criteria** - 9/10 users should rate the product as appealing to them.  

**Description** - The product shall present data and graphs in a clear and concise way.  
**Rationale** - The user should not be confused as to what the graphs or data are representing.  
**Fit Criteria** - 9/10 users should be able to state that they clearly understand what each graph is representing.  

## Use Cases

Team Lucidify has identified these use cases and workflows for the application's end user.

1. Log in
2. View user playlist
3. View all genres in a web graph
4. View all songs in a genre bubble from the web graph
5. View all related artists to the selected artist
6. View song statistics provided by Spotify (danceability, acousticness, energy, etc.)
7. Select a date range for the web graph
8. View recommended songs from friends playlists

The following table describes the input and output conditions for each one of these.

| Name                                          | Actors                      | Input                                           | Output                                                                                  |
| --------------------------------------------- | :-------------------------- | :---------------------------------------------- | :-------------------------------------------------------------------------------------- |
| Log In                                        | User, Database, Spotify API | User enters Spotify credentials                 | User is logged in, Lucidify home page loads with user information                       |
| View user playlist                            | User, Database              | User selects one of their playlists             | Application loads and displays  a genre graph for specified playlist                    |
| View all genres in a web graph                | Database, Spotify API       | User logs in                                    | Application displays a web graph of genres based on user information                    |
| View all songs in a selected genre bubble     | User, Database, Spotify API | User selects a genre bubble from the web graph  | Application zooms into a graph of songs that are in the specified genre bubble          |
| View artist info                              | User, Spotify API           | User selects an artist                          | Application displays info on that artist and a list of related artists                  |
| View song statistics                          | User, Database, Spotify API | User selects a song                             | Application displays the given track’s features from the Spotify API                    |
| Select a date range for the genre web graph   | User, Database              | User selects a date range                       | Application displays a genre web graph from that specific date range                    |
| View a time-lapse of the genre graph          | User,Database               | User selects the play button for the time lapse | The genre web graph grows and shrinks based on what it looks like on a day to day basis |
| View recommended songs from friends playlists | User, Database, Spotify API | Select a friend’s playlist                      | Application displays how the songs are related to your listening habits                 |

## Sequence Diagrams

### Login

![Login](/Images/System%20Requirements/Sequence%20Diagrams/Login.png)

### View User Playlist

![View User Playlist](/Images/System%20Requirements/Sequence%20Diagrams/View%20User%20Playlist.png)

### View All Genres in a Web Graph

![View All Genres in a Web Graph](/Images/System%20Requirements/Sequence%20Diagrams/View%20all%20genres%20in%20a%20web%20graph.png)

### View All Songs in a Selected Genre Bubble

![View All Songs in a Selected Genre Bubble](/Images/System%20Requirements/Sequence%20Diagrams/View%20all%20songs%20in%20a%20selected%20genre%20bubble.png)

### View Artist Info

![View Artist Info](/Images/System%20Requirements/Sequence%20Diagrams/View%20artist%20info.png)

### View Song Statistics

![View song statistics](/Images/System%20Requirements/Sequence%20Diagrams/View%20song%20statistics.png)

### Select a Date Range for the Genre Web Graph

![Select a Date Range for the Genre Web Graph](/Images/System%20Requirements/Sequence%20Diagrams/Select%20a%20date%20range%20for%20the%20genre%20web%20graph.png)

### View a Time-lapse of the Genre Graph

![View a Time-lapse of the Genre Graph](/Images/System%20Requirements/Sequence%20Diagrams/View%20time-lapse%20of%20the%20genre%20graph.png)

### View Recommended Songs from Friend's Playlists

![View Recommended Songs from Friend's Playlists](/Images/System%20Requirements/Sequence%20Diagrams/View%20recommended%20songs%20from%20friends%20playlists.png)

## Architectural Drivers

1. **Usability**- Support User/System Initiatives
2. **Performance** - Latency
3. **Interoperability** - Exchanging/Interpreting data
4. **Scalability** - System resource availability

## Quality Attribute Scenarios

**Quality Attribute** - Performance (Getting listening data)  
**Stimulus Source** - User  
**Stimulus** - Getting user listening history  
**Artifacts** - Database  
**Environment** - Moderate to severe Load  
**Response** - Web graphs created and displayed  
**Response Measurement** - Retrieving user listening data to create the web graphs should take no longer than 1 second.  

**Quality Attribute** - Performance (Graph Interactions)  
**Stimulus Source** - User  
**Stimulus** - Zooms In/Out of the web graph  
**Artifacts** - Web UI  
**Environment** - Runtime  
**Response** - Web graph grows or shrinks  
**Response Measurement** - The graph should update on the screen within 50 milliseconds of scrolling in and out of the graph or clicking the zoom in/out buttons.  

**Quality Attribute** - Scalability (Database)  
**Stimulus Source** - Users  
**Stimulus** - Multiple (1,000’s) users  
**Artifacts** - Database  
**Environment** - Moderate to severe load  
**Response** - Multiple (1,000’s) of user's listening history  
**Response Measurement** - Updating a user's listening history should take roughly 2 seconds in order to upload to the database.  

**Quality Attribute** - Scalability (WebApp)  
**Stimulus Source** - System  
**Stimulus** - Using the application  
**Artifacts** - Server  
**Environment** - Runtime  
**Response** - Successfully run the application  
**Response Measurement** - The application should have no more than 50 milliseconds of latency due to the number of people currently using the application around the world.  

**Quality Attribute** - Usability (Intuitive)  
**Stimulus Source** - User  
**Stimulus** - Navigating the site  
**Artifacts** - Application  
**Environment** - Runtime  
**Response** - Using the site  
**Response Measurement** - Duration from application launch the user should take at most 30 seconds to understand what is being shown and how to navigate the site.  

**Quality Attribute** - Interoperability (Working with Spotify API)  
**Stimulus Source** - System  
**Stimulus** - Getting user data  
**Artifacts** - Spotify API, Database  
**Environment** - Moderate Load  
**Response** - User Spotify data provided to application  
**Response Measurement** - 95% of total calls to the Spotify API should be successful in returning useful data.  

## Glossary

- **Acousticness** - A metric provided by spotify to measure whether a song uses more acoustic or electronic based instruments and sounds.
- **AWS** - Amazon Web Services, Amazon's cloud infrastructure service
- **Danceability** - A metric provided by Spotify for individual songs. It is a 0 to 1 measurement of how likely a song promotes or fits well with dancing.
- **Serverless** - Referring to Amazon's Lambda service, a service that allows chunks of code to be run on infrastructure completely managed by Amazon, without having to manually provision a server or other infrastructure to run them on
- **Spotify** - Web-based music streaming service
- **Stakeholder** - A person, group, or organization that is actively involved in a project, is affected by its outcome, or can influence its outcome
- **System Architecture** - A high-level conceptual overview that defines the structure and behavior of a system
- **Use Case** - A list of steps defining an interaction between "actors", namely the end user, and the system
- **Workflow** - Synonym for use case