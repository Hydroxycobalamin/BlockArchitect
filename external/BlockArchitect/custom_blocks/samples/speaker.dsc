custom_speaker:
    type: item
    debug: false
    material: redstone_lamp
    mechanisms:
        custom_model_data: 3
    flags:
        custom_block: true

custom_speaker_activate:
    type: world
    debug: false
    events:
        after custom event id:blockarchitect_block_switched data:blockarchitect_id:custom_speaker:
        # Temporary fix, manual power state tracking. Waiting for denizen powered tag.
        - if !<context.switched> && <context.location.has_flag[custom_block.data.powered]>:
            - flag <context.location> custom_block.data.powered:!
        - if <context.switched> && !<context.location.has_flag[custom_block.data.powered]>:
            - playsound <context.location> sound:entity_cat_ambient
            - playeffect at:<context.location.center.above[0.55]> effect:vibration special_data:1s|<context.location.center.above[0.55]>|<context.location.center.above[1.5]> offset:0.01 quantity:50
            - flag <context.location> custom_block.data.powered
        - switch <context.location> state:off no_physics