# CapgeminiAssignment
IOS app that displays information about Canada with images

## Build and Runtime Requirements ##
Xcode 9.0 or later iOS 8.0 or later OS X v10.12 or later

### Language Used ###
Swift 4.0

## Configuring the Project ##
Please clone the project in your local machine and open with the latest version of Xcode. Build and run the project after selecting a device from the device inspector.

## Design Goal:
Design goal is to mimimise dependencies between controllers and models. Fetch, filter and model data asynchronously and populate the views on the main queue and make use of protocol oriented principles of the swift language to maintain decent level of decoupling within the application logic.

## Design Consideration ##
Minimise the use of third party API's. Hence no third party API's used.

### Unit Tests ###
Unit tests are written to test asynchronous code and Helper code which processes String data to return height. Also Unit tests are written for json parsing. 
