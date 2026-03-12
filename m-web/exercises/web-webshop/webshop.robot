*** Settings ***
Documentation     Synthetic monitoring demo – Checkout flow (no payment)

Resource          Resources/lib-browser.resource
Resource          Resources/authentication.resource
Resource          Resources/catalog.resource
Resource          Resources/cart.resource
Resource          Resources/checkout.resource

Suite Setup       Open Webshop

*** Variables ***
# https://github.com/testsmith-io/practice-software-testing
${BASE_URL}       https://practicesoftwaretesting.com
${USER_EMAIL}     customer3@practicesoftwaretesting.com
${USER_PASSWORD}  pass123
${USER_NAME}      Bob Smith
${ITEMS_IN_CART}    0
@{ITEMS_TO_ADD}   Ear Protection    Safety Goggles

*** Test Cases ***
User Can Reach Checkout Page
    [Documentation]    Test if a logged-in user can add items to the cart.
    ...    Verify the cart items and perform the checkout.
    No Operation
    # => Call "Login As User" from authentication.resource
    #    Args: USER_EMAIL, USER_PASSWORD, USER_NAME
    
    # => Call "Add Items To Cart" from catalog.resorce
    #    Args: ITEMS_TO_ADD
    
    # => Call "Open Cart" from cart.resource
    
    # => Call "" Checkout from checkout.resouce
    
    
*** Keywords ***
Open Webshop
    New Browser    chromium    headless=%{ROBOTMK_HEADLESS_HOST=false}
    New Context  locale=en-US  viewport={ 'width': 1280, 'height': 1024 }
    New Page       ${BASE_URL}
