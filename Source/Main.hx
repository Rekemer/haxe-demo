package;

import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.Lib;
import openfl.text.TextField;
import openfl.ui.Keyboard;
import Math;


class Particle extends Sprite {
    public var vx:Float;
    public var vy:Float;
    public var life:Float;
    static inline var GRAVITY:Float = 300; 

    public function new(x:Float, y:Float, vx:Float, vy:Float, life:Float, color:Int) {
        super();
        this.x = x;
        this.y = y;
        this.vx = vx;
        this.vy = vy;
        this.life = life;

        graphics.beginFill(color);
        graphics.drawCircle(0, 0, 3);
        graphics.endFill();
    }

    public function update(dt:Float):Bool {
        life -= dt;
        if (life <= 0) return false;

        vy += GRAVITY * dt;
        x += vx * dt;
        y += vy * dt;
        alpha = life; 

        return true;
    }
}


class Main extends Sprite {
    var box:Sprite;
    var particles:Array<Particle> = [];

    public function new() {
        super();

       
        box = new Sprite();
        box.graphics.beginFill(0x3366CC);
        box.graphics.drawRect(0, 0, 100, 100);
        box.graphics.endFill();
        box.x = 350;
        box.y = 250;
        addChild(box);

        
        //var label = new TextField();
        //label.text = "Click me!";
        //label.y = 10;
        //addChild(label);

       
        box.addEventListener(MouseEvent.CLICK, onBoxClick);
        Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
        addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

  
    function onKey(e:KeyboardEvent):Void {
        if (e.keyCode == Keyboard.LEFT)      box.x -= 10;
        else if (e.keyCode == Keyboard.RIGHT) box.x += 10;
        else if (e.keyCode == Keyboard.UP)    box.y -= 10;
        else if (e.keyCode == Keyboard.DOWN)  box.y += 10;
    }

    
    function onBoxClick(_):Void {
        for (i in 0...25) {
            var angle  = Math.random() * Math.PI * 2;
            var speed  = 150 + Math.random() * 150;
            var p = new Particle(
                box.x + 50, box.y + 50,
                Math.cos(angle) * speed,
                Math.sin(angle) * speed,
                1.0,
                Std.int(Math.random() * 0xFFFFFF)
            );
            particles.push(p);
            addChild(p);
        }
    }

   
    function onEnterFrame(_):Void {
        var dt:Float = 1.0 / Lib.current.stage.frameRate;

        var i = particles.length - 1;
        while (i >= 0) {
            if (!particles[i].update(dt)) {
                removeChild(particles[i]);
                particles.splice(i, 1);
            }
            i--;
        }
    }
}
