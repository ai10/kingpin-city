## canvas grid system
    city = @city
    Blocks = @Blocks
    
    class Grid
      constructor: (@name)->
        @NE = []
        @SE = []
        @NW = []
        @SW = []
      
      quad: (x , y) ->
          a = Math.abs x
          b = Math.abs y
          if ((x >= 0) and (y >= 0)) then return ['NE', a, b]
          if ((x >= 0) and (y < 0)) then return ['SE', a, b]
          if ((x < 0) and (y >= 0)) then return ['NW', a, b]
          if ((x < 0) and (y < 0)) then return ['SW', a, b]

      set: (x, y, val)->
        [quad, x, y] = @quad x, y
        if not @[quad][x]? then @[quad][x] = []
        @[quad][x][y] = val
    
      get: (x, y)->
        [quad, x, y] = @quad x, y
        if not @[quad][x]? then return 'preload'
        if not @[quad][x][y]? then return 'preload'
        @[quad][x][y]
    
    
    
    city.cityGrid = new Grid()
    blockImages = @blockImages
    blockTypes = @blockTypes
    rows = 4
    columns = 4
           
    Ť = Template.canvasGrid
    ť = Template.instance

    Ť.created = ->
        console.log 'created'
        instance = this
        instance.shift = (move)->
            canvas = ť().displayCanvas.get() + 'Shift'
            ť()[canvas].set move

        instance._height = $(window).height()
        instance._width = $(window).width()
        instance.blockSize = new ReactiveVar 44
        instance.origin = new ReactiveVar [0,0]
        instance.alphaShift = new ReactiveVar [0,0]
        instance.getBlockCount = ->
            blockSize = ť().blockSize.get()
            yblocks = Math.floor(ť()._height / blockSize)
            xblocks = Math.floor(ť()._width / blockSize)
            console.log 'blockCount', xblocks, yblocks
            [yblocks, xblocks]
        instance.blockCount = instance.getBlockCount()
        instance.displayCanvas = new ReactiveVar 'alpha'
        instance.drawPhotos = ->
            console.log 'drawPhotos'
            blockSize = ť().blockSize.get()
            [rows, columns] = ť().blockCount
            c = document.getElementById 'photoCanvas'
            ctx = c.getContext "2d"
            ctx.clearRect 0, 0, c.width, c.height
            [originX, originY] = ť().origin.get()
            [(originY-rows)..(originY+rows)].forEach (row)->
                [(originX-columns)..(originX+columns)].forEach (column)->
                    imageId = city.cityGrid.get row, column
                    if imageId is 'preload' then imageId = 'preload90'
                    img = blockImages[imageId]
                    offsetY = blockSize*(row-originY)
                    offsetX = blockSize*(column-originX)
                    ctx.drawImage img, offsetX, offsetY, blockSize, blockSize
            true

        instance.loaded = new ReactiveVar 0
        instance.limit = new ReactiveVar 5
        instance.ready = new ReactiveVar false
        subscription = Meteor.subscribe 'blocks'
        subscriptionWait = instance.autorun ->
            #limit = instance.limit.get()
            if (subscription.ready())
                #instance.loaded.set limit
                instance.ready.set true
                blocks = Blocks.find().fetch()
                blocks.forEach (b)->
                    key = b.code + b.rotation
                    city.cityGrid.set b.street, b.avenue, key
                console.log 'autorun'
                ť().drawPhotos()
                subscriptionWait.stop()

            else
                instance.ready.set false

    Ť.rendered = ->
        instance = this

    Ť.helpers
      originX: ->
          ť().origin.get()[0]

      originY: ->
          ť().origin.get()[1]

      alphaLeft: ->
          ť().alphaShift.get()[0] - 100

      alphaTop: ->
          ť().alphaShift.get()[1] - 100

      width: ->
          ť()._width
      
      height: ->
          ť()._height

      displayCanvas: ->
          ť().displayCanvas.get()
    
    i = 0
    mdownX = 0
    mdownY = 0
    deltaX = 0
    deltaY = 0
    
    withinT = (v)->
        if v > 0
            Math.floor(v)
        else
            Math.ceil(v)

    measureDragPix = (e)->
        [e.clientX - mdownX, e.clientY - mdownY]
    
    measureDragSquares = (dragPix, blockSize)->
        [deltaX, deltaY] = dragPix
        blockSize = blockSize or 144
        round = [(Math.round deltaX/(blockSize)), (Math.round deltaY/(blockSize))]
        remainder = [ deltaX-round[0]*blockSize, deltaY-round[1]*blockSize ]
        round.concat remainder

    Ť.events
      
      'mouseup canvas': (e,t)->
          window.mouseIsDown = false
          e.stopPropagation()
          [pixX, pixY] = measureDragPix e
          blockSize = ť().blockSize.get()
          [dintX, dintY, rX, rY] = measureDragSquares [pixX, pixY], blockSize
          if (Math.abs(dintX) > 0) or (Math.abs(dintY) > 0)
              [ox, oy] = ť().origin.get()
              ox -= dintX
              oy -= dintY
              ť().origin.set [ox, oy]
              ť().shift [rX, rY]
              ť().drawPhotos()
          true
      
      'dragend, mouseleave canvas': (e, t)->

      'mousedown canvas': (e, t)->
          window.mouseIsDown = true
          e.stopPropagation()
          mdownX = e.clientX
          mdownY = e.clientY
           
      'mousemove canvas': (e, t) ->
          if not window.mouseIsDown then return
          ť().shift measureDragPix(e)
          true
