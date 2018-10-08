# Feature Documentation - Database Connectivity

## Introduction

This document details the implementation and delivery details for Lucidify's data storage and retrieval mechanism.

## Table of Contents

- [Feature Documentation - Database Connectivity](#feature-documentation---database-connectivity)
    - [Introduction](#introduction)
    - [Table of Contents](#table-of-contents)
    - [Motivation](#motivation)
    - [Design](#design)
        - [Data Model](#data-model)
        - [Ethical Concerns](#ethical-concerns)
        - [Retrieivng/Storing Data](#retrieivngstoring-data)
    - [Implementation](#implementation)
        - [Storing to the database](#storing-to-the-database)
        - [Retrieving from the database](#retrieving-from-the-database)
        - [Performance](#performance)
    - [Delivery](#delivery)

## Motivation

This feature was motivated by the Lucidify platform's goal of visualizing the platform's users' listening habits on Spotify. Before this feature was implemented, Lucidify could only visualize each user's most recent 50 song listens, which is a limitation put in place by Lucidify's primary data source, the Spotify Web API. With only showing 50 songs per user, Lucidify could not effectively show a user's listening habits over any period of time beyond, say, their last long listening session. So, in order to fully accomplish the site's goal of tracking users' listening habits over time, the project needed a mechanism to store each user's most recent tracks periodically so the sum of all that data could be shown to the user when they logged in.

## Design

This feature necessitated a backend datastore to store users' song data so it could be returned to them through Lucidify. The type of data being consumed by Lucidify, music data, is inherently relational, i.e., songs relate to artists, and artists relate to genres, etc., so the team decided a relational data model would make the most sense. As delineated in the database design document, the PostgreSQL relational database was chosen due to its flexibility with JSON data, the type of data returned by Spotify. To follow Lucidify's vision of being a purely cloud-based platform, the database was created and stood up in Amazon Web Services' Relational Database Service (RDS).

### Data Model

The Lucidify platform needed to store the following entities the database so song data could be materialized on a per-user basis on demand:

- Users
- Songs
- Artists
- Genres
- Instances of a user listening to a song

The following diagram represents the relational data model that ultimately became the schema for the Lucidify database.

![Lucidify Data Model](/Images/er%20diagram.png)

### Ethical Concerns

A potential ethical concern could be raised by the design of the "users" table, which stores the e-mail addresses of the platform's users. The team has assessed the risk and impact of this concern and has concluded that the risk of this private data being compromised is low due to built-in security mechanisms in place by AWS and the fact that the database is only accessible by resources (Lambdas, virtual machines, etc.) within the team's AWS account. Furthermore, if the data ever were to be leaked, the impact would be fairly low, as the only private data stored is e-mail addresses.

### Retrieivng/Storing Data

To keep computational effort and time minimal for the user's client browser, the team decided it was best to execute storage and retrieval to/from the database on the server side, within the Lambda function that formats the data from Spotify to send to the user's browser. Following this pattern, no frontend code needed to be changed, since implementing this feature didn't require changing the interface shown in the [API Outline](API%20Outline.md).

## Implementation

Once the data model was designed, the database table definitions were written in SQL's DDL (data-definition language) and committed to the database.

### Storing to the database

The /usermetrics API implentation was changed to take the user's most recent songs returned from the Spotify Web API and store them, along with their artists and genres, into the database instance. So, effectively, each time a user logs on, their most recent songs get captured and stored in the database.

### Retrieving from the database

The /usermetrics API implementation was changed to retrieve from the database as well. Upon login, once the user's most recent song data is stored in the database, a SQL statement gets executed to return the entirety of the song data the database has stored for that user. As mentioned earlier, this change was made in a backwards-compatible way such that the data gets returned in the same format that is expected by the frontend code.

### Performance

Since conenctivity between AWS services is optimized by Amazon, the operations done by Lambda on RDS are very fast. So fast, in fact, that users of the site did not notice any increase in the time of their login flow, according to a small experiment conducted by the team.

However, the team noticed a possibly significant performance bug in the query to the database to retreive users' listening data. PostgreSQL's query planner, the engine that optimizes SQL queries for execution against the database, reported that the query had an arbitrary query "cost" around 455 (whose units are proportional to the number of disk operations). To mitigate this "expensive" query, the query was wrapped in a PostgreSQL function, which optimizes the database tables referenced in the function specifically for querying by the function. Doing this drastically reduced the estimated cost of the query down to around 5.

## Delivery

Per the team's spring development plan, this feature was slated to be completed on March 19, 2018. As shown by the last few relevant Git commits pictured below, this commitment was met by the team, and the feature was released to production on March 16, 2018.

![Commit History](/Images/db%20commit%20history.png)