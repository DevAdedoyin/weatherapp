![8504201](https://github.com/DevAdedoyin/weatherapp/assets/59482569/52ef2f87-f9b7-4ff3-ac80-eb4f71a48be6)

# Weather Monitor App

## Project Description
The Weather Monitor App is a mobile application that helps users get real-time updates on weather conditions around the world. The main purpose of this project is to help users obtain weather data for their current location. This documentation contains a comprehensive guide on all you need to know about this project and how to use the mobile app.

## Table of Content
- Features
- Installation guide
- Usage
- Configuration
- Contributing
- License
- Contact Information

## Features
### Authentication
![Screenshot_20240405-005345](https://github.com/DevAdedoyin/weatherapp/assets/59482569/23ce795e-4d3c-4e69-b1b2-24e3c2a48dea)
![Screenshot_20240405-005331](https://github.com/DevAdedoyin/weatherapp/assets/59482569/43aefccb-5d77-4279-b7ff-787b35fb8294)
![Screenshot_20240405-005319](https://github.com/DevAdedoyin/weatherapp/assets/59482569/9d75c232-f149-4521-8c69-8f6c1edc6224)
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
### Weather Data for the Next 10 days
- Authenticated users get to see weather data for the next 10 days in detail
### User Data Removal
- Authenticated users can request for their data to be deleted.
- Once a user clicks the "Remove account" button and confirms their action, their account automatically gets deleted without having to reach out to any admin.

