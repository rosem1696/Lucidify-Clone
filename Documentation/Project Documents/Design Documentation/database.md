# Lucidify - Database Documentation

## Introduction

This document contains information on the setup, use, and implementation of the database used in the Lucidify application

## Table of Contents

- [Lucidify - Database Documentation](#lucidify---database-documentation)
    - [Introduction](#introduction)
    - [Table of Contents](#table-of-contents)
    - [AWS and Setup Details](#aws-and-setup-details)
        - [Database Type - Amazon Relational Database System (RDS)](#database-type---amazon-relational-database-system-rds)
        - [Engine - PostgreSQL](#engine---postgresql)
        - [AWS Instance - db.t2.micro](#aws-instance---dbt2micro)

## AWS and Setup Details

### Database Type - Amazon Relational Database System (RDS)

- AWS's hosted relational database option
- See [Technical Analysis](/Project%20Documents/Technology%20Analysis.md) for more information

### Engine - PostgreSQL

- Can index JSON, allowing for easier/more efficient storage of information coming from Spotify

### AWS Instance - db.t2.micro  

This section explains the information on the AWS instance type/tier chosen and the corresponding pricing information. This is apt to change after load testing is performed.

Useful

- Burstable performance database server instance
    - Pay flat monthly rate for uptime
    - Instance has performance threshold
        - Monthly rate allows use up to a certain CPU usage level
        - Additional charges incurred by surpassing aforementioned level
        - CPU credits earned hourly when below threshold
            - Used to pay for burst time
- Micro level
    - Lowest possible level in T2 (burstable)
    - Performance Stats
        - VCPU Cores = 1
        - RAM = 1 GiB
        - Network Performance = Low
- Storage
    - Pricing independent of T2 performance level
    - Pay per GB per month
    - Performance options
        - Magnetic
        - General Purpose SSD
        - Provisioned IOPS (SSD)
            - High performance storage for IO intensive applications
- Pricing Estimate
    - Estimation of monthly costs using AWS's [RDS Calculator Tool](http://calculator.s3.amazonaws.com/index.html#s=RDS)
    - Processing Costs
    - Storage Costs
        - General Purpose SSD - 10GB = $1.15 per month
        - 16% increase in price from Magnetic
    - Performance
        - T2 Micro - 100% Util = $13.18 per month
        - T2 Micro - 50% Util = 6.59 per month
        - T2 Micro - 25% Util = 3.30 per month
    - Sum Cost
        - Range likely $3.00-$20.00 per month
        - Accurate estimates will be made after load testing