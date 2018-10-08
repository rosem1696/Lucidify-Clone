# Lucidify API Specification

## Table of Contents

- [Lucidify API Specification](#lucidify-api-specification)
    - [Table of Contents](#table-of-contents)
    - [Endpoints](#endpoints)
        - [GET /login](#get-login)
            - [Request Parameters](#request-parameters)
            - [Responses](#responses)
            - [Notes](#notes)
        - [GET /usermetrics](#get-usermetrics)
            - [Request Parameters](#request-parameters)
            - [Responses](#responses)
            - [Notes](#notes)

This document outlines the API endpoints that the Lucidify single-page web application will consume.

The base path for the Lucidify API is: <https://api.lucidi.fi/v1>

## Endpoints

### GET /login

**Example:** `https://api.lucidi.fi/v1/login?code=abcdef1234&state=ghijkl5678`

#### Request Parameters

- **code** - The authorization code provided by the Spotify accounts service
- **state** - A random piece of information that is used in secure client-server verification

#### Responses

- **302**
    - **Response Headers**
        - **Location**: `https://www.lucidi.fi/?session_id=SESSION_ID&username=USERNAME`
    - **Response Parameters**
    - **SESSION_ID** - A unique ID tied to a user's authorization token and refresh token
    - **USERNAME** - The user's Spotify username for display on the site

- **400**
  - No body, headers, or parameters
  - Occurs on missing request parameters

- **401**
  - No body, headers, or parameters
  - Occurs on invalid Spotify credentials provided

#### Notes

This endpoint is called by Spotify's account service once a successful login has occurred. It stores the access token and refresh token obtained by the Spotify account service in the Lucidify database and returns a unique session ID that ties the user to their auth tokens. This API fulfills steps 4 and 5 of the Authorization Code Flow provided by the Spotify authorization guide (see: <https://developer.spotify.com/web-api/authorization-guide/#authorization-code-flow>) On success, the endpoint redirects with a 302 response code to lucidi.fi, with the session ID and the user's username set as query string parameters.

### GET /usermetrics

**Example:** `https://api.lucidi.fi/v1/usermetrics&session_id=abcdef1234`

#### Request Parameters

- **session_id** - The unique session ID that relates to a user's authorization code in the database, which is used to make the request to Spotify to get the user's recent tracks, artists, and albums

#### Responses

- **200**
    - **Response Body**
        - JSON object

``` JSON
{
  genres : [
    {
      name : String,
      size : int,
      artists : [
        {
          name : String,
          artist_picture_url : String,
          artist_detail_url : String,
          songs : [
            {
              name : String,
              num_times_listened : int,
              song_detail_url : String
            }
          ]
        }
      ]
    }
  ]
}
```

- *400*
    - No body, headers, or parameters
    - Occurs when the session ID is invalid or expired

#### Notes

This endpoint is called by the frontend web application to obtain the data needed to build the bubble graph. It returns a JSON object which contains an array of genres that the user has recently listened to.