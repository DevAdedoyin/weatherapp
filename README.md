![8504201](https://github.com/DevAdedoyin/weatherapp/assets/59482569/52ef2f87-f9b7-4ff3-ac80-eb4f71a48be6)

# Weather Monitor App

## Project Description
The Weather Monitor App is a mobile application that helps users get real-time updates on weather conditions around the world. The main purpose of this project is to help users obtain weather data for their current location. This documentation contains a comprehensive guide on all you need to know about this project and how to use the mobile app.

## Table of Content
- Feeatures
- Installation guide
- Usage
- Configuration
- Contributing
- License
- Contact Information

## Features
### Authentication 
- The first feature of the app is user authentication. Users are expected to either register an account using the app's signup feature by entering an email address and password. Alternatively, users can register using their Google, Apple or Facebook account.
- Users can then Login with their verified email address and password
- In addition, users are allowed to use the app without going through authentication.
### Geolocation
- The app collects the users current location to help generate weather for that specific coordinate or area.
- On first use the app requests the user's permision to get the current location.
### Weather Data
- After getting the user's current location, if the user is unauthenticated, the user will see a limited amount of weather data and also only able to view the current weather data of their location. This means unauthenticated users can't get access to the app full feature. This limited weather data includes current temperature, weather description, humidity, sunrise e.t.c
- Authenticated users have access to all other features of the app. For example, authenticated users get to see the in detail the weather data of the next 10 hours, and next 10 days.
### Search Weather Data by Location
- Authenticated users can search for weather data for variety of locations.
- The app comes in with about 200 suggestions of popular places to make the search easier for users.
### Weather Data for the Next 10 days
- Authenticated users get to see weather data for the next 10 days in details
### User Data Removal
- Authenticated users can request for their data be deleted.
- Once a user clicks the "Remove account" button and confirms their action, their account automaticaly gets deleted without having to reach out to any admin.

