*** Settings ***
Documentation This suite demonstrates how to use indentation and separation in syntax
# Use what you have learned about indentation and separation to repair this suite.
*** Test Cases ***
Example Test Case
[Documentation] This is an example  test case demonstrating indentation and separation
MyLogKeyword Lorem Ipsum
*** Keywords ***
MyLogKeyword
[Arguments] ${message}
Log ${message}