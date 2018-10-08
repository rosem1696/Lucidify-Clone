# Static Site Hosting

This document details the design of the infrastructure that will be implemented to host Lucidify's static site. The static site includes the following:

- HTML - website structure and content
- CSS - website styling, fonts, colors, etc.
- JavaScript - logic that processes data from Spotify and the Lucidify API and organizes it into a user friendly format

These parts of the site are considered "static" because these parts of the site are delivered exactly as they are stored to the user. Regardless of the user's data from Spotify or the Lucidify API, the static parts of the site listed above will not change.

Basically, the static site acts as a template for data that will be filled in on page load by calls made by the JavaScript code (that gets run by the user's browser) to the Lucidify API or the Spotify API.

## Static Site Storage Using Amazon S3

Team Lucidify plans to use Amazon Web Services's Simple Storage Service, or S3. S3 acts as a cloud-based object storage mechanism. Object storage implies that files are stored as objects or "blobs" of data instead of organized into a file system. S3 is very inexpensive, and it is fast enough to efficiently serve the static website to any client worldwide.

## Static Site Routing Using Amazon Route 53

Amazon's DNS routing service is called Route 53. Route 53 will be used to register Lucidify's domain name, lucidi.fi, and will route requests to the domain name to S3, which the user's browser will download the site from.