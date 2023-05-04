BA_item_is_valid:
    type: procedure
    debug: false
    definitions: item
    script:
    - if !<[item].as[item].exists>:
        - debug error "<&[error]>'<[item].if_null[null].custom_color[emphasis]>' is not a valid item. Is it a valid script item?"
        - determine false
    - if <[item].has_flag[custom_block]>:
        - debug error "<&[error]>'<[item]> does not have required flag '<&[emphasis]>custom_block<&[error]>'."
        - determine false
    - determine true