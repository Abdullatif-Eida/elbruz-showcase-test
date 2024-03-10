# Flutter showcase test

Flutter project for the architecture

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

- runs [dart run build_runner build](https://dart.dev/tools/build_runner)
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


### Tasks

### Customer List Page

- **Pull to Refresh**
  - Implement a widget using the `pull_to_refresh` package to enable pull-to-refresh functionality on the `CustomerListPage`.

- **Empty List Placeholder**
  - Display a "No Data" message with an `no-result.svg` image when the customer list is empty. Include a button to navigate the user to `SaveCustomerPage` for adding a new customer.

- **Floating Action Button**
  - Add a floating action button to `CustomerListPage` that navigates the user to `SaveCustomerPage` for adding new customers.

### Customer List Controller

- **New Customer Navigation**
  - Implement an `onTapNewCustomer` function to navigate the user to `SaveCustomerPage`.

### Save Customer Page

- **Last Name Validation**
  - Add text field validation for the Last Name field, requiring a minimum length of 2 characters and a maximum length of 40 characters.

- **Birth Date Picker**
  - Integrate a Birth Date Picker to allow users to enter their birth date, which will be displayed in the customer list row.

- **Phone Field Country Selection**
  - Enable users to pick from all countries in the phone field to enhance user input accuracy.

- **Firestore Integration and Feedback**
  - Upon pressing the Save button, add the new user to Firestore. Show a `CircularProgressIndicator` while the save operation is in progress.
  - Display a success dialog if the user is added successfully.
  - Show an error dialog in case of a failure, ensuring the application handles errors gracefully without crashing.

### Customer Deletion

- **Deletion with Confirmation**
  - Add a delete button next to the edit button on `CustomerListPage` to enable user deletion.
  - Implement an `onTapDelete` function that removes the user from both the local storage and Firestore. Ensure a confirmation dialog is shown before proceeding with the deletion.
