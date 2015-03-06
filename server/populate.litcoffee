## Populate.licoffee
city block initiation script


    Meteor.startup ->
        blockExists = Blocks.findOne()
        if not blockExists
            [-20..20].forEach (street)->
                [-20..20].forEach (avenue) ->
                    b = @getRandomBlock street, avenue
                    Blocks.insert b
