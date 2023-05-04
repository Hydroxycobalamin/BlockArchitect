BA_item_is_valid:
    type: procedure
    debug: false
    definitions: item
    script:
    - if !<[item].as[item].exists>:
        - debug error "<&[error]>'<[item].if_null[null].custom_color[emphasis]>' is not a valid item. Is it a valid script item?"
        - determine false
    - if !<[item].has_flag[custom_block]>:
        - debug error "<&[error]>'<[item].custom_color[emphasis]> does not have required flag '<&[emphasis]>custom_block<&[error]>'."
        - determine false
    - determine true
BA_location_is_valid:
    type: procedure
    debug: false
    definitions: location|custom
    script:
    - if !<[location].as[location].exists>:
        - debug error "<&[error]>'<[location].custom_color[emphasis]>' is not a valid location."
        - determine false
    - if <[custom].exists>:
        - if !<[location].has_flag[custom_block]>:
            - debug error "<&[error]>'<[location].custom_color[emphasis]>' is not a valid custom block."
            - determine false
    - determine true