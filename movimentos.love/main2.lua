posX = 250
posY = 250
angulo = 0
tam = 1
origem = 128

function love.load()
    pneu = love.graphics.newImage("pneu.png")
    cursor = love.graphics.newImage("cursor.png")
    love.mouse.setVisible(false)
end

function love.update(dt)
    if love.keyboard.isDown("left") then
        posX = posX - 100*dt
        angulo = angulo - dt*1.5
    end
    if love.keyboard.isDown("right") then
        posX = posX + 100*dt
        angulo = angulo + dt*1.5
    end
end

function love.draw()
    rotate = angulo
    love.graphics.setBackgroundColor(255,255,255)
    love.graphics.draw(pneu, posX,posY,rotate,tam, tam, origem, origem)
    love.graphics.draw(cursor, love.mouse.getX(), love.mouse.getY())
end