*** Settings ***
Library         Selenium2Library

*** Variables ***
${elementText}          //h3[normalize-space()='Book a ticket to the red planet now!']
${reportissue}          //a[normalize-space()='Report an issue']
${logo}                 //a[normalize-space()='MarsAir']
${url}                  https://marsair.recruiting.thoughtworks.net/GowthamKolampaka
${containtText}         Book a ticket to the red planet now!
${assertText}           “Book a ticket to the red planet now!” text is present.
${logReport}            Successfully moved to Report page.
${logHome}              Successfully moved back to Home page.


*** Keywords ***
“Book a ticket to the red planet now!” should apperar somewhere prominent on the page.
    PAGE SHOULD CONTAIN     ${containtText}
    LOG TO CONSOLE          ${assertText}


Clicking "Book a ticket..." text takes the user to the home page.
    ELEMENT SHOULD BE ENABLED       ${elementText}
    CLICK ELEMENT                   ${elementText}


Clicking the MarsAir logo on the top left should also take the user to the home page.
    CLICK ELEMENT       ${reportissue}
    ${url1}=             GET LOCATION
    SHOULD NOT BE EQUAL AS STRINGS      ${url1}      ${url}
    LOG TO CONSOLE      ${logReport}
    CLICK ELEMENT       ${logo}
    ${url2}=             GET LOCATION
    SHOULD BE EQUAL AS STRINGS          ${url2}      ${url}
    LOG TO CONSOLE      ${logHome}




