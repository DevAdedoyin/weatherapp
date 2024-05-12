# Weather Monitor App
![Capture](https://github.com/DevAdedoyin/weatherapp/assets/59482569/950c21dc-7e0d-4b8d-8675-92f214b4a3e5)

## Project Description
The Weather Monitor App is a mobile application that helps users get real-time updates on weather conditions around the world. The main purpose of this project is to help users obtain weather data for their current location. This documentation contains a comprehensive guide on all you need to know about this project and how to use the mobile app.

## Download
<b color="red">The final version of this app is currently under review by the Google Playstore team. To run the app and test on your android device kindly download via the link below.</b>
### https://play.google.com/store/apps/details?id=com.weathermonitor.weatherapp

## Table of Content
- Installation guide and configuration
- Features
- Architecture
- Contributing
- License

## Installation guide and Configuration
### The installation process for this project is very straightforward.
1. Fork the repository.
2. Run, <b><i>git clone 'repo-link'</i></b> on your git.
3. You need to get an API key from Google for the geolocation to work.
4. You also need an API key from Open Weather to make the API endpoint get data for your location or searched location.
5. Finally run, <b><i>flutter run</i></b>.

## Features
### Authentication
- The first feature of the app is user authentication. Users are expected to either register an account using the app's signup feature by entering an email address and password. Alternatively, users can register using their Google account.
- Users can then Login with their verified email address and password
- In addition, users are allowed to use the app without going through authentication.
### Geolocation
- The app collects the user's current location to help generate weather for that specific coordinate or area.
- On first use, the app requests the user's permission to get the current location.
### Weather Data
- After getting the user's current location, if the user is unauthenticated, the user will see a limited amount of weather data and also only able to view the current weather data of their location. This means unauthenticated users can't get access to the app's full feature. This limited weather data includes the current temperature, weather description, humidity, sunrise, etc.
- Authenticated users have access to all other features of the app. For example, authenticated users get to see in detail weather data for the next 10 hours, and the next 10 days.
### Search Weather Data by Location
- Authenticated users can search for weather data for a variety of locations.
- The app comes with about 200 suggestions of popular places to make the search easier for users.
### Weather Data for the Next 7 days
- Authenticated users get to see weather data for the next 7 days in detail
### User Data Removal
- Authenticated users can request for their data to be deleted.
- Once a user clicks the "Remove account" button and confirms their action, their account automatically gets deleted without having to reach out to any admin.

## Architecture
This project uses the flutter Feature-First approach.
Each feature has the Presentation layer, Application layer, Domain layer and Data layer.
This approach helps to give the codebase and the app a consistent structure.

## Contributing
- Everyone interested in this project is welcome to contribute to the project.
- All you need to do is
  1. Fork the repo.
  2. Clone the repo.
  3. You can create a new branch if you want.
  4. Make your adjustments.
  5. git add and commit your changes.
  6. Push your changes.
  7. Make a pull request.
  8. Your pull request will be tested and merged.

## License
See the <a href="https://github.com/DevAdedoyin/weatherapp/blob/master/LICENSE.MD">LICENSE.md</a> file for license rights and limitations (MIT).
