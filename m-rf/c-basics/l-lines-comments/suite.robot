*** Settings ***
Documentation      Here we have documentation for this suite. Documentation is often quite long. It can also contain multiple paragraphs.
*** Variables ***
# This is a very long string; break it into multiple lines.
${STRING}          This is a long string. It has multiple sentences and it gets quit long. Someone has to break it into multiple lines.
# This is a very long URL; break it into multiple lines.
${URL}             https://subdomain.example-company.com/search?query=robot+framework&page=1&access=true&filter=recent&lang=en&id=qcSLqJu4&category=test-automation

*** Test Cases ***
# The instructions are in the keyword arguments.
Test 1
    # Note: The keyword "Log Many" accepts a list of strings (separated by separators) and prints them all in one line.
    Log Many  This is log message 1.  This is log message 2.  This is log message 3.  This is log message 4.  This is log message 5. 
    Log    Log message should start with a leading hash.
    Log    Log message should have a leading and a trailing space. 
    Log    Log 1 leading and 5 trailing spaces.
    Log    Log the name of the variable: ${STRING}
    Log    Log exactly this path: C:\ProgramData\RobotFramework\Logs\2023-10-01\log.html
    Log    Write a comment behind this line.
    Log    ${URL}



