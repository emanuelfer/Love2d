local anim = require 'anim8'

local imagem, animation

local posx = 100
local direcao = true

function love.load()
    imagem = love.load.graphics.newImage("../trump.png")
    local g = anim.newGrid (100,100, imagem:getWidth(), imagem:getHeight())
    animation = anim.newAnimation(g('1-6',1,'1-6',2,'1-6',3,'1-6',4), 0.01)
end

function love.update(dt)
    if love.keyboard.isDown('left') then
        posX = posX - 150*dt
        direcao = false
        animation:update(dt)
    end
    if love.keyboard.isDown('right') then
        posX = posX + 150*dt
        direcao = true
        animation:update(dt)
    end
end

function love.draw()
    love.graphics.setBackgroundColor(255,255,255)

    if direcao then
        animation:draw(imagem, posX, 50, 0 , 1 , 1 , 90 ,0)
    elseif not direcao then
        animation:draw(imagem, posX, 50, 0 , -1 , 1 , 90 ,0)
    end
end
