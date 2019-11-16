


function love.load()
    love.physics.setMeter(64)
    mundo = love.physics.newWorld(0,9.81*64,true)

    objetos = {}

    objetos.chao = {}
    objetos.chao.body = love.physics.newBody(mundo, 650/2,650-50/2)
    objetos.chao.shape = love.physics.newRectangleShape(650,50)
    objetos.chao.fixture = love.physics.newFixture(objetos.chao.body, objetos.chao.shape)

    objetos.ball = {}
    objetos.ball.body = love.physics.newBody(mundo, 650/2,650/2, "dynamic")
    objetos.ball.shape = love.physics.newCircleShape(20)
    objetos.ball.fixture = love.physics.newFixture(objetos.ball.body, objetos.ball.shape, 1)
    objetos.ball.fixture:setRestitution(0.9)

    objetos.blocoUm = {}
    objetos.blocoUm.body = love.physics.newBody(mundo, 200, 550, "dynamic")
    objetos.blocoUm.shape = love.physics.newRectangleShape(0,0,50,100)
    objetos.blocoUm.fixture = love.physics.newFixture(objetos.blocoUm.body, objetos.blocoUm.shape, 5)

    objetos.blocoDois = {}
    objetos.blocoDois.body = love.physics.newBody(mundo, 200, 400, "dynamic")
    objetos.blocoDois.shape = love.physics.newRectangleShape(0,0,100,50)
    objetos.blocoDois.fixture = love.physics.newFixture(objetos.blocoDois.body, objetos.blocoDois.shape, 2)

    love.graphics.setBackgroundColor(104,136,248)
    love.window.setMode(650,650)

end

function love.update( dt )
    mundo:update(dt)

    if love.keyboard.isDown('right') then
        objetos.ball.body:applyForce(400, 0)
    elseif love.keyboard.isDown('left') then
        objetos.ball.body:applyForce(-400, 0)
    elseif love.keyboard.isDown('up') then
        objetos.ball.body:applyForce(0, -400)
        --objetos.ball.body:setPosition(650/2,650/2)
        --objetos.ball.body:setLinearVelocity(0,0)
    end
end

function love.draw(  )
    love.graphics.setColor(72/255,160/255,14/255)
    love.graphics.polygon("fill", objetos.chao.body:getWorldPoints(objetos.chao.shape:getPoints()))

    love.graphics.setColor(193/255,47/255,14/255)
    love.graphics.circle("fill", objetos.ball.body:getX(), objetos.ball.body:getY(), objetos.ball.shape:getRadius())

    love.graphics.setColor(50/255,50/255,50/255)
    love.graphics.polygon("fill", objetos.blocoUm.body:getWorldPoints(objetos.blocoUm.shape:getPoints()))
    love.graphics.polygon("fill", objetos.blocoDois.body:getWorldPoints(objetos.blocoDois.shape:getPoints()))

end