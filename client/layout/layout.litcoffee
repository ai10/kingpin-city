## general layout / body code

    window.mouseIsDown = false
    city = @city
    blockTypes = @blockTypes
    blockImages = @blockImages = {}
    blockImagesLoaded = []
    Template.layout.created = ->
       blockTypes.forEach (block)->
           blockImage = new Image()
           blockImage.onload = =>
               blockImagesLoaded.push block.code
               Session.set 'blockTypesLoaded', blockImagesLoaded.length

           blockImage.src = '/blocks/' + block.rotation + '/'+block.pic
           key = block.code + block.rotation
           blockImages[key] = blockImage

    Template.layout.helpers
       
       blockTypes: ->
           blockTypes

    Template.body.events

       'mouseleave': ->
           window.mouseIsDown = false

       'mousedown': (e,t)->
           console.log 'body', e.target
           if (e.which == 1) then window.mouseIsDown = true

       'mouseup': (e, t)->
           console.log 'body', e.target
           if (e.which == 1) then window.mouseIsDown = false
