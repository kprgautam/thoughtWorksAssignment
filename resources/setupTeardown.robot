*** Settings ***
Library  Selenium2Library

*** Variables ***
${url}          https://marsair.recruiting.thoughtworks.net/GowthamKolampaka
${browser}      firefox


*** Keywords ***
TestSetup
    OPEN BROWSER    ${url}    ${browser}
    MAXIMIZE BROWSER WINDOW

TestTeardown
    CLOSE ALL BROWSERS
