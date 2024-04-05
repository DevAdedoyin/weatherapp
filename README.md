![8504201](https://github.com/DevAdedoyin/weatherapp/assets/59482569/52ef2f87-f9b7-4ff3-ac80-eb4f71a48be6)

# Weather Monitor App

## Project Description
The Weather Monitor App is a mobile application that helps users get real-time updates on weather conditions around the world. The main purpose of this project is to help users obtain weather data for their current location. This documentation contains a comprehensive guide on all you need to know about this project and how to use the mobile app.

## Table of Content
- Installation guide
- Features
- Usage
- Configuration
- Contributing
- License
- Contact Information

## Installation guide
The installation process for this project is very straightforward.
1. Fork the repository.
2. Run, <b><i>git clone 'repo-link'</i></b> on your git.
3. You need to get an API key from Google for the geolocation to work.
4. You also need an API key from Open Weather to make the API endpoint get data for your location or searched location.
5. Finally run <b><i>flutter run</i></b>.

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


