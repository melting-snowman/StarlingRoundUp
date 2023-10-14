# Alex Ioja-Yang
take home task for Starling

***

# StarlingRoundUp
Coding task from Starling

***


## Contents
- [The Challenge](#The-Challenge): Context for the requirements
- [What to build](#What-to-build): What solution should look like
- [Solution](#Solution): Documentation on solution


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

### What to build:\
● **iOS**: Simple iOS application written in Swift and using UIKit. It should display the
amount to round up for a week of transactions

*** 

## Sollution

<div align="center">
    <img width=40% src="https://github.com/melting-snowman/StarlingRoundUp/blob/main/Documentation/ActionFlow.jpg">
</div>
