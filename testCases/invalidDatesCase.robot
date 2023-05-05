*** Settings ***
Library         Selenium2Library
Resource        /Users/kprgautam/PycharmProjects/thoughtWorksAssignment/resources/setupTeardown.robot
Resource        /Users/kprgautam/PycharmProjects/thoughtWorksAssignment/resources/invalidReturnDates.robot

Test Setup      setupTeardown.TestSetup
Test Teardown   setupTeardown.TestTeardown

*** Test Cases ***
Verify correct message is displayed when dates are invalid
    “Unfortunately, this schedule is not possible. Please try again.” displayed when return date is less than 1 year from the departure.
