
function love.load(  )
    rect = {
        x = 100,
        y = 100,
        width = 100,
        height = 100,
        draggin = {
            active = false,
            distx = 0,
            disty = 0
        }
    }
end

function love.update(dt)
    if rect.draggin.active then
        rect.x = love.mouse.getX() - rect.draggin.distx
        rect.y = love.mouse.getY() - rect.draggin.disty
    end
end

function love.draw()
    love.graphics.rectangle("fill",rect.x,rect.y,rect.width,rect.height)
end

function love.mousepressed(x,y,button,istouch)
    if button == 1 and x > rect.x and x < rect.x + rect.width and y > rect.y and y < rect.y + rect.height then
        rect.draggin.active = true
        rect.draggin.distx = x - rect.x
        rect.draggin.disty = y - rect.y
    end
end

function love.mousereleased(x,y,button)
    if button == 1 then
        rect.draggin.active = false
    end
end
