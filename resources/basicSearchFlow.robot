*** Settings ***
Library         Selenium2Library


*** Variables ***
${departurelist}        //select[@id='departing']
${departureText}        //label[normalize-space()='Departing']
${returnlist}           //select[@id='returning']
${returnText}           //label[normalize-space()='Returning']
${month1}               July
${month2}               December
${deplistval}           //select[@id='departing']//option[@value][normalize-space()]
${frequency}            3
${i}
${back}                 //a[normalize-space()='Back']
${search}               //input[@value='Search']
${searchResults}        //h2[normalize-space()='Search Results']
${seatsavail}           //p[normalize-space()='Seats available!']
${book}                 //p[normalize-space()='Call now on 0800 MARSAIR to book!']
${seatunavail}          //p[normalize-space()='Sorry, there are no more seats available.']

*** Keywords ***
Verify there should be ‘departure’ fields on a search form.
    WAIT UNTIL PAGE CONTAINS ELEMENT    ${departurelist}

    ${deptext}=    GET TEXT             ${departureText}
    SHOULD CONTAIN  ${deptext}          Departing

    ${deplist}=    GET TEXT             ${departurelist}
    SHOULD CONTAIN  ${deplist}          Select...

    LOG TO CONSOLE  Departure fields are present on the form.


Verify there should be ‘return’ fields on a search form.
    WAIT UNTIL PAGE CONTAINS ELEMENT    ${returnlist}

    ${rettext}=    GET TEXT             ${returnText}
    SHOULD CONTAIN  ${rettext}          Returning

    ${retlist}=    GET TEXT             ${returnlist}
    SHOULD CONTAIN  ${retlist}          Select...

    LOG TO CONSOLE  Return fields are present on the form.


Verify departure and return have flights are present for every 6 months.
    ${deplist}=    GET TEXT             ${departurelist}
    SHOULD CONTAIN X TIMES      ${deplist}      ${month1}      ${frequency}
    SHOULD CONTAIN X TIMES      ${deplist}      ${month2}      ${frequency}

    ${retlist}=    GET TEXT             ${returnlist}
    SHOULD CONTAIN X TIMES      ${retlist}      ${month1}      ${frequency}
    SHOULD CONTAIN X TIMES      ${retlist}      ${month2}       ${frequency}

    LOG TO CONSOLE     Both Departure and Return flights are available in ${month1} and ${month2}, once every 6 months for the next 2 years.



Verify trips for the next two years should be searchable.

    FOR    ${i}    IN RANGE    2    8

            CLICK ELEMENT  ${departurelist}
            ${departtext}=  GET TEXT    //select[@id='departing']//option[@value][${i}]
            CLICK ELEMENT               //select[@id='departing']//option[@value][${i}]

            FOR    ${i}    IN RANGE    2    8

                CLICK ELEMENT  ${returnlist}
                ${rettext}=      GET TEXT   //select[@id='returning']//option[@value][${i}]
                CLICK ELEMENT               //select[@id='returning']//option[@value][${i}]
                CLICK ELEMENT  ${search}

                ELEMENT TEXT SHOULD BE      ${searchResults}           Search Results
                LOG TO CONSOLE              Trip between ${departtext} and ${rettext} is searchable. Search Results provided.

                CLICK ELEMENT   ${back}

            END

    END

If there are seats, display “Seats available! Call 0800 MARSAIR to book!”

    FOR    ${i}    IN RANGE    2    8

            CLICK ELEMENT  ${departurelist}
            ${departtext}=  GET TEXT    //select[@id='departing']//option[@value][${i}]
            CLICK ELEMENT               //select[@id='departing']//option[@value][${i}]

            FOR    ${i}    IN RANGE    2    8

                CLICK ELEMENT  ${returnlist}
                ${rettext}=      GET TEXT   //select[@id='returning']//option[@value][${i}]
                CLICK ELEMENT               //select[@id='returning']//option[@value][${i}]
                CLICK ELEMENT  ${search}

                    ${avail}=       RUN KEYWORD AND RETURN STATUS  ELEMENT TEXT SHOULD BE     ${seatsavail}     Seats available!
                    ${booktext}=    RUN KEYWORD AND RETURN STATUS  ELEMENT TEXT SHOULD BE     ${book}           Call now on 0800 MARSAIR to book!
                    RUN KEYWORD IF  ${avail}        LOG TO CONSOLE      Congratulations !!!!
                    RUN KEYWORD IF  ${booktext}     LOG TO CONSOLE      Seats available between flights ${departtext} and ${rettext}.

                CLICK ELEMENT   ${back}

            END

    END



If there are no seats, display “Sorry, there are no more seats available.”

    FOR    ${i}    IN RANGE    2    8

            CLICK ELEMENT  ${departurelist}
            ${departtext}=  GET TEXT        //select[@id='departing']//option[@value][${i}]
            CLICK ELEMENT                   //select[@id='departing']//option[@value][${i}]

            FOR    ${i}    IN RANGE    2    8

                CLICK ELEMENT  ${returnlist}
                ${rettext}=      GET TEXT       //select[@id='returning']//option[@value][${i}]
                CLICK ELEMENT                   //select[@id='returning']//option[@value][${i}]
                CLICK ELEMENT  ${search}

                    ${unavail}=       RUN KEYWORD AND RETURN STATUS     ELEMENT TEXT SHOULD BE     ${seatunavail}     Sorry, there are no more seats available.
                    RUN KEYWORD IF  ${unavail}     LOG TO CONSOLE       Sorry. No seats available between flights ${departtext} and ${rettext}.

                CLICK ELEMENT   ${back}

            END

    END
