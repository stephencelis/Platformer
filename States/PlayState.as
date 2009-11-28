package States {
  import org.flixel.*;
  import Sprites.*;

  public class PlayState extends FlxState {
    [Embed(source = "../Resources/Block.png")] private var BlockImage:Class;

    private var player:FlxSprite;
    private var blocks:FlxArray;

    override public function PlayState():void {
      super();

      blocks = new FlxArray;
      blocks.add(add(new FlxBlock(0, 116, 320, 16, BlockImage)));

      player = new Bat(72, 100);
      FlxG.follow(player);
      FlxG.followAdjust(0.5, 0.0);
      FlxG.followBounds(-60, -240, 380, 240);

      // Avoid flickering restart after .
      if (FlxG.scroll.x > FlxG.followMin.x) FlxG.scroll.x = FlxG.followMin.x;
      if (FlxG.scroll.y > FlxG.followMin.y) FlxG.scroll.y = FlxG.followMin.y;
      if (FlxG.scroll.x < FlxG.followMax.x) FlxG.scroll.x = FlxG.followMax.x;
      if (FlxG.scroll.y < FlxG.followMax.y) FlxG.scroll.y = FlxG.followMax.y;

      add(player);
    }

    override public function update():void {
      super.update();

      FlxG.collideArray(blocks, player);
    }
  }
}
