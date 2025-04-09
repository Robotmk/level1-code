*** Settings ***
#Resource  ../../Resources/BrowserCommon.resource
# using another library import for a custom error handler:
Resource  ../../Resources/embed-screenshots/BrowserCommon.resource
Suite Setup  Browser Init
Test Setup  Session Init  ${URL}

*** Variables ***
${URL}  https://shop.polymer-project.org
${SEL_CART}  div.main-frame > div.subsection[visible]

*** Test Cases ***
Polymer Shop Orders
    [Template]  Add To Cart
    Ladies T-Shirts  Ladies Mountain View T-Shirt  S  1
    Ladies T-Shirts  Women's Android Heart T-Shirt  S  1
    Men's Outerwear  Android Nylon Packable Jacket  XL  2
    Ladies Outerwear  Ladies Pullover L/S Hood  L  2
    Ladies Outerwear  Ladies Voyage Fleece Jacket  L  1

*** Keywords ***
Add To Cart
    [Arguments]  ${tabname}  ${article_title}  ${size}  ${quantity}
    Click  shop-tab >> text="${tabname}"
    Click  text="${article_title}"
    Select options by  id=sizeSelect  value  ${size}
    Select options by  id=quantitySelect  value  ${quantity}
    Click  text=ADD TO CART
    Click  text=view cart
    Take screenshot  filename=EMBED  selector=${SEL_CART}
    Go To  ${URL}