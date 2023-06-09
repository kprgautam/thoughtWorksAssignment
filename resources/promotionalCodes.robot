*** Settings ***
Library         Selenium2Library


*** Variables ***
${regexp}               [A-Z]{2}\[1-9]{1}-[A-Z]{3}-[0-9]{3}
${modulus}              10
${departure}            //select[@id='departing']
${departval}            //select[@id='departing']//option[@value][normalize-space()][2]
${return}               //select[@id='returning']
${returnval}            //select[@id='returning']//option[@value][normalize-space()][7]
${search}               //input[@value='Search']
${promocode}            //input[@id='promotional_code']

*** Keywords ***
Promotional codes are in the format XX9-XXX-999.
    [Arguments]  ${code}
    SHOULD MATCH REGEXP     ${code}      ${regexp}
    ${digits}=  CREATE LIST  ${code}[2]     ${code}[8]    ${code}[9]      ${code}[10]
    ${sum}=     EVALUATE    (${code}[2]+${code}[8]+${code}[9])%${modulus}
    LOG TO CONSOLE  Sum of first 3 digits is ${sum}.
    LOG TO CONSOLE  Last digit is ${code}[10]

    ${status}=   RUN KEYWORD AND RETURN STATUS  SHOULD BE EQUAL AS STRINGS    ${code}[10]    ${sum}

    RUN KEYWORD IF  ${status}
    ...     LOG TO CONSOLE  Promotional Code is of correct format.
    ...     ELSE
    ...     LOG TO CONSOLE  Incorrect Promotional Code

First digit indicates the discount percentage
    [Arguments]     ${code}
    CLICK ELEMENT  ${departure}
    CLICK ELEMENT  ${departval}
    CLICK ELEMENT  ${return}
    CLICK ELEMENT  ${returnval}
    INPUT TEXT     ${promocode}     ${code}
    CLICK ELEMENT  ${search}

    ${digits}=  CREATE LIST  ${code}[2]

    PAGE SHOULD CONTAIN  Promotional code ${code} used: ${code}[2]0% discount!
    LOG TO CONSOLE       Discount % is calculated correctly.


Invalid Promo Code Message
    [Arguments]     ${code}

    CLICK ELEMENT  ${departure}
    CLICK ELEMENT  ${departval}
    CLICK ELEMENT  ${return}
    CLICK ELEMENT  ${returnval}
    INPUT TEXT     ${promocode}     ${code}
    CLICK ELEMENT  ${search}

    PAGE SHOULD CONTAIN  Sorry, code ${code} is not valid
    LOG TO CONSOLE       Code is validated to be incorrect.
