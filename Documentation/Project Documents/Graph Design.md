# Lucidify Genre Graph Design

## Table of Contents

- [Lucidify Genre Graph Design](#lucidify-genre-graph-design)
    - [Table of Contents](#table-of-contents)
    - [Introduction](#introduction)
    - [Conceptual Overview](#conceptual-overview)
    - [Data Specifics](#data-specifics)
    - [Visualization Details](#visualization-details)
        - [Structure](#structure)
            - [Genre](#genre)
            - [Artist](#artist)
        - [Visuals and Animation](#visuals-and-animation)

## Introduction

This document contains the design and implementation details for the genre graph featured in the Lucidify application.

See [Lucidify UI Mockups](UI%20Mockups.md) for a visual example of the graph layout.

## Conceptual Overview

The goal of the graph is to visualize a user's listening data in a meaningful way. The user should be able to gleam new information about their music tastes and see changes as they continue to use Spotify.

Visualization will be performed using metrics taken from the user's Spotify account. It will portray to the user the number of times they have listened to a track from a particular genre or artist.

## Data Specifics

There are a significant number of metrics which can be retrieved from Spotify. This graph is built around the ability to acquire the user's recently played songs. The application collects the user's data periodically once they have logged into Lucidify.

From the track information, the corresponding artist and genres can be acquired. These are used as visual groupings for the listening counts.

Spotify contains additional metrics which can be obtained, including acousticness, popularity, danceability, etc. These may be implemented into the graph as supplemental statistics, but are not part of the core functionality.

## Visualization Details

The graph uses a weighted bubble chart design to visualize the number of plays contained in an artist or genre. The more plays, the larger the bubble is drawn.

### Structure
The chart is structured into 2 primary layers, artists and genres.

#### Genre

- The top level of the graph, and is the first the user sees in the application
- Each genre that has at least one  played track is displayed as a bubble
- Each genre bubble is sized based on the sum of its corresponding tracks' play counts
- Clicking on a bubble transitions the graph to the artist structure

#### Artist

- The second layer of the graph, seen by clicking into a genre bubble
- Each artist corresponding to the selected genre will be shown in the graph as a bubble
- Uses the same bubble structure as defined in the genre graph
- Clicking on an artist will transition into the artist and song statistics viewer.
    - This feature will be further documented at a later date.

### Visuals and Animation

This section contains miscellaneous information on the visual styling and polishing implemented in the graph.

- The transition from the genre graph to the artist graph will be animated with a zooming effect
    - Upon clicking on a bubble, the graph will zoom in and populate  new bubbles representing artists from the genre.
- The individual bubbles will be styled to allow differentiation between them
    - Genres bubbles are colored using a predefined color pallette
    - Artist bubbles are textured with their Spotify profile picture