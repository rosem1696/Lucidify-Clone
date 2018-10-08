# Lucidify: A Music History Visualization Tool for Spotify Users

## Table of Contents

- [Lucidify: A Music History Visualization Tool for Spotify Users](#lucidify-a-music-history-visualization-tool-for-spotify-users)
    - [Table of Contents](#table-of-contents)
    - [Introduction](#introduction)
    - [Project Members](#project-members)
    - [Description](#description)
    - [Completed Project Screenshots](#completed-project-screenshots)
        - [Example Genre Graphs](#example-genre-graphs)
        - [Example Artist Graph](#example-artist-graph)
        - [Example Artist Details View](#example-artist-details-view)
        - [Site Statistics View](#site-statistics-view)
    - [Senior Design Poster](#senior-design-poster)

## Introduction

This is a clone of the source from the original repositories which are stored privately on Gitlab.

Lucidify was created as a senior design project by five Software and Computer Engineering students at Milwaukee School of Engineering (MSOE).

The Lucidify website has been shutdown since the completion of project in May of 2018.

## Project Members

- John Schlederer: CE - Project Owner/Lead - Backend Engineer
- Mitchell Rose: CE - Project Manager - Backend Engineer
- Trevor Hacker: SE - QA Engineer - Frontend Engineer
- Dylan Kuchcinski: SE - Frontend Engineer
- Anthony Henderson: SE - Frontend Engineer
- Dr. Gerald Thomas: Advisor/Professor

## Description

Lucidify was a website service hosted on AWS that integrated with the user's Spotify account to give insights into the user's music tastes and listening habits.

After the user logs in using their Spotify account, Lucidify would retrieve the last 50 songs played by the user and add them to a database. It would then return their entire recorded history and display it as a multi-level bubble graph sized by number of listens. The graph would group their data by genre, and each genre could be selected to display the artists within that genre. Lastly the user could select an artist to view all songs listened to by that artist, how many times they were played, and the date and time of the most recent play of that song.

## Completed Project Screenshots

### Example Genre Graphs

![Main Graph 1](/Images/Screenshots/main_graph1.png)

![Main Graph 2](/Images/Screenshots/main_graph2.png)

![Main Graph 3](/Images/Screenshots/main_graph3.png)

### Example Artist Graph

![Artist Graph](/Images/Screenshots/artist_graph.png)

### Example Artist Details View

Note: This screenshot was taken before timestamps were added to the details.

![Artist Details](/Images/Screenshots/artist_details.png)

### Site Statistics View

This view was shown befroe a user logged into their Spotify account. It would dynamically load the statistics from the site database.

![Site Statistics](/Images/Screenshots/site_stats.png)

## Senior Design Poster

Team Lucidify was awarded 2nd place in the IEEE Milwaukee Section Larry Hause Poster Competition.

![Poster](/Images/Screenshots/poster.jpg)