*** Settings ***
# Import the Browser Library
Library  Browser

*** Test Cases ***

Open RobotFramework Page
    # Create a new Firefox instance with visible UI
    New Browser  browser=firefox  headless=False
    # Create a new Context with dimensions and a fixed locale
    New Context  viewport={"width": 800, "height": 600}  locale=en-US
    # Open the RF page
    New Page    url=https://robotframework.org

