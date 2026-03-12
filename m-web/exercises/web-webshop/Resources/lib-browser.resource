*** Settings ***
Library     Browser
...             run_on_failure=Take Screenshot \ filename=EMBED \ fileType=jpeg \ quality=50
...             enable_playwright_debug=disabled
...             auto_delete_passed_tracing=True