package Sprites {
  import org.flixel.*;
  import States.PlayState;

  public class Bat extends FlxSprite {
    [Embed(source = "../Resources/Bat.png")] private var BatImage:Class;
    [Embed(source = "../Resources/Footstep.mp3")] private var FootstepSound:Class;
    [Embed(source = "../Resources/Flap.mp3")] private var FlapSound:Class;

    private var runVelocity:int = 70;
    private var lastFrame:int;
    private var jumpVelocity:int = 200;
    private var jumping:Boolean = false;
    private var wasJumping:Boolean = jumping;
    private var flyVelocity:int = jumpVelocity;
    private var hanging:Boolean = false;

    public function Bat(x:int, y:int) {
      super(BatImage, x, y, true, true);

      // Bounding box.
      offset.x = 5;
      offset.y = 3;
      width = 6;
      height = 13;

      // Physics.
      maxVelocity.x = runVelocity;
      maxVelocity.y = jumpVelocity * 2;
      acceleration.y = 420;
      drag.x = maxVelocity.x * 8;

      // Animations.
      addAnimation("idle", [0]);
      addAnimation("run", [1, 0, 2, 0], 10);
      addAnimation("fall", [3]);
      addAnimation("jump", [4]);
      addAnimation("hang", [5]);
    }

    override public function update():void {
      acceleration.x = 0;

      if (!dead && y > FlxG.height) {
        kill();
      }

      if (dead) {
        FlxG.switchState(PlayState);
      } else {
        handleInput();
        handleAnimation();
      }

      if (!hanging) {
        super.update();
      }
    }

    override public function hitFloor(contact:FlxCore = null):Boolean {
      if (jumping) {
        jumping = false;
        FlxG.play(FootstepSound);
      }

      return super.hitFloor(contact);
    }

    override public function hitCeiling(contact:FlxCore = null):Boolean {
      if (FlxG.keys.UP) {
        hanging = true;
        jumping = false;
        velocity.x = velocity.y = 0;
      }

      return super.hitCeiling(contact);
    }

    private function handleInput():void {
      if (hanging) {
        velocity.y = 0;
      }

      if (FlxG.keys.LEFT) {
        facing = LEFT;
        if (!hanging)
          acceleration.x -= drag.x;
      } else if (FlxG.keys.RIGHT) {
        facing = RIGHT;
        if (!hanging)
          acceleration.x += drag.x
      }

      wasJumping = jumping;
      if (FlxG.keys.justPressed("X") && (!jumping || velocity.y > 18)) {
        hanging = false;

        if (!wasJumping) {
          flyVelocity = jumpVelocity
        }

        var reboundVelocity:int = velocity.y - flyVelocity;
        if (reboundVelocity < 0) {
          jumping = true;
          velocity.y = reboundVelocity;
          FlxG.play(FlapSound, 0.25);
          flyVelocity *= 0.9;
        }
      }
    }

    private function handleAnimation():void {
      if (hanging) {
        play("hang");
      } else if (velocity.y != 0) {
        play(velocity.y < 0 && wasJumping ? "jump" : "fall");
      } else if (velocity.x != 0) {
        play("run");
        if ((_curFrame == 1 || _curFrame == 3) && _curFrame != lastFrame) {
          lastFrame = _curFrame;
          FlxG.play(FootstepSound, 0.75);
        }
      } else {
        play("idle");
        lastFrame = 0;
      }
    }
  }
}
