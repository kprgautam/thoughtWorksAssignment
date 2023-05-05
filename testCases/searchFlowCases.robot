*** Settings ***
Library         Selenium2Library
Resource        /Users/kprgautam/PycharmProjects/thoughtWorksAssignment/resources/setupTeardown.robot
Resource        /Users/kprgautam/PycharmProjects/thoughtWorksAssignment/resources/basicSearchFlow.robot

Test Setup      setupTeardown.TestSetup
Test Teardown   setupTeardown.TestTeardown

*** Test Cases ***
Verifying "Departure" and "Return" fields
    Verify there should be ‘departure’ fields on a search form.
    Verify there should be ‘return’ fields on a search form.

Verify flights leave every six months, in July and December, both ways.
    Verify departure and return have flights are present for every 6 months.

Verify Trips are searchable and search results are provided
    Verify trips for the next two years should be searchable.

Verify if Seats Available, then right message is displayed
    If there are seats, display “Seats available! Call 0800 MARSAIR to book!”

Verify if Seats unvailable, then right message is displayed
    If there are no seats, display “Sorry, there are no more seats available.”








