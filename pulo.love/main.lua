largura = love.graphics.getWidth()
altura = love.graphics.getHeight()

function love.load( ... )
    personagem = {
        posx = 100,
        posy = altura/2,
        largura = 20,
        altura = 20,
        vely = 0
    }

    gravidade = 400
    alturaDoPulo = 300
end

function love.update(dt)
    if personagem.vely ~= 0 then
        personagem.posy = personagem.posy - personagem.vely*dt
        personagem.vely = personagem.vely - gravidade*dt
        if personagem.posy > altura /2 then
            personagem.vely = 0
            personagem.posy = altura/2
        end
    end

    if love.keyboard.isDown('right') then
        personagem.posx = personagem.posx + 100*dt
    end
    if love.keyboard.isDown('left') then
        personagem.posx = personagem.posx - 100*dt
    end
end

function love.draw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("fill", personagem.posx,personagem.posy, personagem.largura,personagem.altura)
    love.graphics.setColor(0,100/255,0,1)
    love.graphics.rectangle("fill", 0,(altura/2)+personagem.altura,largura,500)
end

function love.keypressed( key )
    if key == "a" then
        if personagem.vely == 0 then
            personagem.vely = alturaDoPulo
        end
    end
end