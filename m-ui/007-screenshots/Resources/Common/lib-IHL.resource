*** Settings ***
Library   ImageHorizonLibrary  
...    reference_folder=${IMAGES_ROOT}
# Disables automatic screenshot capturing by the ImageHorizonLibrary
...    keyword_on_failure=Builtin.No Operation