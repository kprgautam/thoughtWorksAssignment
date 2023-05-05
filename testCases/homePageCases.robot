*** Settings ***
Library         Selenium2Library
Resource        /Users/kprgautam/PycharmProjects/thoughtWorksAssignment/resources/setupTeardown.robot
Resource        /Users/kprgautam/PycharmProjects/thoughtWorksAssignment/resources/linkToHomePage.robot

Test Setup      setupTeardown.TestSetup
Test Teardown   setupTeardown.TestTeardown


*** Test Cases ***
Homepage validation cases
    “Book a ticket to the red planet now!” should apperar somewhere prominent on the page.
    Clicking "Book a ticket..." text takes the user to the home page.
    Clicking the MarsAir logo on the top left should also take the user to the home page.

