
## Contents
- [The Challenge](#The-Challenge): Context for the requirements
- [What to build](#What-to-build): What solution should look like
- [Solution](#Solution): Presenting the solution and different caveats 
    - [Flows](#Flows)
    - [Testing](#Testing)
    - [Running it locally](#Run-It-Yourself)

*** 

### The Challenge
We’d like you to develop a “round-up” feature for Starling customers using our public
developer API that is available to all customers and partners.
For a customer, take all the transactions in a given week and round them up to the nearest
pound. For example with spending of £4.35, £5.20 and £0.87, the round-up would be £1.58.
This amount should then be transferred into a savings goal, helping the customer save for
future adventures.

Time:\
Documentation or source code comments to help your reviewer orient themselves would
also be appreciated! There is no hard deadline to submit our tech task, but most applicants
get it back to us within 7 days.

Submitting:\
Share a private github repo with the user starlingtechtest - ideally we’d like to
avoid lots of public solutions. Please include your name in the repository description, if it is
not obvious from your github profile, so we know whose code we are looking at!

API calls:\
To make this work, the key parts from our public API you will need are:\
**1. Accounts** - To retrieve accounts for the customer\
**2. Transaction feed** - To retrieve transactions for the customer\
**3. Savings Goals** - Create a savings goals and transfer money to savings goals\
We do expect to see your working here: please do not use any of the libraries out there
which provide an sdk for interacting with our api.

### What to build:
● **iOS**: Simple iOS application written in Swift and using UIKit. It should display the
amount to round up for a week of transactions

*** 

## Solution
The application was made using Xcode 15.0. Whilst the application minimum version is iOS 16, this should easily be reduced to older versions. I have developed it with default Xcode config, and now it used some URL syntax that is only iOS 16+. URL handling is not exactly magical, but as I write this ReadMe, it is too late to go back and change it all around. I trust the simplicity of the change would be apparent and would be happy to discuss on a pair programming session.\
There is 1 external dependency for a generic network client. That network client was developed by myself previously and enables a structured approach to building network calls, whilst enabling very good testability. I chose to use it as it saves me a few hours and from rebuilding something I already rebuilt for commercial use.\
The work was approached by building from the network first, creating endpoint structures and testing them, then moving towards the ViewModel and the ViewController.\
Hardcoding credentials inside `GlobalConfig` is chosen on this ocasion due to the project being a take home task and not intended for commercial use. That should not normally be acceptable and it can compromise the application security.

### Flows
The following diagram takes the observer though the flows of the application. The application actually stops at "Process latest SavingsGoals" within the ViewModel. The take home project requirement does not appear to require persisting the state on backend of the transfer, and whilst looking into it, many other challenges are appearing in regards to the behaviour.
<div align="center">
    <img width=100% src="https://github.com/melting-snowman/StarlingRoundUp/blob/main/Documentation/ActionFlow.jpg">
</div>

### Testing
`NetworkClient`, `Endpoint` & `DateExtension` are fully unit tested. Other types of testing have not been deployed (snapshot, UI, etc)
There is no test done on the ViewModel. Due to lack of time I have not tested it, but I did create a protocol over `NetworkClient` which would allow the testing of the ViewModel without actually mocking it. It is possible to break it down further in order to better encapsulate and test business logic, but for the purpose of this take home test I considered the current version to show a good working prototype.

### Run It Yourself
After fetching the codebase locally you should setup the user. As the application does not have an authentication mechanism, you will need to assign a `userToken` and an associated `accountHolderUID` inside `GlobalConfig.swift`.

***
