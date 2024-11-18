*** Variables ***
${URL}           https://example.com/search?query=robot+framework&page=1&filter=recent&lang=en&category=test-automation 
*** Test Cases ***
Log The URL
    Log    ${URL}
