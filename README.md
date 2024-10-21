# Employee Attendance App

## Overview

The Employee Attendance App is a Swift-based application designed to manage employee check-ins . It utilizes the Model-View-ViewModel (MVVM) architectural pattern to separate concerns, making the codebase clean, maintainable, and testable. The app integrates Core Data for local data persistence, ensuring that employee attendance records are stored and fetched  effectively.

## Architecture

### Model-View-ViewModel (MVVM)

The app employs the MVVM design pattern, which enhances the separation of UI and business logic. This pattern consists of three main components:

- **Model**: Represents the data structure of the application. Examples are `Employee` and `Company` entities, which store information about employees and their companies.

- **View**: The views display the user interface. They bind to the ViewModel and react to data changes, providing a responsive experience.

- **ViewModel**: Acts as a bridge between the Model and the View. It contains the business logic and data processing, ensuring that the View remains free of logic. The ViewModel manages the state of the View, including loading data and handling user interactions. Examples are `DatePickerViewModel` and `StartViewModel`.

### Core Data

Core Data is managing the persistence of employee check-in records. The `CoreDataManager` class encapsulates all Core Data operations, including:

- Saving check-in records.
- Fetching the most recent check-in date.
- Managing `Company` entities.

The use of Core Data allows for seamless data management and supports complex data models, ensuring that user interactions with the app are smooth and responsive.

### Objective-C and Swift Interoperability

The application takes advantage of interoperability between Objective-C and Swift, allowing for the integration of legacy Objective-C code and new Swift components.

### SwiftUI and UIKit Integration

The app incorporates SwiftUI views within UIKit view controllers, enabling leveraging the strengths of both frameworks. This hybrid approach allows for a modern, declarative UI design with SwiftUI while maintaining compatibility with existing UIKit components.

### Background Management with Async-Await

The application leverages Swift's async-await feature to manage asynchronous operations seamlessly. 
- **Async-Await**: By using async functions, the performs asynchronous tasks without the complexity of traditional callback methods. This leads to cleaner and more understandable code.

- **MainActor**: The MainActor ensures that UI updates occur on the main thread, maintaining the responsiveness and integrity of the user interface.

Using async-await in conjunction with MainActor provides a robust framework for managing background tasks and updating the UI.

#### Key Features:

- **Date Picker**: A SwiftUI date picker is integrated into the UIKit environment, allowing users to select their check-in time seamlessly.
  
- **Loading and Error Handling**: The app provides visual feedback during data loading and manages errors gracefully, ensuring a smooth user experience.

- **Responsive Design**: The app is designed with user experience in mind, adapting to various screen sizes and orientations.

## Conclusion

The Employee Attendance App combines the power of MVVM architecture, Core Data for persistence, and interoperability between Objective-C and Swift. This structure  promotes clean code and also ensures that the app remains scalable and maintainable as new features are added.

