som = love.audio.newSource("Som/san_tropez.mp3", "static")
imgPlay = love.graphics.newImage("play.png")
imgPause = love.graphics.newImage("stop.png")
imgStop = love.graphics.newImage("stop2.png")
volume = 1
local textoVolume = ""

function love.update(dt)
    som:setVolume(volume)
    textoVolume = volume
end

function love.draw()
    love.graphics.setColor(0,0,0)
    love.graphics.print(textoVolume,50,50)
    love.graphics.setColor(255,255,255)
    love.graphics.setBackgroundColor(255,255,255)
    love.graphics.draw(imgPlay,200,50,0)
    love.graphics.draw(imgStop,350,50,0)
    love.graphics.draw(imgPause,500,50,0)
end

function love.mousepressed(mx, my, button)
    if button == 1 and mx >= 200 and mx <200 +imgPlay:getWidth() and my >= 50 and my < 50 + imgPlay:getHeight() then
        som:play()
    end
    if button == 1 and mx >= 350 and mx <350 +imgPause:getWidth() and my >= 50 and my < 50 + imgPause:getHeight() then
        som:pause()
    end
    if button == 1 and mx >= 500 and mx <500 +imgStop:getWidth() and my >= 50 and my < 50 + imgStop:getHeight() then
        som:stop()
    end
end

function love.wheelmoved(x,y)
    if y > 0 then
        volume = volume + 0.1
        if volume >= 1 then
            volume = 1
        end
    elseif y < 0 then
        volume = volume - 0.1
        if volume < 0.1 then
            volume = 0
        end
    end

end