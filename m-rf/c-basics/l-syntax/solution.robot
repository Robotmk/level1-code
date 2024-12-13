*** Settings ***
Documentation      Here we have documentation for this suite. 
...    Documentation is often quite long. 
...    It can also contain multiple paragraphs.
*** Variables ***
${STRING}          This is a long string. It has multiple sentences 
...    and it gets quit long. Someone has to break it into multiple lines.
*** Test Cases ***
# These two test cases are for demonstration purposes only and are 
# intended to give you the opportunity to practice how overlong 
# lines can be converted into multiple lines.

Test 1
    Log Many  
    ...    This is log message 1.  
    ...    This is log message 2.  
    ...    This is log message 3.  
    ...    This is log message 4.  
    ...    This is log message 5. 

Test 2
    Log    \#Log a leading hash.
    Log    \ Log a leading and trailing space.\ 
    Log    ${SPACE}Log 1 leading and 5 trailing spaces.${SPACE * 5}
    Log    Log the name of the variable: \${STRING}
    Log    Log this path: C:\\better\\use\\forward\\slashes
    Log    Write a comment behind this line.    # This is a comment.
    Log    Write a multiline comment behind this line.   # This comment is 
    # continued on the next line.