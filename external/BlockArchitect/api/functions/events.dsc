BlockArchitect_event_handler:
    type: world
    debug: false
    events:
        ## <--[event]
        ## @Events
        ## blockarchitect_block_switched
        ##
        ## @Group Blocks
        ##
        ## @Location true
        ##
        ## @Warning This event may fire very rapidly
        ##
        ## @Switch blockarchitect_id:<id> to only process the event if the block is a specific BlockArchitect block.
        ##
        ## @Triggers when a BlockArchitect block switches.
        ##
        ## @Context
        ## <context.location> returns a LocationTag of the block the physics is affecting.
        ## <context.switched> returns whether the block was switched or not.
        ## <context.blockarchitect_id> returns the BlockArchitectID of the block that was switched.
        ##
        ## @Example
        ## # Use to fire the event only if a custom_speaker was placed.
        ## after custom event id:blockarchitect_block_switched data:blockarchitect_id:custom_speaker:
        ## - announce "A <context.blockarchitect_id> was triggered!"
        ##
        ## @Script BlockArchitect
        ##
        ## -->
        after block physics location_flagged:custom_block:
        - ratelimit <context.location>/<context.location.switched> 1t
        - if !<context.location.material.supports[switched]>:
            - stop
        - define name blockarchitect_block_switched
        - definemap context:
            location: <context.location>
            switched: <context.location.switched>
            blockarchitect_id: <context.location.flag[custom_block.entity].item.script.name>
        - inject blockarchitect_custom_event_handler
        - wait 1t
        - run BlockArchitect_reapply_light_range def.location:<context.location> def.range:10
        ## <--[event]
        ## @Events
        ## blockarchitect_block_clicked
        ##
        ## @Group Player
        ##
        ## @Location true
        ##
        ## @Cancellable true
        ##
        ## @Switch blockarchitect_id:<id> to only process the event if the block is a specific BlockArchitect block.
        ##
        ## @Triggers when a player right clicks a BlockArchitect block.
        ##
        ## @Context
        ## <context.item> returns the ItemTag the player is clicking with.
        ## <context.location> returns a LocationTag of the block the physics is affecting.
        ## <context.hand> returns an ElementTag of the used hand.
        ## <context.blockarchitect_id> returns the BlockArchitectID of the block that was clicked.
        ##
        ## @Example
        ## # Use to open a different inventory when a custom_furnace was right clicked.
        ## on custom event id:blockarchitect_block_clicked data:blockarchitect_id:custom_furnace:
        ## - inventory open destination:my_custom_inventory
        ## - determine cancelled
        ##
        ## @Script BlockArchitect
        ##
        ## -->
        on player right clicks block location_flagged:custom_block:
        - define name blockarchitect_block_clicked
        - definemap context:
            item: <context.item>
            location: <context.location>
            hand: <context.hand>
            blockarchitect_id: <context.location.flag[custom_block.entity].item.script.name>
        - inject blockarchitect_custom_event_handler
BlockArchitect_custom_event_handler:
    type: task
    debug: false
    script:
    - customevent id:<[name]> context:<[context]> save:event
    - if <entry[event].was_cancelled>:
        - determine cancelled