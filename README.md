# ShowTime

--Seamlessly discover favorite movies with ease!--

A Flutter application for listing movies based on two categories(NowPlaying and TopRated) and providing local search functionality.
This app follows the BLoC (Business Logic Component) architecture and MVVM (Model-View-ViewModel) pattern for managing state and UI separation.

## Features

- Display movies from two categories: "Now Playing" and "Top Rated".
- Implement search functionality to filter movies by name.
- Efficient API caching for faster load times and reduced data usage.
- Scroll endlessly through the movie lists with smart pagination.
- Refresh movies list using simple pull down gesture.
- Utilize BLoC architecture for managing business logic and state.
- Follow MVVM pattern for clear separation of concerns.
- Fetch user location for enhanced performance and personalized content.


### Prerequisites

- Flutter SDK
- Dart SDK

## Getting Started

To run this application locally, follow these steps:

1. Make sure you have Flutter installed. For installation instructions, refer to the [Flutter documentation](https://flutter.dev/docs/get-started/install).
2. Clone this repository to your local machine.
3. Navigate to the project directory and run `flutter pub get` to install dependencies.
4. Connect a device or start an emulator.
5. Run the app using the command `flutter run`.

## Dependencies

This project uses several third-party dependencies. Some of the key dependencies include:

- `flutter_bloc`: Provides tools for implementing BLoC architecture in Flutter.
- `geolocator`: Allows fetching user location for personalized content.
- `geocoding`: Used for getting users location details from latitude and longitude.
- `get_it`: Used for Dependency Injection.
- `http`: Used for making HTTP requests to fetch movie data.
- `cached_network_image`: Enables caching of movie poster images for improved performance.

For a full list of dependencies, refer to the `pubspec.yaml` file.

## Directory Structure
lib/
|-- config/ # you'll find files dedicated to configuration settings used across your application.
|-- core/ # directory hosts fundamental modules and utilities essential for the application's functionality.
|-- features # where individual features of our application are organized, to promote modularization and maintainability.
| -- home # directory contains the landing and launch screens
| -- data # encompasses functionalities related to data handling specific to the landing and launch screen features.
This includes data sources (such as API clients or Cache Service), repositories for data access, and data models or entities tailored for this feature.
| -- domain # the business logic of the landing and launch screen features resides. Here, you'll find use cases or inter actors defining the operations and actions pertinent to the feature's domain.
| -- presentation # is dedicated to the UI and presentation logic of landing and launch screen


## License
Distributed under the MIT License. See LICENSE for more information.

## Contact

Twitter - https://x.com/iamSmkz
LinkedIn - https://www.linkedin.com/in/iamsmk

## Acknowledgements
Flutter
BLoC
MovieDB API