angulo = 0
rotacao = 0
rotacaoDois = 0
surgeUm = false
surgeDois = false


function love.load()
    roda = love.graphics.newImage("Roda.png")
    barra = love.graphics.newImage("Barra.png")
    arco = love.graphics.newImage("Arco.png")
end

function love.update(dt)

    angulo = angulo + dt
    x, y = 400 + math.cos( angulo )*100, 300 + math.sin( angulo )*100
    rotacaoDois = rotacaoDois + 1*dt

    if love.keyboard.isDown('left') then
        rotacao = rotacao + 1*dt
        surgeUm = true
    end

    if love.keyboard.isDown('right') then
        rotacao = rotacao - 1 * dt
        surgeDois = true
    end
end

function love.draw()
    if surgeUm then
        love.graphics.draw(barra, 400,300, rotacaoDois,1,1,0,18)
    end

    if surgeDois then
        love.graphics.draw(arco, 400, 300, 0,1,1,151,151)
    end

    love.graphics.draw(roda, x, y, rotacao, 1, 1, 50, 50)

end

function love.keyreleased(key)
    if key == 'left' or key == 'right' then
        surgeUm = false
        surgeDois = false
    end
end