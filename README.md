# grassy: Project 1 @ GA sydney

grassy is a platform for simple, intuitive grassroots competition management. The first proof of concept is for a local soccer association and forms the second project for the Software Engineering Immersive at General Assembly, Sydney.

The primary aim for this project is to produce a Rails-based CRUD for users, matches, clubs, grounds, with the capability for users to keep track of their favourite teams. The project is [deployed on Heroku](https://grassy.herokuapp.com/).

## Minimum Requirements
* Rails CRUD
* Web-app
* Heroku-hosted

## Design objectives
* Highly functional: least surprise principal
* Clear navigation between types of data
* Intuitive and fast methods to find data desired
* Mobile-friendly

## Technologies Utilised
* Rails
* Kaminari - pagination of results
* Google Maps API
* Bcrypt - form validation
* Bootstrap

## Getting Started
* Head to [Heroku](https://grassy.herokuapp.com/) to check it out

## Reflections on Development
* More models & associations = lots more views to create, controllers and routes to configure
* Question mark on dynamic statistics calculation based on match scores OR storing stats against each team (e.g. MP, GF, GA, PTS etc)
* Bootstrap makes layouts of tabulated data pretty simple
* But I don't like how bootstrappy it looks...
* Lots of data built from from multiple models used on many pages: service objects were really useful for this

## Further Development
* Extrapolation for multiple associations in multiple sports, activity groups
* Player-based model to enable stats and registrations etc.
* Charts.js visualisation of stats
* Teamsheet completion
* So much more...

## Source
* GA Sydney set the task basis for this project, though the topic and execution was entirely up to the student. It just had to be a Rails-based CRUD web-app.
