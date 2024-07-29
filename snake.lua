function Player_control(Head,Headx,Heady,Controle_up,Controle_down,Controle_left,Controle_right,s)
    -- S mean the speed 
    for i=#Head-1,1,-1 do
        Head[i+1].x,Head[i+1].y = Head[i].x, Head[i].y
    end
    if( Controle_up == true )or(love.keyboard.isDown("w")) then 
        Controle_down,Controle_left,Controle_right,Controle_up = false,false,false,true
        Heady = Heady - s
    end
    if( Controle_down == true )or(love.keyboard.isDown("s")) then 
        Controle_up,Controle_left,Controle_right,Controle_down = false,false,false,true
        Heady = Heady + s
    end
    if( Controle_left == true )or(love.keyboard.isDown("a")) then 
        Controle_down,Controle_up,Controle_right,Controle_left = false,false,false,true
        Headx = Headx - s
    end
    if( Controle_right == true )or(love.keyboard.isDown("d")) then 
        Controle_down,Controle_left,Controle_up,Controle_right = false,false,false,true
        Headx = Headx + s
    end    
    return Head,Headx,Heady,Controle_up,Controle_down,Controle_left,Controle_right
end