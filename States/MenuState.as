package States {
  import org.flixel.*;

  public class MenuState extends FlxState {
    override public function MenuState():void {
      super();

      add(new FlxText(
        0,                      // x.
        (FlxG.width / 2) - 80,  // y.
        FlxG.width,             // Width.
        80,                     // Height.
        "Platformer",
        0xffffffff,             // Color.
        null,                   // Font (default).
        16,                     // Size.
        "center"                // Justification.
      )) as FlxText;

      add(new FlxText(
        0, FlxG.height -24, FlxG.width, 8, "PRESS X TO START", 0xffffffff,
          null, 8, "center"
      )) as FlxText;
    }

    override public function update():void {
      if (FlxG.keys.justPressed("X")) { // A button.
        FlxG.flash(0xffffffff, 0.75);
        FlxG.fade(0xff000000, 1, startGame);
      }

      super.update();
    }

    private function startGame():void {
      FlxG.switchState(PlayState);
    }
  }
}
