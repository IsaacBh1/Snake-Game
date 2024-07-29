require("snake")
require("Collusion")
function love.load()
    Head = {
        H = {   x = love.graphics.getWidth()/2,
            y = love.graphics.getHeight()/2,
            radius = 10
        },
        {   x = love.graphics.getWidth()/2,
            y =( love.graphics.getHeight()/2)+10,
            radius = 10
        },
        {   x = love.graphics.getWidth()/2,
            y = (love.graphics.getHeight()/2),
            radius = 10
        },
        {   x = love.graphics.getWidth()/2,
            y =( love.graphics.getHeight()/2),
            radius = 10
        },
        {   x = love.graphics.getWidth()/2,
            y = (love.graphics.getHeight()/2),
            radius = 10
        },
        {   x = love.graphics.getWidth()/2,
            y =( love.graphics.getHeight()/2),
            radius = 1
        },
        {   x = love.graphics.getWidth()/2,
            y = (love.graphics.getHeight()/2),
            radius = 10
        }
    }
    Controle = {
        left = false,
        right = false,
        up = true,
        down = false
    }
    Fruits = {}
    BigFruits = {}
    Bigest = 15
    math.randomseed(os.time())
    Myfont1 = love.graphics.newFont(60)
    Myfont2 = love.graphics.newFont(25)
    GameOver = false
    Score = 0
    --S mean the speed 
    S = 1
    K = 0
end
function love.update(dt)
    if not(GameOver) then
    Head,Head[1].x,Head[1].y,Controle.up,Controle.down,Controle.left,Controle.right = Player_control(Head,Head[1].x,Head[1].y,Controle.up,Controle.down,Controle.left,Controle.right,S)
        if (#Fruits < 2 )then
            local fruit = {
                x = math.random(10,love.graphics.getWidth()-10),
                y = math.random(10,love.graphics.getHeight()-10),
                radius = 7
            }
            table.insert(Fruits,fruit)
        end
        for i = #Fruits ,1,-1 do
            if AABBcollution(Head[1].x,Head[1].y,15,15,Fruits[i].x,Fruits[i].y,10,10) then 
                table.remove(Fruits,i)
                for i = 1 , Bigest do
                    table.insert(Head,{x = Head[#Head].x,y = Head[#Head].y,radius = 10,speed = 1})
                end
                Score = Score + 1
            end
        end
        for i = 6 ,#Head,1 do 
            local part = Head[i] 
            if AABBcollution(part.x,part.y,1,1,Head[1].x,Head[1].y,1,1) then
                GameOver = true
            end
        end
        if (#BigFruits == 0) and (Score%15 == 0) and(Score ~= 0) then
            local bigfruit = { x = math.random(love.graphics.getWidth()) , y = math.random(love.graphics.getHeight()), radius = 15}
            table.insert(BigFruits,bigfruit)
        end
        if (#BigFruits ~= 0) then 
            if AABBcollution(Head[1].x,Head[1].y,15,15,BigFruits[1].x,BigFruits[1].y,20,20)then 
                table.remove(BigFruits,1)
                for i = 1 , Bigest*2 do 
                    table.insert(Head,{x = Head[#Head].x,y = Head[#Head].y,radius = 10})
                end
                Score = Score + 5
                Speed = Speed + 1
            end
        end
    else 
        K = K + dt
    end
end
function love.draw()
        if not(GameOver) then 
        love.graphics.setBackgroundColor(1,1,1)
        love.graphics.setColor(192/255,46/255,46/255)
        for i=1 ,#Head,1 do          
            local part = Head[i]
            love.graphics.circle("fill",part.x,part.y,part.radius)
        end
        love.graphics.setColor(0,1,0.5)
        for i = 1,#Fruits,1 do 
            local fruit = Fruits[i]
            love.graphics.circle("fill",fruit.x,fruit.y,fruit.radius)
        end
        love.graphics.setColor(0,0,1,0.5)
        if (#BigFruits ~= 0) then 
            love.graphics.circle("fill",BigFruits[1].x,BigFruits[1].y,BigFruits[1].radius)  
        end
        love.graphics.setColor(0,0,0)
        love.graphics.print('Score : '..Score,20,20)
    else 
        love.graphics.setColor(1,0,0)
        love.graphics.setFont(Myfont1 )
        love.graphics.print('Game Over',(love.graphics.getWidth()/2)-160,((love.graphics.getHeight()/2)-50)+200*math.sin(K)/5)
        love.graphics.setFont(Myfont2)
        love.graphics.setColor(0,0,0)
        love.graphics.print('score : '..Score,(love.graphics.getWidth()/2)-50,((love.graphics.getHeight()/2) +150))
    end
end
