# Flutter showcase test demo

Flutter project for the Demo architecture

<!-- TOC -->

- [Flutter architecture demo](#flutter-architecture-demo)
    - [Setup](#setup)
    - [Architecture](#architecture)
        - [UI](#ui)
        - [Presentation](#presentation)
        - [Domain](#domain)
        - [Data](#data)
        - [Navigation](#navigation)
            - [Navigator](#navigator)
            - [Route](#route)
            - [AppNavigator class](#appnavigator-class)
        - [Example](#example)
    - [Tools](#tools)
        - [FVM](#fvm)
        - [Code templates](#code-templates)
            - [Mason commands](#mason-commands)
        - [Custom lints](#custom-lints)
        - [Fluttergen](#fluttergen)
        - [Dart code metrics](#dart-code-metrics)
        - [Fastlane](#fastlane)
    - [Code best practices & guidelines](#code-best-practices--guidelines)
        - [Pull Requests checklist](#pull-requests-checklist)
        - [General](#general)
        - [UseCase](#usecase)
        - [Repository](#repository)
        - [Failures](#failures)
            - [Example](#example)
        - [Domain entity](#domain-entity)
            - [Example](#example)
        - [Presenter](#presenter)
        - [ViewModel](#viewmodel)
        - [PresentationModel](#presentationmodel)
        - [Page](#page)
        - [Json classes](#json-classes)
            - [Example](#example)
    - [Collaborating guidelines](#collaborating-guidelines)
        - [New libraries](#new-libraries)

<!-- TOC -->

## Setup

1. Install [flutter_gen](https://pub.dev/packages/flutter_gen) in your system and run:

   ```bash  
   flutter pub get
   ```  

    ```bash  
   flutter pub upgrade
   ```  
This command comes useful when you want to make sure your code is clean and ready to be code-reviewed. it does the following:

- runs [dart fix --apply](https://dart.dev/tools/dart-fix)
- formats your code

- runs `flutter analyze`

- runs[dart run build_runner build](https://dart.dev/tools/build_runner)
- general-purpose commands for generating files

## Architecture

The app follows clean architecture principles and is divided into 4 modules:
![modules diagram](docs/modules.png)
![modules diagram](docs/modules_details.png)

### UI

The UI Module contains Flutter widgets, animations, routes, pages and all the code that is responsible for the
appearance of the app. Furthermore, it is important to note that the module omits logic.

### Presentation

Presenters decide **WHEN** to display things. They trigger business logic from the `domain` module as well as update
the `Customer` with relevant data, that is then used by the UI.

### Domain

`Entity` and `Interface` classes.

This module contains the business logic of the application. It decides **WHAT** should be done in the event of user
interaction.

Repository interfaces are specified inside the `domain` module and are implemented by the `data` module. All the data
that `domain` operates on is encapsulated into domain entity classes.

### Data

The Data module takes care of communicating with the “outer world” and interacts with third party libraries. Here we
specify the Firebase, _SharedPrefs_ or external sensor access. All the data is then
translated to domain entities that are agnostic of the libraries and technologies used in order to access them.

### Navigation

Navigation within the app uses the concept of Go Router.

#### Navigator

Assume we have a navigator for the `saveCustomer` called `saveCustomer`:

```dart
 await GoRouter.of(context).push(Routes.saveCustomer);
```

#### Route

Below you can see an implementation of the route

```dart
  GoRoute(
    path: saveCustomer,
    builder: (context, state) => SaveCustomerPage(
      initialValue: state.extra as CustomerEntity?,
    ),
  ),
```

## Tools

Here is a list of different tools we use in the project that augment and help with our day-to-day jobs

## Code best practices & guidelines

### Pull Requests checklist

| Rule                                                           | Explanation                                                                                                                                                                                                                                                                  |
|----------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Add proper prefix to the PR title (`feat:`, `fix:`, `chore:` , `refactor:`)**                                               | [Link](https://www.conventionalcommits.org/en/v1.0.0/)                                                                                                                                                                                                                       |
| **Review your own PR first**                                   | Reading trough your own pr helps spot obvious errors and it saves time for the reviewer                                                                                                                                                                                      |
| **Make sure all CI checks pass**                               | CI is meant to catch formatting and lint errors, make use of that and don't force others to do the machine's job :)                                                                                                                                                          |
| **Run the app and test it yourself**                           | Before reviewing a PR or when issuing your own code, make sure to run the app and test it making sure the code doesn't break anything and works correctly                                                                                                                    |
| **Don't be afraid to ask questions**                           | Code review is meant not only to find errors in someone's code, but it's also about making sure you understand the code and know what is going on. Don't be afraid to ask questions, if anything looks unclear to you, don't assume that it's your fault, ask a question! :) |

### General

| Rule                                                                      | Explanation                                                                                                                                                                                                      |
|---------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Use trailing commas for method/constructor parameters and definitions** | This way each param is in a separate line and adding new params is much easier to read in PRs                                                                                                                    |
| **Prefer named parameters**                                               | Whenever using more than one param, consider using named parameters, i.e: <font color="Red">Bad:</font>`getBalances(true,"1283184")`, <font color="Green">Bad:</font>`getBalances(id: "1283184", refresh: true)` |

## Collaborating guidelines

Here are few rules/thoughts to remember when working on this project

### New libraries

Before adding new libraries to the project, please consult it with the team and tech leaders.  
It's important to not pollute the code with low-quality libraries as it might impose code vulnerabilities  
and make the maintenance much harder. If a solution provided by library is trivial, its better to host the code  
inside the project rather than relying on third parties

### Criteria

please fork this repo to your own space and complete the task there on a separate, feature branch.
when done, issue a pull request to your own repo and send the link to the pull request in your own repo. NOTE: do not open pull request to the upstream repository (`Elbruz Technologies/flutter-showcase-test`)


### Task

familiarize yourself with `README.md` file and the architecture description briefly

inside `CustomerListPage` apply a widget to display pull to refresh functionality using `pull_to_refresh` package 

inside `CustomerListPage` let the page show no data if the list is empty. use `no-result.svg` as image to display no data with text and a button to add new customer

inside `CustomerListController` add `onTapNewCustomer` function responsible to navigate the user to `SaveCustomerPage`

inside `CustomerListPage` add `floatingActionButton` that navigate to `SaveCustomerPage`

inside `SaveCustomerPage` add text field validations for these fields `Last Name`

`Last Name` Should be min Length 2 and max Length 40

inside `SaveCustomerPage` add `Birth Date` Picker to let user enter his birth date and display it in Customer List row

inside `SaveCustomerPage` give the user the ability to pick between all countires in phone field 

inside `SaveCustomerPage` when press on `Save` button the user will added to localy your task is to add the user inside the `Firestore`

while add user is working, show `CircularProgressIndicator` in place of save button.

if the user added successfully, show success dialog

if save fails, show error dialog and apply `Error Handling` to enusre no error will stop or crash the app 

inside `CustomerListPage` add `delete` button beide the edit button to remove the user 

to `delete` the user make a function called `onTapDelete` and do not forget to use `showConfirmDialog` befote the deletion process

when `onTapDelete` excute remove the user from locale and from `Firestore`
#   e l b r u z - s h o w c a s e - t e s t  
 