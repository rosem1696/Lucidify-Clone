# Database Analysis

## Pugh Matrix

| Criteria       | Weight | RDB     | DynamoDB  | SimpleDB |
| -------------- |:-------|:--------|:----------|:---------|
| Ease of use    | 2      | 2       | 4         | 3        |
| Cost           | 4      | 5       | 5         | 5        |
| Familiarity    | 2      | 3       | 4         | 3        |
| Read speed     | 3      | 3       | 3         | 3        |
| Write speed    | 2      | 3       | 3         | 3        |
| Integration    | 4      | 4       | 5         | 1        |
| Scalability    | 4      | 3       | 3         | 3        |
| Security       | 4      | 3       | 3         | 3        |
| Total          |        | **56**  | **69**    | **50**   |

## Options

- **Amazon RDS**
    - **Ease of Use**
    - **Cost** - pay for what you use; no setup fees or minimum fees
    - **Familiarity**
    - **Read speed**
    - **Write speed**
    - **Integration with infrastructure**
    - **Scalability** - Fast and easy to scale, but does not support increasing storage if you use SQL Server
    - **Security**

## AWS database

<https://cloudacademy.com/blog/aws-database-options/>

- Relational Database Service (RDB) <https://aws.amazon.com/rds>
    - Simple and fast to deploy
    - Simple and fast to scale
    - Fast
    - Pay for what you consume
    - Familiarity with MySQL, Oracle, SQL Server, or PostgreSQL
- DynamoDB <https://aws.amazon.com/dynamodb/>
    - NoSQL
    - Predictable, scalable
    - Low cost performance
    - Easy to set up
    - Supports both key-value and document data models
    - Doesn’t require a schema
    - Integrates with AWS Lambda
- Amazon ElastiCache
    - Cloud-based in-memory cache
    - Monitors and replaces nodes in case of failure
    - Improves performance by reducing disk reads
    - Useful for read-heavy applications
- Amazon Redshift
    - Parallel queries across multiple nodes
    - Execution speed scales up with cluster size
    - Built-in security
- SimpleDB
    - non-relational
    - Simple streamlined lookup and query functionality
    - Pay only for what you use