*** Settings ***
Library         Selenium2Library
Test Teardown   [Teardown]

*** Variables ***
${url2}                 https://www.linkedin.com/
${browser2}             chrome
${usernameField}        //input[@id='session_key']
${passwordField}        //input[@id='session_password']
${email}                kprgautam@gmail.com
${password}             3_Maheshbabu
${submit}               //button[@type='submit']
${search}               //input[@placeholder='Search']
${people}               //button[@role='link'][normalize-space()='Posts']
${peopler}              //button[@role='link'][normalize-space()='People']
${results}              //a[normalize-space()='See all people results']
${QA}                   Senior Quality Assurance
${HR}                   Talent Accquisition
${button}               ENTER
${i}
${j}
${connect}              (//span[@class='artdeco-button__text'][normalize-space()='Connect'])
${send}                 //span[normalize-space()='Send']
${next}                 //span[normalize-space()='Next']
${text}                 You can add a note to personalize your invitation
${connectFirst}         (//span[@class='artdeco-button__text'][normalize-space()='Connect'])[1]
${connectSecond}        (//span[@class='artdeco-button__text'][normalize-space()='Connect'])[2]
${textsorry}            Sorry, invitation not sent to
${close}                (//*[name()='svg'][@class='mercado-match'])[2]

*** Keywords ***
[Teardown]
    CLOSE ALL BROWSERS

CleanClick
    [Arguments]  ${locator}
    WAIT UNTIL PAGE CONTAINS ELEMENT    ${locator}
    SCROLL ELEMENT INTO VIEW            ${locator}
    CLICK ELEMENT                       ${locator}

Scroll To Bottom
    Execute JavaScript                  window.scrollTo(0, document.body.scrollHeight)

Move To Next Page
    Scroll To Bottom
    WAIT UNTIL PAGE CONTAINS ELEMENT    ${next}
    SCROLL ELEMENT INTO VIEW            ${next}
    CleanClick                          ${next}

Search For
    [Arguments]  ${jobname}

    CleanClick                  ${search}
    INPUT TEXT                  ${search}               ${jobname}
    PRESS KEYS                  ${None}                 ${button}
    CleanClick                  ${peopler}
    SCROLL ELEMENT INTO VIEW    ${results}
    CleanClick                  ${results}

ClickOnClose
    ${thirdstatus}=         RUN KEYWORD AND RETURN STATUS  WAIT UNTIL PAGE CONTAINS  ${textsorry}
    IF                      ${thirdstatus}
        CleanClick          ${close}
        ${connectnext}=     RUN KEYWORD AND RETURN STATUS  PAGE SHOULD NOT CONTAIN ELEMENT  ${connectsecond}
        RUN KEYWORD IF      ${connectnext}  Move To Next Page
    END


*** Test Cases ***
LinkedIn Adding
    OPEN BROWSER                ${url2}                 ${browser2}
    MAXIMIZE BROWSER WINDOW
    INPUT TEXT                  ${usernameField}        ${email}
    INPUT PASSWORD              ${passwordField}        ${password}
    CleanClick                  ${submit}

    Search For                  ${QA}

    FOR     ${i}    IN RANGE    1       71

        SLEEP               3s

        ${connectstatus}=   RUN KEYWORD AND RETURN STATUS  WAIT UNTIL PAGE DOES NOT CONTAIN ELEMENT  ${connect}
        RUN KEYWORD IF      ${connectstatus}    Move To Next Page

        ${countofelement}=  GET ELEMENT COUNT   ${connect}
        ${iteration}=       EVALUATE  ${countofelement}+1

        FOR     ${j}    IN RANGE   1     ${iteration}

            CleanClick      ${connectFirst}
            ${status}=      RUN KEYWORD AND RETURN STATUS  PAGE SHOULD NOT CONTAIN  ${text}

            IF      ${status}

                PRESS KEYS      ${none}     ESCAPE
                ${secondstatus}=    RUN KEYWORD AND RETURN STATUS  PAGE SHOULD CONTAIN ELEMENT  ${connectSecond}

                    IF  ${secondstatus}

                        cleanclick  ${connectsecond}
                        CleanClick  ${send}
                        ClickOnClose

                    ELSE

                        Move To Next Page

                    END

            ELSE

                CleanClick  ${send}
                ClickOnClose

            END
        END
    END
