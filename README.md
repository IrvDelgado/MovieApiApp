# iOS-apprenticeship-project-2022-1q


Thank you for participating in the iOS Apprenticeship program 2022 1Q!

This README file contains the instructions to complete the capstone project for the Apprenticeship program.


## Table of Contents

- [iOS-apprenticeship-project-2022-1q](#ios-apprenticeship-project-2022-1q)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [The Project](#the-project)
    - [Requirements](#requirements)
  - [Getting Started](#getting-started)
  - [App Contents](#app-contents)
  - [Deliverables](#deliverables)
    - [First Deliverable](#first-deliverable)
    - [Second Deliverable](#second-deliverable)
    - [Final Deliverable](#final-deliverable)
- [TheMovieDb API](#themoviedb-api)

## Introduction

This iOS Apprenticeship is looking to improve your iOS Technical skills. 

At the end of the course, you will have gained enough experience to recall the essence of several techniques related to the skills covered in the Apprenticeship, apply them correctly, and even provide shortcuts and quick ways for accomplishing your tasks. 

- iOS SDK 
- Swift 
- Presentation Patterns 
- Dependency Injection
- Networking 
- Software Design Principles
- Debugging 
- Persistence Layers 
- Mobile App Release Management

Additionally, you’ll understand how the technologies internally work and what are the dos and don'ts.


## The Project

The purpose of this project is for you to demonstrate your iOS skills.

This is your chance to show off everything you've learned during the Apprenticeship and to improve your Technical skills.

You will build and deliver a **whole** iOS application on your own.

We don't want to limit you by providing some *fill-in-the-blanks* exercises. Instead, we want you to build it from scratch. 

We hope you find this exercise challenging and engaging.

The goal is to build a `TheMovieDb` client app.

> \*_NOTE:_ Use `f6cd5c1a9e6c6b965fdcab0fa6ddd38a` as the api_key (Include this in your API calls!)\*

You should use this API just as a guide and as a trigger for your own ideas.
`It's not mandatory to use an especific UI component`. 
It is **YOUR** project and you can be creative in the way you build it.

### Requirements

These are the main requirements for your deliverable evaluation:

- Use all that you've learned in the course:
  - Swift best practices
  - Design Principles
    - SOLID
    - YAGNI
    - DRY
    - KISS
  - Design Patterns
  - Architectures
  - Dependency Injection
  - Unit Test
- Implement Unit Tests Coverage (~70%)

Keep the use of 3rd party libraries to the minimum, especially the ones related to the topics covered in the course.

For example, you can use an image downloader framework (such as Kingfisher) if that makes you feel more comfortable and move faster. However, we still want you to develop and deliver meaningful styled-components.

## Getting Started

We have provided an Xcode project in this repository.

The provided codebase is not directly related to the challenge topic, but you can use it as a guide for structuring your application. Feel free to add, remove, or change anything if you consider it necessary.

To get started, follow these steps:

**Step 1:** Follow the [TheMovieDb API](
https://developers.themoviedb.org/3/getting-started/introduction), you can create your own account or you can use this `f6cd5c1a9e6c6b965fdcab0fa6ddd38a` api key.

**Step 2:** After configuring the API key, you can read the [TheMovieDb API documentation](https://www.themoviedb.org/documentation/api) to get examples about how to consume the API.

**Step 3:** Create your own `main` branch `main-(your name)-(your lastname)`, example: main-steve-jobs

**Step 4:** Create your own `dev` branch `dev-(your name)-(your lastname)`,
example: dev-steve-jobs

**Step 5:** Create your task branches using `(your name)-(your lastname)-description`, example: steve-jobs-add-network-layer, you must create a PR for any new feature added to your project.

**Step 6:** Commit periodically. More info about [Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow).

**Step 7:** Configure [SwiftLint](https://github.com/realm/SwiftLint) in your project, this repository already contains a swiftlint file.

**Step 8:** Have fun!

## App Contents

The application interface must contain this next screens to be functional.

- Home View
  - Show movies
     - Trending
      - Now Playing
      - Popular
      - Top Rated 
      - Upcoming

- Search movie or person.
  -  Display results by keyword and by query.

- Movie Details View
  - Display the selected movie and its information.
  - Display overview.
  - Display cast.
  - Display similar movies.
  - Display recommended movies.
  - Option to read reviews.

- Reviews View
  - Display reviews

## Deliverables

We provide the delivery dates for you to plan accordingly. Please, take this challenge seriously and try to make progress constantly.

It’s worth mentioning that you’ll ONLY get feedback from the review team for your first and second deliverable, so you will have a chance to fix or improve the code based on our suggestions.

For the final deliverable, we will provide some feedback, but there is no extra review date. If you are struggling with something, we will be happy to help you via the [#q122-ios-apprenticeship](https://wizeline.slack.com/archives/C02S3FW8Q15) slack channel.

### First Deliverable 

Build an App from scratch in Swift with the following features:

* Request an existing and public Movie Database (TMDB) API.
* Consume KingFisher libraries to get all images.
* Apply background thread, URLSession, model (codables), async task (GCD).
* Design pattern MVC.
* Apply good standard library and design practices.
* Apply ALL design principles
* Apply SwiftLint (based on defined rules)
* Create your own repo with a personal account.
* Apply Storyboards on the UI.

> \*_Important:_ what’s listed in this deliverable is just for guidance and to help you distribute your workload; you can deliver more items if necessary.

### Second Deliverable 

Using what you've build from previous deliverable:

* Apply generics where you identified they are needed (Answer Key: at least in the network layer)
* Unit test - XCTest (network layer, models)
* Use os.log to log errors
* Refactor design pattern to MVVM
* Remove KingFisher interface and use NSCache
* Change Storyboards to a programmatic list for the UI (Constraints layouts)
* Apply Dependency Injection
* Apply Desing Patterns

### Final Deliverable 

Finish any pending functionality or address any comment you receive from your previous deliverables.

Keep using the same app from the previous phase:
 
- Apply RxSwift
- Use the Memory Graph to debug the application
- Profiling of memory leaks, stack review, performance review (General profiling based on learned with Instruments)
 - Apply SwiftUI on at least one screen

# TheMovieDb API

- Base Url:

```
https://api.themoviedb.org/3
```

- Trending [url](https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1)

```
/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1
```

- Now Playing [url](https://api.themoviedb.org/3/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1)
```
/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1
```

- Popular [url](https://api.themoviedb.org/3/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1)
```
/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1
```

- Top Rated [url](https://api.themoviedb.org/3/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=1&region=US)
```
/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=1&region=US
```

- Upcoming [url](https://api.themoviedb.org/3/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1)
```
/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1
```

- Keyword [url](https://api.themoviedb.org/3/search/keyword?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&query=Matrix)
```
/search/keyword?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&query=Matrix
```

- Search [url](https://api.themoviedb.org/3/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=2&query=Matrix%20)
```
/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=2&query=Matrix%20
```

- Reviews [url](https://api.themoviedb.org/3/movie/603/reviews?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&language=en-US)
```
/movie/603/reviews?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&language=en-US
```

- Similar movies [url](https://api.themoviedb.org/3/movie/603/similar?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en)
```
/movie/603/similar?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en
```

- Recommendations [url](https://api.themoviedb.org/3/movie/603/recommendations?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en)
```
/movie/603/recommendations?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en
```


> \*_Important:_ Don't forget to include any additional information that might be necessary for running your code (for example, test user credentials, etc).


![Screenshot 2023-03-01 at 15 25 53](https://user-images.githubusercontent.com/28610164/222268768-2f607b7f-8542-46eb-b373-c08c9e2a819a.png)
![Screenshot 2023-03-01 at 15 25 43](https://user-images.githubusercontent.com/28610164/222268774-077d2110-c604-45e8-8f34-f5375da57846.png)
![Screenshot 2023-03-01 at 15 25 13](https://user-images.githubusercontent.com/28610164/222268775-58d1b671-307c-4ac1-b727-680c4c3963e4.png)
![Screenshot 2023-03-01 at 15 25 04](https://user-images.githubusercontent.com/28610164/222268776-608f2ad7-55a5-44c9-94c4-9482e6f2200c.png)
![Screenshot 2023-03-01 at 15 24 49](https://user-images.githubusercontent.com/28610164/222268778-6ff79e2d-1e39-4f9c-85c7-f8a3ef60aaa8.png)
![Screenshot 2023-03-01 at 15 24 44](https://user-images.githubusercontent.com/28610164/222268779-b97ccc38-1d82-4800-aeef-884f8c0afe21.png)
![Screenshot 2023-03-01 at 15 24 27](https://user-images.githubusercontent.com/28610164/222268783-401b456c-eb1d-471f-84ab-23b3cc21f1c3.png)


