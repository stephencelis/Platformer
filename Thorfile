require "activesupport"

module Flx
  class Gen < Thor
    include Thor::Actions

    desc "state StateName", "Generate a state"
    def state(name)
      name = name.classify
      inside "States" do
        create_file "#{name}State.as", template(name, "FlxState")
      end
    end

    desc "sprite SpriteName", "Generate a sprite"
    def sprite(name)
      name = name.classify
      inside "Sprites" do
        create_file "#{name}.as", template(name, "Sprite")
      end
    end

    no_tasks do
      def template(class_name, class_type)
        <<TEMPLATE
package #{class_type.sub("Flx", "").pluralize} {
  import org.flixel.*;

  public function #{class_name}() {
    super();
  }
}
TEMPLATE
      end
    end
  end
end
