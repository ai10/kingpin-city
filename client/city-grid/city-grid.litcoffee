## city-grid.litcoffee

Code for populating city grid.
    
    Blocks = @Blocks
    blocksSubscription = @blocksSubscription
    
    mouseIsDown = @mouseIsDown
    
    getNumber = (n, def) ->
        n = parseInt n
        switch n
            when 0 then def
            when 1 then '1st'
            when 2 then '2nd'
            when 3 then '3rd'
            else n + 'th'
     
    makeName =  (coords) ->
        [street, avenue] = coords
        streetName = 'Main'
        avenueName = 'Market'
        ew = ''
        ns = ''
        if street > 0 then ew = 'E'
        if street < 0 then ew = 'W'
        if avenue > 0 then ns = 'N'
        if avenue < 0 then ns = 'S'
        
        ave =  ns + getNumber avenue,  avenueName
        str =  ew + getNumber street,  streetName
        [str, ave]

    imageGrid = []

    Template.cityGrid.created = ->

    Template.cityGrid.rendered = ->
      Session.set 'gridSizeInt', 50
      Session.set 'gridSize', 'fifty'
      Session.set 'originX', 0
      Session.set 'originY', 0
      Session.set 'shiftX', 0
      Session.set 'shiftY', 0

    Template.cityGrid.helpers

      shiftX: ->
          Session.get 'shiftX'
      
      shiftY: ->
          Session.get 'shiftY'
      
      originX: ->
          Session.get 'originX'
      
      originY: ->
          Session.get 'originY'

      streets: (avenue)->
          [-5..5].map (s)->
              { street: s, avenue: avenue }

      avenues: ->
          [-5..5].map (a)->
              { avenue: a }
          

      gridSize: ->
          Session.get 'gridSize'

      gridImage: (street, avenue)->
          Session.get 'originX'
          imageGrid[street][avenue] or 'blocks/h4.png'

    i = 0
    mdownX = 0
    mdownY = 0
    deltaX = 0
    deltaY = 0
    
    withinT = (v)->
        if v > 0
            Math.floor v
        else
            Math.ceil v

    reorient = (x, y) ->
        console.log 'reorient', x, y
        Session.set 'originX', Session.get('originX') + x
        Session.set 'originY', Session.get('originY') + y

    measureDragPix = (e)->
        [e.clientX - mdownX, e.clientY - mdownY]

    measureDragSquares = (dragPix)->
        [deltaX, deltaY] = dragPix
        f = 0.8
        gridSize = Session.get 'gridSizeInt'
        [(withinT deltaX/(f*gridSize)), (withinT deltaY/(f*gridSize))]
      
    shiftImage = (coords)->
        console.log 'shift'
        [dx, dy] = coords
        Session.set 'shiftX', dx
        Session.set 'shiftY', dy
        true

    Template.canvasGrid.events
      
      'mouseup table': (e,t)->
          window.mouseIsDown = false
          [dintX, dintY] = measureDragSquares measureDragPix(e)
          if (Math.abs(dintX) > 0) or (Math.abs(dintY) > 0)
              reorient dintX, dintY
          Session.set 'tableShiftX', 0
          Session.set 'tableShiftY', 0
          true

      'mousedown table': (e, t)->
          window.mouseIsDown = true
          mdownX = e.clientX
          mdownY = e.clientY
           
      'mousemove table': (e, t) ->
          if not window.mouseIsDown then return
          k = measureDragPix e
          shiftImage k
          true

      
