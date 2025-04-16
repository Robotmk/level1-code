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

Open Two Pages with different Geolocations
    New Browser  chromium  headless=False
    # Merching
    New Context  geolocation={"longitude": 10.986376, "latitude": 48.244901 }  permissions=["geolocation"]
    New Page    url=https://browserleaks.com/geo
    # Atlanta
    New Context  geolocation={"longitude": -84.365348, "latitude": 33.772321 }  permissions=["geolocation"]
    New Page    url=https://browserleaks.com/geo
    No Operation

    