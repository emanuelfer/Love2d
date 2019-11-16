function love.load(  )
    _imagem = love.graphics.newImage("imagem.png")
    _rotacao = 0
    texto = ""
    meuObjeto = {
        imagem = _imagem,
        nome = "Objeto",
        posX = 30,
        posY = 20,
        tamanho = 10,
        peso = 3.7,
        rotacao = 0
    }
end

function love.draw(  )
    --[[
    love.graphics.draw(meuObjeto.imagem, meuObjeto.posX,meuObjeto.posY,meuObjeto.rotacao,0.08,0.08)
    love.graphics.print(meuObjeto.nome, meuObjeto.posX, meuObjeto.posY - 15)
    love.graphics.print(texto, 200, 200)
    --]]
end

function love.mousepressed( x,y,button,istouch )
    if button == 1 then
        meuObjeto.posX = x
        meuObjeto.posY = y
    end
end

function love.mousereleased(x,y,button, istouch)
    _rotacao = _rotacao + 1
    if button == 1 then
        meuObjeto.posX = 30
        meuObjeto.posY = 20
        meuObjeto.rotacao = _rotacao
    end
end

function love.keypressed( key,unicode )
    if key ~= "escape" then
        texto = "A tecla " .. key .. " foi pressionada."
    elseif key == "escape" then
        love.event.quit()
    end
end

function love.keyreleased(key, unicode)
    if key ~= "escape" then
        texto = "A tecla " .. key .. " foi solta"
    elseif key == "escape" then
        love.event.quit()
    end
end

function love.focus(f)
    if not f then
        print("sem foco no jogo!")
    else
        print("Jogo sendo jogado!")
    end
end

function love.quit()
    print("Jogou o suficiente? Volte logo!")

    if love.timer.sleep(5) == 0 then

    end
end
