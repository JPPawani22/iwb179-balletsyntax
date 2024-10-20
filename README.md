# Apartment Management System

## Project Overview

The **Servio - Apartment Management System** is designed to streamline and automate communication between apartment owners and residents. Our system provides real-time management of tenant inquiries, service requests, and announcements, utilizing **Ballerina** for backend microservices and **Firebase** for tenant data management. The application also offers functionality for managing apartment bookings, payments, and tenant profiles.



## Features

- **Tenant Management**: Easily manage tenant information such as check-in/check-out, room details, and payment statuses.
- **Service Inquiries**: Tenants can submit service inquiries, and apartment owners receive notifications via email.
- **Announcements**: Owners can post announcements that are instantly available to residents.
- **Real-Time Notifications**: Automated email notifications for inquiries and announcements.
- **Firebase Integration**: Seamless integration with Firebase for managing resident data, inquiries, and announcements.
- **Multi-Platform Support**: Available on Android, iOS, and Web platforms.


## Project Structure

- **Ballerina Services**: Handles inquiries and announcements between the tenants and apartment management.
- **Flutter Frontend**: Provides an intuitive user interface for tenants and apartment owners.
- **Firebase**: Used for data storage, including tenant details, room information, and inquiry tracking.

### Key Folders:

- **/lib/**: Contains the main Flutter codebase.
  - **/features/**: Core features like authentication, announcements, bookings, payments, and residents.
  - **/widgets/**: Reusable UI components like tenant name cards and facilities cards.
  - **/models/**: Data models such as `resident_model.dart` for tenants and `room_model.dart` for room management.
  - **/controllers/**: Handles business logic, such as managing room bookings and announcements.
  
- **/ballerina_inquiry/**: Contains the Ballerina service that sends notifications and manages inquiries.
  
- **/utils/**: Utility files for constants related to animations, colors, images, and text styles.

- **/assets/**: Images, icons, and other static resources used in the application.
  
- **/configs/**: Configuration files for different environments (e.g., development and release settings).



## How We Used Ballerina

- **Microservices Architecture**: Ballerina is used to build and deploy microservices for managing tenant inquiries and sending announcements.
- **Email Notifications**: Ballerina handles the backend logic for sending automated email notifications when a tenant submits an inquiry or when an announcement is posted.



## Setup and Installation

1. **Clone the repository**:
   
   git clone https://github.com/JPPawani22/iwb179-balletsyntax.git
  

2. **Navigate to the project folder**:

   cd apartment-management-system
   

3. **Install Flutter dependencies**:
   
   flutter pub get
   

4. **Run the Flutter app**:
   
   flutter run
  

5. **Deploy Ballerina services**:
   Ensure Ballerina is installed and configured correctly. Then navigate to the `ballerina_inquiry` folder and deploy services.



