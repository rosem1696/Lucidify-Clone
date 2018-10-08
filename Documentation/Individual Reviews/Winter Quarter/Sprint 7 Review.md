# Individual Reviews for Sprint 6

## Mitch

- Worked: 6 hours
- Worked on Logo design with his brother Dan
    - Picked font to use for name (Roboto - Google Font)
    - Worked on styling font to make appealing
        - Got a really good design down
    - Picked good pairing font to use for team splash
    - Worked on trying to come up with a design mark.
        - Came up with a few decent looking abstract mark
        - Didn't make anything we really liked
    - Talked about color pallettes
- Worked with Jack on doing database schema design
    - Old schema would make a single entry for each user, store the last JSON recent tracks blob that they got, and then update that blob on every login
    - Reworked schema into one that stores artists and songs relationally
    - Implemented new schema on the database

## Dylan

- Worked: 2 hours
- Got the copyright footer working
    - Haven't pushed changes up to sight
    - Need to do minor styling still

## Trevor

- Worked: 4 hours
- Worked on integration testing working
    - Still running into issues with drivers etc.

## Jack

- Worked: 7 hours
- Added survey link to the site (below the genre graph)
- Changed site font to be Roboto, matching new logo design
- Set refresh token to not expire when Access token expires
- Worked with Mitch on changing database schema changes and implementation

## Anthony

- Worked: 7 hours
- Worked on development of Artist graph
    - First worked on re-using graph code (unloading current data and loading in new data)
        - Had trouble with this implementation
        - Decided to scrap this idea for now
    - Switched to creating a new component with most of the same code from the genre graph.
        - Having issues getting graph to display