*** Settings ***
Library    RequestsLibrary
Documentation    This is a test suite for the RequestsLibrary.

*** Test Cases ***
Example with RequestsLibrary
    # Example with github.com API
    Create Session    github    https://api.github.com
    ${resp}    GET On Session    github    /users/octocat
    Should Be Equal As Strings    ${resp.status_code}    200
    VAR  ${json}   ${resp.json()}
    Should Be Equal As Strings    ${json["login"]}    octocat
    Should Be Equal As Strings    ${json["type"]}    User
    Should Be Equal As Strings    ${json["name"]}    The Octocat
    Should Be Equal As Strings    ${json["blog"]}    https://github.blog
    Should Be Equal As Strings    ${json["location"]}    San Francisco
