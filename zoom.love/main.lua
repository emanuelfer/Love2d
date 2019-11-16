require 'camera'
heroi = love.graphics.newImage("heroi.png")
inimigo = love.graphics.newImage("inimigo.png")
fundo = love.graphics.newImage("fundo.png")

x,y,x2,y2 = 200,300,600,300
tamanho = 1

function love.update(dt)
    if love.keyboard.isDown('left') then
        x = x - 100*dt
    end
    if love.keyboard.isDown('right') then
        x = x + 100*dt
    end
    if math.dist(x,y,x2,y2) < 200 then
        tamanho = tamanho + 0.5*dt
        if tamanho >= 1.5 then
            tamanho = 1.5
        end
    else
        tamanho = tamanho -0.5*dt
        if tamanho <= 1 then
            tamanho = 1
        end
    end
end

function love.draw()
    camera:set()

    love.graphics.scale(tamanho)
    love.graphics.translate(-(x-100),-(y-350))
    love.graphics.draw(fundo,0,0,0,1.35,1.62)
    love.graphics.draw(heroi, x, y, 0, 0.3, 0.3, 38.5, 38.5)
    love.graphics.draw(inimigo, x2, y2, 0, 0.3, 0.3, 38.5, 38.5)

    camera:unset()
end

function math.dist(x1,y1,x2,y2)
    return ((x2-x1)^2 + (y2-y1)^2)^0.5
  end