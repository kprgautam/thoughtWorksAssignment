*** Settings ***
Library         Selenium2Library

*** Variables ***
${departurelist}        //select[@id='departing']
${departureText}        //label[normalize-space()='Departing']
${returnlist}           //select[@id='returning']
${returnText}           //label[normalize-space()='Returning']
${deplistval}           //select[@id='departing']//option[@value][normalize-space()]
${i}
${back}                 //a[normalize-space()='Back']
${search}               //input[@value='Search']
${searchResults}        //h2[normalize-space()='Search Results']
${seatsavail}           //p[normalize-space()='Seats available!']
${book}                 //p[normalize-space()='Call now on 0800 MARSAIR to book!']
${seatunavail}          //p[normalize-space()='Sorry, there are no more seats available.']
${invaliddate}          //p[contains(text(),'Unfortunately, this schedule is not possible. Plea')]
${text}                 Unfortunately, this schedule is not possible. Please try again.

*** Keywords ***

“Unfortunately, this schedule is not possible. Please try again.” displayed when return date is less than 1 year from the departure.
    FOR    ${i}    IN RANGE   2  8

            CLICK ELEMENT  ${departurelist}
            ${departtext}=  GET TEXT   //select[@id='departing']//option[@value][${i}]
            CLICK ELEMENT  //select[@id='departing']//option[@value][${i}]

            FOR    ${i}    IN     ${i}+1

                EXIT FOR LOOP IF    ${i}==8
                ${rettext}=         GET TEXT  //select[@id='returning']//option[@value][${i}]
                CLICK ELEMENT       //select[@id='returning']//option[@value][${i}]
                CLICK ELEMENT       ${search}

                ${invalid}=       RUN KEYWORD AND RETURN STATUS  ELEMENT TEXT SHOULD BE     ${invaliddate}    ${text}
                RUN KEYWORD IF  ${invalid}
                ...     LOG TO CONSOLE      Return date is less than 1 year for flights between ${departtext} and ${rettext}.
                CLICK ELEMENT   ${back}

            END

    END

