# Flutter showcase test demo

Flutter project for the Demo architecture

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

## Structure Overview

- **customer_facade_service.dart**: Contains service definitions for customer-related operations, such as create, read, update, and delete customer data. Acts as a facade between the UI and the data layer.

## lib/common/

- **mixin/**
  - **form_mixin.dart**: Provides shared form functionality, such as validation or field updates.
  - **state_mixin.dart**: Offers utilities for managing the state of widgets or pages.
- **theme/**
  - **default.dart**: Defines the default visual styles for the app, including colors, fonts, and other UI properties.
- **utils/**
  - **validators.dart**: Contains functions for validating user input, like email and password validation.

## lib/config/

- **main.dart**: Initializes global configuration settings, such as theme, routing, and dependency injection setup.

## lib/domain/

- **entity/**
  - **customer.dart**: A data model representing a customer, including properties like name, email, etc.
  - **customer.g.dart**: Generated file for `customer.dart`, likely containing code for JSON serialization/deserialization.
- **interface/**
  - **customer_repository.dart**: An interface defining the expected functionalities of a customer repository, including fetching, adding, or removing customers.

## lib/infrastructure/

- **provider/**
  - **hive_data_provider.dart**: Uses Hive (a lightweight and fast NoSQL database) for storing data locally on the device.
- **repository/**
  - **customer_repository.dart**: Implements the `customer_repository` interface, providing logic for accessing customer data.
  - **mock_customer_repository.dart**: A mock implementation of the `customer_repository`, used for testing or development purposes.

## lib/injections.dart

- Responsible for setting up dependency injection, allowing easy management and access to dependencies throughout the codebase.

## lib/main.dart

- The entry point of the Flutter application. Includes setup for the app theme, routes, and home screen.

## lib/presentation/

- Contains the UI layer of the app, including screens and widgets.
- **customer_list/**, **save_customer/**: Directories for specific features or screens, containing both the UI (`page.dart`) and business logic (`controller.dart`).
- **widgets/**: Reusable UI components used across the app.

## lib/presentation/routes.dart

- Defines the routes for navigation within the app, mapping route names to the corresponding screens.

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