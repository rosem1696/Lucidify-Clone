# Lucidify - Frontend Functionality Test Plan

## Introduction

This document outlines a series of steps to test the functionality of the Lucidify platform, specifically from a user's perspective. The goal is to define what must be tested in order to ensure the site is working as expected or planned. The steps are designed such that either a human manual tester or automated test program could perform them and verify/quantify the results. This plan must be executed and verified before any new change is made to the lucidi.fi site.

- [Lucidify - Frontend Functionality Test Plan](#lucidify---frontend-functionality-test-plan)
    - [Introduction](#introduction)
    - [Prequisites and Setup](#prequisites-and-setup)
    - [Test Process](#test-process)
        - [Landing Page](#landing-page)
        - [Welcome Page](#welcome-page)
        - [Login](#login)
        - [Logout](#logout)
        - [Genre Graph](#genre-graph)
        - [Artist Graph](#artist-graph)
        - [Songs Graph](#songs-graph)
        - [Breadcrumbs](#breadcrumbs)

## Prequisites and Setup

This sections lists the conditions and setup necessary for testing. If these conditions are not met/available, the testing process will be either inaccurate or impossible to complete.

1. Step Description
    - **Perform:**
        1. Visit spotify.com
        2. Click on "Log In"
        3. Enter your Spotify credentials
        4. Click "LOG IN"
    - **Verify:**
        * The Spotify accounts overview loads.

## Test Process

The following tests are separate and must be marked as success or failure individually.

### Landing Page

The user can successfully load the site.

1. Step Description
    - **Perform:**
        1. Visit www.lucidi.fi in a web browser
    - **Verify:**
        * Lucidi.fi loads without errors.

### Welcome Page

The user can view the welcome page content, including the Navbar, the footer, the site statistics, and the about section.

1. Step Description
    - **Perform:**
        1. Visit www.lucidi.fi in a web browser
    - **Verify:**
        * The navbar, the footer, the site statistics, and the about section are visible.

### Login

The user can successfully log in to the site with their Spotify credentials, view their credentials on the navbar, and have the logout button be visible.

1. Step Description
    - **Perform:**
        1. Visit www.lucidi.fi in a web browser (private or incognito mode)
        2. Click the "LOG IN WITH SPOTIFY" button in the top right corner
        3. Click the "LOG IN TO SPOTIFY" button
        4. Type in your Spotify account username
        5. Type in your Spotify account password
        6. Click the "LOG IN" button
    - **Verify:**
        * The site loads and the user can successfully view their credentials (e-mail address) and a logout button in the navbar.

### Logout

The user, when logged on, can successfully log out of the site and return to the welcome page.

1. Step Description
    - **Perform:**
        1. Visit www.lucidi.fi in a web browser (private or incognito mode)
        2. Click the "LOG IN WITH SPOTIFY" button in the top right corner
        3. Click the "LOG IN TO SPOTIFY" button
        4. Type in your Spotify account username
        5. Type in your Spotify account password
        6. Click the "LOG IN" button
        7. Click the "LOG OUT" button in the top right corner of the screen
    - **Verify:**
        * The welcome page loads and the "LOG IN WITH SPOTIFY" button appears.

### Genre Graph

The user can successfully view the graph with genre bubbles.

1. Step Description
    - **Perform:**
        1. Visit www.lucidi.fi in a web browser (private or incognito mode)
        2. Click the "LOG IN WITH SPOTIFY" button in the top right corner
        3. Click the "LOG IN TO SPOTIFY" button
        4. Type in your Spotify account username
        5. Type in your Spotify account password
        6. Click the "LOG IN" button
        7. Wait for the site to load a graph
    - **Verify:**
        * A graph consisting of colored circles with the names of genres pertinent to the user's listening history appears (subjective to the user).

### Artist Graph

The user can click on a genre bubble in the genre graph and successfully load the graph of artist bubbles that correspond to that genre.

1. Step Description
    - **Perform:**
        1. Visit www.lucidi.fi in a web browser (private or incognito mode)
        2. Click the "LOG IN WITH SPOTIFY" button in the top right corner
        3. Click the "LOG IN TO SPOTIFY" button
        4. Type in your Spotify account username
        5. Type in your Spotify account password
        6. Click the "LOG IN" button
        7. Wait for the site to load a graph
        8. Click any genre circle
    - **Verify:**
        * A graph consisting of circles which are filled by the pictures of the artists that compose the clicked genre appears.

### Songs Graph

The user can click on an artist bubble in the artists graph and successfully load the image and table of songs that correspond to that artist.

1. Step Description
    - **Perform:**
        1. Visit www.lucidi.fi in a web browser (private or incognito mode)
        2. Click the "LOG IN WITH SPOTIFY" button in the top right corner
        3. Click the "LOG IN TO SPOTIFY" button
        4. Type in your Spotify account username
        5. Type in your Spotify account password
        6. Click the "LOG IN" button
        7. Wait for the site to load a graph
        8. Click any genre circle
        9. Click any artist circle
    - **Verify:**
        * The artist picture appears above the artist's name and the number of songs the user has listened to with that artist. Below, a table representing each song name, the number of times listened, and the date of the last listening appears.

### Breadcrumbs

The user can successfully load the proper genre graph or artist graph based on clicking the breadcrumbs on the left side of the site.

1. Step Description
    - **Perform:**
        1. Visit www.lucidi.fi in a web browser (private or incognito mode)
        2. Click the "LOG IN WITH SPOTIFY" button in the top right corner
        3. Click the "LOG IN TO SPOTIFY" button
        4. Type in your Spotify account username
        5. Type in your Spotify account password
        6. Click the "LOG IN" button
        7. Wait for the site to load a graph
        8. Click any genre circle
        9. Click any artist circle
        10. Click on the middle breadcrumb (corresponding to the genre)
    - **Verify:**
        * The songs table view is replaces with the artists graph.
2. Step Description
    - **Perform:**
        1. Visit www.lucidi.fi in a web browser (private or incognito mode)
        2. Click the "LOG IN WITH SPOTIFY" button in the top right corner
        3. Click the "LOG IN TO SPOTIFY" button
        4. Type in your Spotify account username
        5. Type in your Spotify account password
        6. Click the "LOG IN" button
        7. Wait for the site to load a graph
        8. Click any genre circle
        9. Click any artist circle
        10. Click on the top breadcrumb (corresponding to "Your Music")
    - **Verify:**
        * The songs table view is replaced with the genres graph.
