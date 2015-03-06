## block types
    
    @city = {}
    @getRandomBlock = (street, avenue) ->
        range = @blockTypes.length
        x = Math.floor (range-1)*Math.random()
        bt = @blockTypes[x]
        rotations = ['360', '270', '180', '90']
        z = Math.floor 4*Math.random()

        _.each bt.types, (t)->
            if not _.contains @unitTypes, t
                throw new Meteor.Error 'invalid block type'
        
        bt.street = street
        bt.avenue = avenue
        bt.rotation = rotations[z]
        bt


    @unitTypes = [
        'preload',
        'hospital',
        'apartment',
        'lot',
        'park',
        'retail',
        'police',
        'office',
        'warehouse',
        'museum',
        'library',
        'restaurant',
        'federal',
        'factory',
        'dealership',
        'hotel'
    ]
    
    blockTypesPre = [
                {
                    code: 'preload'
                    types: ['preload']
                    pic: 'preload.png'
                },
                {
                    code: 'a4'
                    types: ['apartment', 'apartment', 'apartment', 'apartment']
                    pic: 'a4.png'
                },
                {
                    code: 'a2r1l1'
                    types: ['apartment', 'apartment', 'retail','lot']
                    pic: 'a2r1l1.png'
                },
                {
                    code: 'a1r1n1l1'
                    types: ['apartment', 'retail', 'restaurant', 'lot']
                    pic: 'a1r1n1l1.png'
                },
                {
                    code: 'a1n1l1p1'
                    types: ['apartment', 'restaurant', 'lot', 'park']
                    pic: 'a1n1l2p1.png'
                },
                {
                    code: 'a1r1n2'
                    types: ['apartment', 'restaurant', 'restaurant', 'retail']
                    pic: 'a1r1n2.png'
                },
                {
                    code: 'f1c1n2'
                    types: ['federal', 'police', 'restaurant', 'restaurant']
                    pic: 'f1c1n2.png'
                },
                {
                    code: 'o2n2'
                    types: ['office', 'office', 'restaurant', 'restaurant']
                    pic: 'o2n2.png'
                },
                {
                    code: 'w1'
                    types: ['warehouse']
                    pic: 'w1.png'
                },
                {
                    code: 't1w2l1'
                    types: ['factory', 'warehouse', 'lot']
                    pic: 't1w2l1.png'
                },
                {
                    code: 'h3l1'
                    types: ['hotel', 'lot', 'apartment']
                    pic: 'h3l1.png'
                },
                {
                    code: 'c1o1n1l1'
                    types: ['police', 'office', 'restaurant', 'lot']
                    pic: 'c1o1n1l1.png'
                },
                {
                    code: 'r2n1c1'
                    types: ['retail', 'retail', 'restaurant', 'police']
                    pic: 'r2n1c1.png'
                },
                {
                    code: 'a1'
                    types: ['apartment']
                    pic: 'a1.png'
                },
                {
                    code: 'o3l1'
                    types: ['office', 'office', 'office', 'lot']
                    pic: 'o3l1.png'
                },
                {
                    code: 'n2r1m1'
                    types: ['restaurant', 'restaurant', 'retail', 'museum']
                    pic: 'n2r1m1.png'
                },
                {
                    code: 'h3l1'
                    types: ['hotel', 'hotel', 'hotel', 'lot']
                    pic: 'h3l1.png'
                },
                {
                    code: 'w3o1'
                    types: ['warehouse', 'warehouse', 'warehouse', 'office']
                    pic: 'w3o1.png'
                },
                {
                    code: 't2o1w1'
                    types: ['factory', 'factory', 'office', 'warehouse']
                    pic: 't2o1w1.png'
                },
                {
                    code: 'o2l2'
                    types: ['office', 'office', 'lot', 'lot']
                    pic: 'o2l2.png'
                },
                {
                    code: 'p1'
                    types: ['park']
                    pic: 'p1.png'
                },
                {
                    code: 'p2'
                    types: ['park']
                    pic: 'p2.png'
                },
                {
                    code: 'p3'
                    types: ['park']
                    pic: 'p3.png'
                },
                {
                    code: 'p4'
                    types: ['park']
                    pic: 'p4.png'
                },
                {
                    code: 'r3l1'
                    types: ['retail', 'retail', 'retail', 'lot']
                    pic: 'r3l1.png'
                },
                {
                    code:  'h3n1'
                    types: ['hotel', 'restaurant']
                    pic: 'h3n1.png'
                },
                {
                    code: 'w2l2'
                    types: ['warehouse', 'lot']
                    pic: 'w2l2.png'
                },
                {
                    code: 't1l3'
                    types: ['dealership', 'lot', 'lot', 'lot']
                    pic: 't1l3.png'
                },
                {
                    code: 'w2'
                    types: ['warehouse']
                    pic: 'w2.png'
                },
                {
                    code: 'r2l2'
                    types: ['retail', 'lot']
                    pic: 'r2l2.png'
                },
                {
                    code: 'o2w2'
                    types: ['office', 'warehouse']
                    pic: 'o2w2.png'
                },
                {
                    code: 'o1t1w2'
                    types: ['office', 'warehouse', 'warehouse', 'factory']
                    pic: 'o1t1w2.png'
                },
                {
                    code: 'w4'
                    types: ['warehouse']
                    pic: 'w4.png'
                },
                {
                    code: 'w3o1l1'
                    types: ['warehouse', 'office', 'lot']
                    pic: 'w3o1l1.png'
                },
                {
                    code: 'w3l1'
                    types: ['warehouse', 'lot']
                    pic: 'w3l1.png'
                },
                {
                    code:  'h1n1l1p1'
                    types: ['park', 'hotel', 'restaurant', 'lot']
                    pic: 'h1n1l1p1.png'
                },
                {
                    code: 'h4'
                    types: ['hotel']
                    pic: 'h4.png'
                },
                {
                    code: 'l2w2'
                    types: ['lot', 'warehouse']
                    pic: 'l2w2.png'
                },
                {
                    code: 'f4'
                    types: ['factory']
                    pic: 'f4.png'
                },
                {
                    code: 'l1h3'
                    types: ['hotel', 'hotel', 'hotel', 'lot']
                    pic: 'l1h3.png'
                },
                {
                    code: 'f2c2'
                    types: ['federal', 'federal', 'police', 'police']
                    pic: 'f2c2.png'
                },
                {
                    code: 'l2h2'
                    types: ['lot', 'hotel']
                    pic: 'l2h2.png'
                },
                {
                    code: 'o2f1l1'
                    types: ['office', 'office', 'factory', 'lot']
                    pic: 'o2f1l1.png'
                },
                {
                    code: 'l1o1w2'
                    types: ['lot', 'office', 'warehouse']
                    pic: 'l1o1w2.png'
                },
                {
                    code: 'l2r1w1'
                    types: ['lot', 'retail', 'warehouse']
                    pic: 'l2r1w1.png'
                },
                {
                    code: 's3l1'
                    types: ['hospital', 'hospital', 'hospital', 'lot']
                    pic: 's3l1.png'
                },
                {
                    code: 'n2a2'
                    types: ['restaurant', 'apartment']
                    pic: 'n2a2.png'
                },
                {
                    code: 'n1a2l1'
                    types: ['apartment', 'restaurant', 'lot']
                    pic: 'n1a2l1.png'
                },
                {
                    code: 'l4'
                    types: ['lot']
                    pic: 'l4.png'
                }
                ]
                
    
    getBlockTypes = ->
        console.log 'getBlockTypes'
        bt = []
        blockTypesPre.forEach (t) ->
            ['360', '270', '180', '90'].forEach (r)->
                t.rotation = r
                n = _.clone t
                bt.push n
        bt


    @blockTypes = getBlockTypes()

