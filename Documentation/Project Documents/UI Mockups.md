# Lucidify - User Interface Mockups

This document contains mockups for the multiple high level user interface components that will make up Lucidify. These mockups define what/where items will be displayed, how the user can interact with the visuals, and the actions that are caused by these interactions. Specific visual styling such as color, font, animation, etc. are not defined since they do not affect the high level function of the user interface.

- [Lucidify - User Interface Mockups](#lucidify---user-interface-mockups)
    - [Welcome Screen](#welcome-screen)
    - [Login Screen](#login-screen)
    - [Post Login](#post-login)
    - [Interactive Graph](#interactive-graph)
    - [Miscellaneous Statistics](#miscellaneous-statistics)

## Welcome Screen

This diagram shows what a new user will be greeted with when entering the site before logging into their account.

![Welcome Screen](/Images/UI%20Mockups/welcome%20screen.png)

The placeholder is for the Lucidify logo. When the user clicks on “What is Lucidify?” or the arrow, the page will scroll down a little bit to an explanation of the website and the services provided, likely including an interactive demo.

## Login Screen

In order to accomplish the Spotify account authentication and integration with Lucidify, a custom login screen cannot be used. Instead the Spotify OAuth login screen will be integrated in. UI design will not be done in the implementation of this component so no mockup is needed.

![Login Screen](/Images/UI%20Mockups/login%20screen.png)

Here is what the default Spotify Login screen looks like.

## Post Login

The following diagrams describe the general actions the user can perform immediately after logging into their account.

![Post Login Main View](/Images/UI%20Mockups/post%20login%20main.png)

Upon logging in, the user will be greeted with a web-graph of all the genres they've listened to since using our application. Each node of the graph will represent a genre from their listening history. On node click, the graph will zoom into a web-graph of all artists the user has listened to from that genre.

![Post Login Options Dropdown](/Images/UI%20Mockups/post%20login%20options.png)

In the top right corner of the screen will be a clickable icon to get to user settings, an About for our team and product, and a Sign Out button. We may add more here as time goes on.

![Post Login Hover Node](/Images/UI%20Mockups/post%20login%20hover.png)

If a bubble is too small to show the name of the genre it belongs to, hovering over the bubble will produce a tooltip to pop-up with the name of the genre.

![Post Login Transition to Other](/Images/UI%20Mockups/post%20login%20transition.png)

Hovering over the bottom of the screen will produce a clickable arrow to move down to the users "dashboard". Statistical graphs and song recommendations will be viewed there.

## Interactive Graph

The following diagrams show a basic overview for how users can navigate their personal listening graph, and the information it will show them.

![Node Graph Artist View](/Images/UI%20Mockups/node%20graph%20top.png)

After clicking a node on the genre graph, the screen zooms into the chosen node and displays a graph of artists that are included in that genre. Each artist is represented with their picture pulled from Spotify API. The largest artist node represents the artist most listened to by the user within the chosen genre. Each artists is connected in the graph by their similarities. The user can click any of the nodes on the graph to display further details about the selected artist. Additionally the user can click anywhere aside from the graph and the screen will zoom out to the general genre graph.

![Node Graph Artist Info](/Images/UI%20Mockups/node%20graph%20artist.png)

After clicking on a given artist, the screen zooms into the chosen node and displays a picture and name of the artist along with the tracks by that artist that fall into the previously selected genre category. The user can view the tracks they listened to for that artist and number of times they listened to it. Additionally the user can click on the background aside from the track list and artist image to zoom out and return to the artist graph.

![Node Graph Song Info](/Images/UI%20Mockups/node%20graph%20song.png)

The user can click on any of the tracks in the list to display additional information on that track. A tooltip will display with information on the track that the user selected. Each click on a track will bring up its respective tooltip and clicking off to the side will close the tool tip.

## Miscellaneous Statistics

The following diagram describes an optional planned component for Lucidify. Some miscellaneous and simple statistics graphs (bar, line, etc.) will be generated for each user from their recorded listening data. This mockup shows how the user will be able to interact with and navigate these graphs.

This component would be navigated to by scrolling down on the page or using the navigational arrow seen in the post login mockup.

![Miscellaneous Statistics Graphs](/Images/UI%20Mockups/misc%20statistics.png)

The graphs will be laid out on what is commonly called a Carousel. The user can navigate between graphs using the labeled buttons at the bottom, or the arrow panels on the right and left side of the screen. A transition animation (scroll, card stack, etc.) will also be present when performing navigation between graphs. Each graph will load its own visuals and settings when being viewed. The settings can be accessed through a drop down menu triggered by a button on the upper right of the graph.