function love.conf( t )
    --local onde o jogo é salvo
    tidentity = nil
    t.version = "11.1"
    t.console = true
    t.accelerometerjoystick = true
    t.externalstorage = false
    t.gamacorrect = false

    t.window.title = "Navel"
    t.window.icon = nil
    t.window.width = 480
    t.window.height = 700
    t.window.borderless = false
    t.window.resizable = true
    t.window.minwidth = 1
    t.window.minheight = 1
    t.window.fullscreen = false
    t.window.fullscreentype = "desktop"
    t.window.vsync = truue
    t.window.msaa = 0
    t.window.display = 1
    t.window.highdpi = false
    t.window.x = nil
    t.window.y = nil

    t.modules.audio = true
    t.modules.event = true
    t.modules.graphics = true
    t.modules.iamge = true
    t.modules.joystick = true
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.physics = true
    t.modules.sound = true
    t.modules.system = true
    t.modules.timer = true
    t.modules.touch = true
    t.modules.video = true
    t.modules.window = true
    t.modules.thread = true
end