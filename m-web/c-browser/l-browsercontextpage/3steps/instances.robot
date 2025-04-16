*** Settings ***
# Import the Browser Library
Library  Browser
# Create a new Chromium instance with visible UI
Suite Setup  New Browser  chromium  headless=False

*** Test Cases ***

Open RobotFramework Page
    # Create a new Context with dimensions and a fixed locale
    New Context  viewport={"width": 800, "height": 600}  locale=en-US
    # Open the RF page
    New Page    url=https://robotframework.org

Open Two Pages with different Geolocations
    # Merching
    New Context  geolocation={"longitude": 10.986376, "latitude": 48.244901 }  permissions=["geolocation"]
    New Page    url=https://browserleaks.com/geo
    # Atlanta
    New Context  geolocation={"longitude": -84.365348, "latitude": 33.772321 }  permissions=["geolocation"]
    New Page    url=https://browserleaks.com/geo
    No Operation

Open Two Youtube Pages in different languages
    # German
    New Context  locale=de
    New Page    url=https://youtube.com
    # Spanish
    New Context  locale=es
    New Page    url=https://youtube.com
    No Operation
    