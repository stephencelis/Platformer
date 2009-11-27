package {
  import org.flixel.*;
  import States.MenuState;

  // Set size and color of flash file.
  [SWF(width = "640", height = "480", backgroundColor = "#000000")]

  // Use preloader.
  [Frame(factoryClass = "Preloader")]

  public class Platformer extends FlxGame {
    public function Platformer():void {
      super(
        320,        // Width.
        240,        // Height.
        MenuState,  // First state.
        2,          // Pixel multiplier.
        0xff000000, // Foreground color.
        false,      // Show Flixel intro.
        0xffffffff  // Background color.
      );

      // help(
      //   "A Button", // "X" key.
      //   "B Button", // "C" key.
      //   "Mouse",
      //   "Move"
      // );
    }
  }
}
