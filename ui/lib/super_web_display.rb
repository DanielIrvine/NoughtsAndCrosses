require 'web_display'

module NoughtsAndCrosses
  module SuperWeb
    class SuperWebDisplay < Web::WebDisplay

      TEMPLATE_DIR = File.dirname(__FILE__) + '/../templates/super/'
      START_TEMPLATE = 'super_index.html.erb'

      def call(env)

        path = env['PATH_INFO'].split('/').reject(&:empty?)

        return show(START_TEMPLATE) if path.empty?
        

      end

    end
  end
end
