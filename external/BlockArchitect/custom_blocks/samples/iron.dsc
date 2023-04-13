# This is a sample file to create a custom block using BlockArchitect. A Denizen script that allows users to create custom blocks with specific properties and behaviors
# The code sample provides a template for defining a custom block named 'custom_iron'.
custom_iron:
    type: item
    debug: false
    data:
        custom_block:
            # This property defines what the block will drop. Can use a procedure script for more complex logic.
            # If drops is not set, the block will drop itself. Set to 'nothing' if the block shouldn't drop.
            drops: iron_ore
            # This property is used to define the conditions for whether or not the block will drop items when broken.
            # The player has to break the block with one of the following items that match the advanced matcher, to make the block drop items.
            # One of them has to return true.
            # If item is not set, the block will always drop.
            item:
            - stone_pickaxe
            - iron_pickaxe
            - gold_pickaxe
            - diamond_pickaxe
    # The material property, sets the blocks material. If the item does not have custom_model_data applied, it will show
    # the material instead. The block will have the behavior of the material specified.
    material: stone
    mechanisms:
        custom_model_data: 1
    ## Every block must have this flag.
    flags:
        custom_block: true