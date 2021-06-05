*** Settings ***
Library  SeleniumLibrary
Test Setup  Start TestCase
Test Teardown  Finish TestCase
*** Variables ***
${page_url}  https://www.google.com
${search_text}  Georgian Food
${search_input}  gLFyf
${search_button}  gNO89b
${result_links}  LC20lb

*** Test Cases ***
Testing Search
    Verify Search Results
*** Keywords ***

Start TestCase
    Open Browser  ${page_url}  chrome
    Maximize Browser Window

Verify Search Results
    Input Text  class:${search_input}   ${search_text}
    Execute JavaScript    document.getElementsByClassName("${search_button}")[0].click()
    @{result_links}=  Get WebElements    class:${result_links}
    FOR  ${item}  IN  @{result_links}
        ${contains_text} =   Run Keyword And Return Status   Should Contain  ${item.text}  ${search_text}  ignore_case=True
        IF  ${contains_text}
            Log To Console  Link contains searched Results
        ELSE
            Log To Console  Link Does not contains searched Results
        END
    END
    Click Element  ${result_links}[0]
    ${text_exists} =  Run Keyword And Return Status  Page Should Contain  ${search_text}
    IF  ${text_exists}
        Capture Page Screenshot     search_text_on_page.png
    END

Finish TestCase
    Close Browser