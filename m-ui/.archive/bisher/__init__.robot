*** Settings ***
Resource  resources/Variables.resource
Resource  resources/Puter.resource
Suite Setup  Open Puter
Suite Teardown  Close Puter
