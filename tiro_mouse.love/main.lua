largura = love.graphics.getWidth()
altura = love.graphics.getHeight()

function love.load()
    atirador = love.graphics.newImage("personagem.png")
    tiro = love.graphics.newImage("Projetil.png")

    personagem = {
        x = largura /2,
        y = altura/2
    }

    projetil = {
        x = personagem.x,
        y = personagem.y,
        posx = 0,
        posy = 0,
        rotProjetil = 0
    }

    direcao = false
    mantemDirecao = true
end

function love.update(dt)
    mousex = love.mouse.getX() - largura / 2
    mousey = love.mouse.getY() - altura / 2
    angulo = math.atan2(mousey,mousex)

    if direcao and mantemDirecao then
        projetil.x = projetil.x + projetil.posx*dt
        projetil.y = projetil.y + projetil.posy*dt
    else
        projetil.x = personagem.x
        projetil.y = personagem.y
        projetil.rotProjetil = angulo
    end

    if projetil.x > largura or projetil.x < 0 or projetil.y > altura or projetil.y < 0 then
        direcao = false
        mantemDirecao = true
    end
end

function love.draw()
    love.graphics.setBackgroundColor(1,1,1)
    love.graphics.draw(tiro, projetil.x, projetil.y,projetil.rotProjetil,1,1,50,tiro:getHeight()/2)
    love.graphics.draw(atirador, personagem.x, personagem.y,angulo,1,1,atirador:getWidth()/2, atirador:getHeight()/2)
end

function love.keyreleased(key)
    if key == 'a' and not direcao then
        projetil.posx = math.cos(angulo) * 500
        projetil.posy = math.sin(angulo) * 900
        direcao = true
    end
end