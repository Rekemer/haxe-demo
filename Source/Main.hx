package;

import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.Lib;
import openfl.text.TextField;
import openfl.ui.Keyboard;    // важно добавить импорт!

class Main extends Sprite {
    var box:Sprite;
    var label:TextField;

    public function new() {
        super();

        // Синий квадрат
        box = new Sprite();
        box.graphics.beginFill(0x3366CC);
        box.graphics.drawRect(0, 0, 100, 100);
        box.graphics.endFill();
        box.x = 350;
        box.y = 250;
        addChild(box);

        // Надпись
        label = new TextField();
        label.text = "Click me!";
        label.y = 10;
        addChild(label);

        // Смена цвета по клику
        box.addEventListener("click", function(_) {
            box.graphics.clear();
            box.graphics.beginFill(Math.random() * 0xFFFFFF);
            box.graphics.drawRect(0, 0, 100, 100);
            box.graphics.endFill();
        });

        // Движение по стрелкам
        Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
    }

    function onKey(e:KeyboardEvent):Void {
        if (e.keyCode == Keyboard.LEFT)      box.x -= 10;
        else if (e.keyCode == Keyboard.RIGHT) box.x += 10;
        else if (e.keyCode == Keyboard.UP)    box.y -= 10;
        else if (e.keyCode == Keyboard.DOWN)  box.y += 10;
    }
}
