# Static Site - AWS Design

This document describes the design of the AWS components used to stand up the static site at lucidi.fi. These components include the AWS S3 bucket and the Route 53 DNS routing shown in the system architecture diagram in the System Requirements & Specifications document.

## S3 Bucket

S3 (Simple Storage Service) is a cloud storage service offered by AWS. It is an "object-based" storage service, which means it stores files as objects within "buckets". Within AWS, an S3 bucket can be set up to serve static files (HTML, CSS, and JavaScript) as a website. Lucidify will leverage this ability of S3 and be served from an S3 bucket. Serving the static site from S3 offers many advantages over hosting the site on a virtual server:

* **Cost** - It costs less than one cent per day to store the project's static files in S3, whereas hosting on a server would rack up charges just for the server being on.
* **Development Time & Effort** - Since AWS takes care of the routing and web server software connected to the S3 bucket, less time is required for setup and deployment. Hosting on a server would require regualar server maintenance, updates, etc., which would cost the team a lot of time.

## CloudFront Distribution

Once the S3 bucket with the static site files is set up, an AWS CloudFront distribution will be set up around the bucket. CloudFront is a CDN (content delivery network) which uses worldwide servers to cache the content of the S3 bucket to ensure users from around the world can access the site at very low latency. Using a CloudFront distribution is crucial to meeting the project's requirements in the areas of:

* **Speed** - Worldwide caching ensures that users around the world will be able to download the site files from a nearby server, instead of the datacenter the S3 bucket's contents are located.
* **Security** - The CloudFront distribution can be set up with an SSL certificate signed by Amazon. This means that the connection between the client (user) and the server is signed and encrypted with industry-standard encryption. This guarantees the user will not be connecting to a man-in-the-middle and downloading a malicious site when they attempt to connect to Lucidify.

## Route 53 DNS Routing

In order to point a human-readable and memorable domain name to Lucidify, a domain has to be registered within a domain registrar, and DNS (domain name service) records have to be created for it. AWS Route 53 will take care of both these items. The domain name lucidi.fi will be purchased from Route 53 and records will be created to point to the CloudFront distribution. More records will be created once the Lucidify API is designed.