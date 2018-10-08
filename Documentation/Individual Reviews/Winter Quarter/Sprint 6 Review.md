# Individual Reviews for Sprint 6

## Anthony

- Worked: 4 hours
- Outlined how the artist graph is going to be structured
    - Artist graph as new vue component
        - will have mostly the same code
    - On click of genre node, will create sub-object containing artists and songs for that genre from the top level object.

## Mitch

- Worked: 8 hours
- Worked on database more
    - working on getting login to record new users and update the last login time
    - had trouble getting SQL to do a conditional in script
    - figured out how to do update/insert, need to finish lambda changes and test
- Talked with jack about changes from backend batch style update to user event driven collection

## Dylan

- Worked: 5 hours
- Started looking into footer
- Changed Nav bar
    - Made smaller for better aesthetic
    - Fixed button sizing and positioning
    - Worked on bordering/styling
- Fixed blurring on edges of screen
- Centered the view more button

## Trevor

- Worked: 6 hours
- CI Working: Deployable from master
    - Builds everything
    - Runs a dummy unit test
    - Pushes up to AWS
- Fixed Selenium Server issues
- Integration tests still having issues

## Jack

- Worked: 10 hours
- Added cookie expiration to auth token
    - No longer shown as logged in if token has expired
    - Added logout button, changes expiration on cookie to NOW 
- Changed font on site
- Custom color pallette on bubble graph
- Added enlarging animation on hover for small bubbles
- API call optimization
    - Making up to 3 spotify api calls per song, for up to 50 songs
    - Changed to making group api calls to get details for each album and each artist
    - 30 seconds down to 2 seconds run time!!!!!!!
- Talked about high level project changes with Mitch
    - Process/Ideal change from batch backend data gathering to user event driven data gathering
