package States {
  import org.flixel.*;
  import Sprites.Mouse;

  public class PlayState extends FlxState {
    [Embed(source = "../Resources/Block.png")] private var BlockImage:Class;

    private var mouse:Mouse;
    private var blocks:FlxArray;

    override public function PlayState():void {
      super();

      blocks = new FlxArray;
      blocks.add(add(new FlxBlock(0, 216, 320, 16, BlockImage)));

      mouse = new Mouse(72, 200);
      FlxG.follow(mouse);
      add(mouse);
    }

    override public function update():void {
      super.update();

      FlxG.collideArray(blocks, mouse);
    }
  }
}
