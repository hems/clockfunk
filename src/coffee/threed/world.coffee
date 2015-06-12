happens = require 'happens'

world = {}

world.canvas = $( '#canvas' )

happens @

world.camera = new THREE.PerspectiveCamera( 55, window.innerWidth / window.innerHeight, 0.1, 10000 )

world.camera.position.y = 10
world.camera.position.z = 15
world.camera.lookAt( new THREE.Vector3( 0, 10, 0 );)

# world.scene
world.scene = new THREE.Scene
# world.scene.fog = new THREE.FogExp2( 0x000000, 0.001 );

# Renderer
world.renderer = new THREE.WebGLRenderer antialias: on
world.renderer.setSize window.innerWidth, window.innerHeight
# world.renderer.setDepthTest off

world.canvas.append( world.renderer.domElement )


# ~ controls
world.controls = new THREE.TrackballControls( world.camera, world.renderer.domElement )
world.controls.rotateSpeed          = 1.0
world.controls.zoomSpeed            = 1.2
world.controls.panSpeed             = 0.8
world.controls.noZoom               = false
# world.controls.noPan                = true
# world.controls.staticMoving         = true
world.controls.dynamicDampingFactor = 0.5

# Helpers
# world.scene.add new THREE.GridHelper( 50, 10 )
# world.scene.add new THREE.AxisHelper( 10 )

world.light = new THREE.AmbientLight( 0x404040 )
world.scene.add world.light

directionalLight = new THREE.DirectionalLight( 0xffffff, 0.5 )
directionalLight.position.set( 0, 10, 0 )

world.scene.add( directionalLight )

# light = new THREE.PointLight( 0xcFF0000, 2, 100 );
# light.position.set( 0, 0, 0 );
# world.scene.add( light );

world.update = ( time ) =>

    requestAnimationFrame world.update 


    world.controls.update()

    @emit 'frame', time

    left   = window.innerWidth
    bottom = window.innerHeight
    width  = window.innerWidth
    height = window.innerHeight

    # on resize
    world.renderer.setSize window.innerWidth, window.innerHeight
    world.camera.aspect = width / height
    world.camera.updateProjectionMatrix()

    # renderer business
    # world.renderer.setViewport left, bottom, width, height
    # world.renderer.setScissor  left, bottom, width, height
    # world.renderer.enableScissorTest true
    # world.renderer.setClearColor     0xccff00

    # console.log "hapennings"

    world.renderer.render world.scene, world.camera

world.add = ( object ) -> world.scene.add object

world.bounds = -> bounds


geometry = new THREE.BoxGeometry( 100, 100, 100 );
material = new THREE.MeshBasicMaterial( {color: 0xFFFFFF} );
cube = new THREE.Mesh( geometry, material );

# cube.position.x = 200

world.scene.add cube

world.update()

module.exports = world