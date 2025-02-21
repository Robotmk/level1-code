# At first, the ImageHorizon Library needs some setup. 
# During the Library import, we give the argument `reference_folder`. Here
# we will store all the reference images the library should sesrch on the screen. 

# We also import a resource file "common\\ImageHorizon.resource" (backslash must be escaped).
# (http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#resource-and-variable-files)
# This contains some handy user keywords we will use soon. 
# Tip: "common" could be initialised as a Git submodule so that you can share commonly used
# keywords in a central git and clone them with the main repository. 
# The name of the resource file does not matter; here we name it according to the 
# library to have keywords for IHL separated from others (Selenium, SAP etc.). 


##### 
# Your tasks: 
# - create the folder for "images" within the project directory
# - import "ImageHorizon.resource"

*** Settings ***
Documentation     This suite opens the "Free Address Book" and searches for a given user. 
...  The user can be given by variable `SEARCH_NAME` (first + last name).
Library       ImageHorizonLibrary  reference_folder=${CURDIR}\\images   # ⚠️ 
Resource      common\\ImageHorizon.resource                             # ⚠️ 

*** Test Cases ***
Search User In Database 
    No Operation    # ⚠️ 