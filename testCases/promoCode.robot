*** Settings ***
Library         Selenium2Library
Resource        /Users/kprgautam/PycharmProjects/thoughtWorksAssignment/resources/setupTeardown.robot
Resource        /Users/kprgautam/PycharmProjects/thoughtWorksAssignment/resources/promotionalCodes.robot

Test Setup     setupTeardown.TestSetup
Test Teardown  setupTeardown.TestTeardown

*** Test Cases ***
Verify Promotional Code format
    Promotional codes are in the format XX9-XXX-999.                AB9-SRH-009
    First digit indicates the discount percentage                   AB9-SRH-009

Verify invalid code message is as per design
    Invalid Promo Code Message                                      AF3-FJK-419




