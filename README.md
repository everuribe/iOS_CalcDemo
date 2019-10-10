# iOS-CalculatorDemo

Native Swift iOS calculator application that utilizes Core Data.

## Getting Started

### Prerequisites

This was built using XCode 11. However the application is based on the UIKit framework so XCode 10.2 should work.  Note that iOS deployment target is iOS 13.0.

### Installing

Download the source code and open iOS-CalculatorDemo.xcodeproj. No other installations are required. Hit run on simulator or device. Devices tested include iPads and iPhone X/XMax. 

## Using application

The application has two tabs controlled like pages: Calculator and History. The user alternates between views using a custom tab controller that acts more like a page controller. 

In Calculator tab, user taps calculator buttons to input numbers and perform operations on these numbers. There are two input/output views. A small top view to show the current equation if it exists and a larger view below it showing the user's current input. Calculators often have different rules so here are the main rules used for the app:
* Number is input on larger view. It transitions to equation view once operation is tapped and another number is input.
* Squaring, percent, and sign switch are performed on the number shown on the current input view (larger view).
* If an add, subtract, multiply, or divide operator is tapped consecutively to a previous operator of one of those types, it replaces the old operator in the equation.
* After calculation is performed, views will reset if new number is being typed. Otherwise, if an operator is tapped, a new equation is initiated. 

In History tab, user can see a table of previous calculations, starting from oldest to newest. This data is fetched/saved via a locally persisted object using Core Data. A button exists to clear all calculation history. If no calculations exist, a view indicating this will be shown. 

## Architectural Pattern

The MVC (model-view-controller) architecture is used to facilitate separation of business logic and user interface. MVC was chosen over MVVM for quick development. Although MVVM fares better in the long run (in supporting unit tests and readability), it's not a significant improvement for small apps like this. Once you add cloud features and more business logic it makes more sense to use MVVM. Files are separated as such:
* Controller - Contains view controller, tab control, and data handling extension/protcols. Extensions were separated into their own files to improve readability as necessary.
* View - Contains all the views for the History and Calculator pages.
* Extensions - Extensions on UIKit/Foundation classes to simplify some operations

## Design/Architecture Discussion
A page controlling method was used to alternate between views since the memory/processing of both views is insignificant. Arguably with such a very large amount of calculations, it would be important to start thinking about displaying the History tab with some other method (ie modal popover or push via a NavigationController). For the calculator view, UIStackViews were used to setup the buttons quickly and allow for auto spacing on whichever display size (using UICollectionView would have been overkill). Different colors were used to distinguish between numeric inputs, operators, and equal sign. For the history view, a UITableView was used to display data. 

This application was setup in a couple of hours but with some relatively easy adjustments, improvements can be made:
* Adding more functions to calculator.
* Adding ability to rotate UI with device
* Adding more information to history (time stamp) and functions like deleting a row
* Test on all device sizes to make sure constraints work for all 

Some more serious adjustments that would be helpful for production readiness would be: 
* Some complex sectioning of historical calculations table to improve quick searchability
* Refactoring to an MVVM architecture to further separate business logic and improve unit testing in the long run. This may or may not be significantly beneficial depending on how many features are added to the application. 
* Some of the logic functions may be verbose or share operations. There could be some simplification here. 

## Built With

* [Core Data](https://developer.apple.com/documentation/coredata) - Local data persistence

## Authors

* [Ever Uribe](https://github.com/everuribe)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


