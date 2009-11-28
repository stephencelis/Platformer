package Sprites {
  import org.flixel.*;
  import States.PlayState;

  public class Mouse extends FlxSprite {
    [Embed(source = "../Resources/Mouse.png")] private var MouseImage:Class;
    [Embed(source = "../Resources/Footstep.mp3")] private var FootstepSound:Class;

    private var runVelocity:int = 70;
    private var lastFrame:int;
    private var jumpVelocity:int = 180;
    private var jumping:Boolean = false;

    public function Mouse(x:int, y:int) {
      super(MouseImage, x, y, true, true);

      // Bounding box.
      offset.x = 5;
      offset.y = 4;
      width = 6;
      height = 12;

      // Physics.
      maxVelocity.x = runVelocity;
      maxVelocity.y = jumpVelocity * 2;
      acceleration.y = 420;
      drag.x = maxVelocity.x * 8;

      // Animations.
      addAnimation("idle", [0]);
      addAnimation("run", [1, 2, 3, 0], 10);
      addAnimation("jump", [1]);
      addAnimation("dead", [4], 1, false);
    }

    override public function update():void {
      acceleration.x = 0;

      if (!dead && y > FlxG.height) {
        kill();
      }

      if (dead) {
        FlxG.switchState(PlayState);
      } else {
        if (FlxG.keys.LEFT) {
          facing = LEFT;
          acceleration.x -= drag.x;
        } else if (FlxG.keys.RIGHT) {
          facing = RIGHT;
          acceleration.x += drag.x
        }

        if (FlxG.keys.justPressed("X") && !jumping && velocity.y < 30) {
          trace("TESTING");

          jumping = true;
          velocity.y = -jumpVelocity;
        }

        if (velocity.y != 0) {
          play("jump");
        } else if (velocity.x != 0) {
          play("run");
          if ((_curFrame == 1 || _curFrame == 3) && _curFrame != lastFrame) {
            lastFrame = _curFrame;
            FlxG.play(FootstepSound, 0.75);
          }
        } else {
          lastFrame = 0;
          play(FlxG.keys.DOWN ? "dead" : "idle");
        }
      }

      super.update();
    }

    override public function hitFloor(contact:FlxCore = null):Boolean {
      if (jumping) {
        jumping = false;
        FlxG.play(FootstepSound);
      }

      return super.hitFloor(contact);
    }
  }
}
