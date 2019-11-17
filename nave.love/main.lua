larguraTela = love.graphics.getWidth()
alturaTela = love.graphics.getHeight()
anim = require("anim8")

function love.load()
    imagemNave = love.graphics.newImage("imagens/Nave.png")

    nave = {
        posx = larguraTela/2,
        posy = alturaTela/2,
        velocidade = 200
    }

    atira = true
    delayTiro = 0.5
    tempoAteAtirar = delayTiro
    tiros = {}
    imagemTiro = love.graphics.newImage("imagens/Projetil.png")

    delayInimigo = 0.4
    tempoCriacaoInimigo = delayInimigo
    imagemInimigo = love.graphics.newImage("imagens/Inimigo.png")
    inimigos = {}

    estaVivo = true
    pontos = 0
    vidas = 2
    gameOver = false
    transparencia = 0
    imagemGameOver = love.graphics.newImage("imagens/GameOver.png")

    fundo = love.graphics.newImage("imagens/Background.png")
    fundoDois = love.graphics.newImage("imagens/Background.png")
    planoDeFundo = {
        x = 0,
        y =0,
        y2 = 0 - fundo:getHeight(),
        vel = 30 
    }

    fonte = love.graphics.newImageFont("imagens/Fonte.png", " abcdefghijklmnopqrstuvwxyz" .. "ABCDEFGHIJKLMNOPQRSTUVWXYZ".."0123456789.,!?-+/():;%&`´*#=[]")

    somDoTiro = love.audio.newSource("sons/Tiro.wav", "static")
    explodeNave = love.audio.newSource("sons/ExplodeNave.wav", "static")
    somExplodeInimigo = love.audio.newSource("sons/ExplodeInimigo.wav", "static")
    musica = love.audio.newSource("sons/Musica.wav", "static")
    somGameOver = love.audio.newSource("sons/GameOver.ogg", "static")
    musica:play()
    musica:setLooping(true)

    scalex = 1
    scaley = 1

    abreTela = false
    telaTitulo = love.graphics.newImage("imagens/ImagemTitulo.png")
    inOutx = 0
    inOuty = 0

    pausar = false

    bombaVazia = love.graphics.newImage("imagens/BombaVazia.png")
    bombaCheia = love.graphics.newImage("imagens/BombaCheia.png")
    bombaCheiaAviso = love.graphics.newImage("imagens/BombaCheiaAviso.png")
    explosao = love.graphics.newImage("imagens/Explosao.png")
    somExplosao = love.audio.newSource("sons/Explosao.mp3", "static")

    explodir = {}
    podeExplodir = false
    carregador = 0
    animaAviso = 0.8

    local g = anim.newGrid(192,192, explosao:getWidth(), explosao:getHeight())
    animation = anim.newAnimation(g('1-5',2,'1-5',3,'1-5',4,'1-4',5),0.09,destroi)

    explodeInimigo = {}
    destroiInimigo = love.graphics.newImage("imagens/Explosao.png")
    explodeInimigo.x = 0
    explodeInimigo.y = 0
    local gride = anim.newGrid(64,64, destroiInimigo:getWidth(),destroiInimigo:getHeight())
    destruicaoInimigo = anim.newAnimation(gride('1-5',1,'1-5',2,'1-5',3,'1-5',4,'1-3',5),0.01,destroiDois)

end

function love.update(dt)
    if not pausar then
        movimentos(dt)
        atirar(dt)
        inimigo(dt)
        colisoes()
        reset()
        planoDeFundoScrolling(dt)
        efeito(dt)
        iniciaJogo(dt)
        controlaExplosao(dt)
        bombaPronta(dt)
    end
    if gameOver then
        fimDeJogo(dt)
    end
end

function love.draw() 
    if not gameOver then
        love.graphics.draw(fundo, planoDeFundo.x, planoDeFundo.y)
        love.graphics.draw(fundoDois,planoDeFundo.x, planoDeFundo.y2)

        for i, tiro in ipairs(tiros) do
            love.graphics.draw(tiro.img, tiro.x, tiro.y, 0, 1,1,imagemTiro:getWidth()/2,imagemTiro:getHeight()/2)
            if pontos > 10 then
                love.graphics.draw(tiro.img, tiro.x -10, tiro.y+15, 0, 1,1,imagemTiro:getWidth()/2,imagemTiro:getHeight()/2)
                love.graphics.draw(tiro.img, tiro.x +10, tiro.y+15, 0, 1,1,imagemTiro:getWidth()/2,imagemTiro:getHeight()/2)
                delayTiro = 0.4
                if pontos > 20 then
                    love.graphics.draw(tiro.img, tiro.x -20, tiro.y+30, 0, 1,1,imagemTiro:getWidth()/2,imagemTiro:getHeight()/2)
                    love.graphics.draw(tiro.img, tiro.x +20, tiro.y+30, 0, 1,1,imagemTiro:getWidth()/2,imagemTiro:getHeight()/2)
                    delayTiro = 0.3
                    if pontos > 30 then
                        delayTiro = 0.2
                    end
                end
            end
        end

        for i, inimigo in ipairs(inimigos) do
            love.graphics.draw(inimigo.img, inimigo.x, inimigo.y)
        end

        for i, _ in ipairs(explodeInimigo) do
            destruicaoInimigo:draw(destroiInimigo, explodeInimigo.x, explodeInimigo.y)
        end

        love.graphics.setFont(fonte)
        love.graphics.print("Pontuacao: ",10,10,0,1,1,0,2,0,0)
        love.graphics.print(pontos, 105,15,0,scalex,scaley,5,5,0,0)
        love.graphics.print("Vidas: " .. vidas,400,15)

        for i, _ in ipairs(explodir) do
            animation:draw(explosao, larguraTela/2,alturaTela/2,0,4,4,96,96)
        end
        love.graphics.draw(bombaVazia,larguraTela/2,50,0,1,1,bombaVazia:getWidth()/2,bombaVazia:getHeight()/2)
        love.graphics.draw(bombaCheia,larguraTela/2,50,0,carregador, carregador,bombaCheia:getWidth()/2,bombaCheia:getHeight()/2)
        if podeExplodir then
            love.graphics.draw(bombaCheiaAviso, larguraTela/2, 50, 0, animaAviso,animaAviso,bombaCheiaAviso:getWidth()/2,bombaCheiaAviso:getHeight()/2)
        end
    end

    if estaVivo then
        love.graphics.draw(imagemNave, nave.posx, nave.posy, 0, 1, 1, imagemNave:getWidth()/2,imagemNave:getHeight()/2)
    elseif gameOver then
        love.graphics.setColor(1,1,1, transparencia)
        love.graphics.draw(imagemGameOver,0,0)
        love.graphics.print("PONTOS TOTAIS: " ..  pontos, larguraTela/4,50)
    else
        love.graphics.draw(telaTitulo, inOutx, inOuty)
    end

end

function atirar(dt)
    tempoAteAtirar = tempoAteAtirar - (1*dt)
    if tempoAteAtirar < 0 then
        atira = true
    end
    if estaVivo then
        if love.keyboard.isDown("space") and atira then
            novoTiro = {x = nave.posx, y = nave.posy, img = imagemTiro}
            table.insert( tiros,novoTiro)
            somDoTiro:stop()
            somDoTiro:play()
            atira = false
            tempoAteAtirar = delayTiro
        end
    end
    for i, tiro in ipairs(tiros) do
        tiro.y = tiro.y - (500*dt)
        if tiro.y < 0 then
            table.remove( tiros,i )
        end
    end
end

function movimentos(dt)
    if love.keyboard.isDown('right') then
        if nave.posx < (larguraTela - imagemNave:getWidth()/2) then
            nave.posx = nave.posx + nave.velocidade*dt
        end
    end
    if love.keyboard.isDown('left') then
        if nave.posx > (imagemNave:getWidth()/2) then
            nave.posx = nave.posx - nave.velocidade*dt
        end
    end
    if love.keyboard.isDown('up') then
        if nave.posy > (imagemNave:getHeight()/2) then
            nave.posy = nave.posy - nave.velocidade*dt
        end
    end
    if love.keyboard.isDown('down') then
        if nave.posy < (alturaTela - imagemNave:getHeight()/2) then
            nave.posy = nave.posy + nave.velocidade*dt
        end
    end
end

function inimigo(dt)
    tempoCriacaoInimigo = tempoCriacaoInimigo - dt

    if tempoCriacaoInimigo < 0 then
        tempoCriacaoInimigo = delayInimigo
        numeroAleatorio = math.random( 10, love.graphics.getWidth() - ((imagemInimigo:getWidth()/2) ))
        novoInimigo = {x = numeroAleatorio, y = -imagemInimigo:getWidth(), img = imagemInimigo}
        table.insert( inimigos,novoInimigo )
    end

    for i, inimigo in ipairs(inimigos) do
        inimigo. y = inimigo.y + (200*dt)
        if inimigo.y > 850 then
            table.remove( inimigos,i )
        end
    end
end

function colisoes()
    for i, inimigo in ipairs(inimigos) do
        for j, tiro in ipairs(tiros) do
            if checaColisao(inimigo.x,inimigo.y,imagemInimigo:getWidth(),imagemInimigo:getHeight(), tiro.x, tiro.y, imagemTiro:getWidth(), imagemTiro:getHeight() ) then
                table.remove( tiros,j )
                explodeInimigo.x = inimigo.x
                explodeInimigo.y = inimigo.y
                table.insert(explodeInimigo, destruicaoInimigo)
                table.remove( inimigos,i )
                somExplodeInimigo:stop()
                somExplodeInimigo:play()
                scaley = 1.5
                scalex = 1.5
                pontos = pontos + 1
                carregador = carregador + 0.1
                if carregador >= 1 then
                    carregador = 1
                    podeExplodir = true
                end
            end
        end
        if checaColisao(inimigo.x,inimigo.y,imagemInimigo:getWidth(),imagemInimigo:getHeight(),nave.posx - (imagemNave:getWidth()/2),nave.posy, imagemNave:getWidth(), imagemNave:getHeight()) and estaVivo then
            estaVivo = false
            table.remove( inimigos,i )
            explodeNave:stop()
            explodeNave:play()
            abreTela = false
            vidas = vidas - 1
            if vidas < 0 then
                gameOver = true
                somGameOver:play()
                somGameOver:setLooping(false)
            end
        end
    end
end

function efeito(dt)
    scalex = scalex - 3*dt
    scaley = scaley - 3*dt

    if scalex <= 1 then
        scalex = 1
        scaley = 1
    end
end

function checaColisao(x1,y1,w1,h1,x2,y2,w2,h2)
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end

function reset()
    if not estaVivo and inOuty==0 and love.keyboard.isDown('return') then
        tiros = {}
        inimigos = {}

        atira = true
        tempoCriacaoInimigo = delayInimigo

        nave.posx = larguraTela / 2
        nave.posy = alturaTela /2

        abreTela = true
    end
end

function planoDeFundoScrolling(dt)
    planoDeFundo.y = planoDeFundo.y + planoDeFundo.vel*dt
    planoDeFundo.y2 = planoDeFundo.y2 + planoDeFundo.vel*dt

    if planoDeFundo.y > alturaTela then
        planoDeFundo.y = planoDeFundo.y2 - fundoDois:getHeight()
    end
    if planoDeFundo.y2 > alturaTela then
        planoDeFundo.y2 = planoDeFundo.y - fundoDois:getHeight()
    end
end

function iniciaJogo(dt)
    if abreTela and not estaVivo then
        inOutx = inOutx + 600*dt
        if inOutx > 481 then
            inOuty = -701
            inOutx = 0
            estaVivo = true
        end
    elseif not abreTela then
        estaVivo = false
        inOuty = inOuty + 600*dt
        if inOuty > 0 then
            inOuty = 0
        end
    end
end

function love.keyreleased(key)
    if key == 'p' and abreTela then
        pausar = not pausar
    end
    if pausar then
        musica:pause()
    else
        love.audio.play(musica)
    end
    if key == "e" and not gameOver and podeExplodir then
        novaExplosao = {}
        table.insert( explodir,novaExplosao )
        somExplosao:play()
        carregador = 0
        for i, _ in ipairs(inimigos)do
            pontos = pontos + 1
        end
        inimigos = {}
        podeExplodir = false
    end
end

function fimDeJogo(dt)
    pausar = true
    musica:stop()
    transparencia = transparencia + 100*dt
    if love.keyboard.isDown('escape')then
        love.event.quit()
    end
end

function controlaExplosao(dt)
    for i, _ in ipairs(explodir)do
        animation:update(dt)
    end
    for i, _ in ipairs(explodeInimigo)do
        destruicaoInimigo:update(dt)
    end
end

function bombaPronta(dt)
    animaAviso = animaAviso + 0.5*dt
    if animaAviso >=1 then
        animaAviso = 0.8
    end
end

function destroi()
    for i, _ in ipairs(explodir) do
        table.remove( explodir,i )
    end
end

function destroiDois()
    for i, _ in ipairs(explodeInimigo) do
        table.remove( explodeInimigo,i )
    end
end
