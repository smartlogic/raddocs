module Raddocs
  class Configuration
    def self.add_setting(name, opts = {})
      define_method("#{name}=") { |value| settings[name] = value }
      define_method("#{name}") do
        if settings.has_key?(name)
          settings[name]
        elsif opts[:default].respond_to?(:call)
          opts[:default].call(self)
        else
          opts[:default]
        end
      end
    end

    add_setting :docs_dir, :default => "doc/api"
    add_setting :docs_mime_type, :default => /text\/docs\+plain/
    add_setting :api_name, :default => "Api Documentation"
    add_setting :include_bootstrap, :default => true
    add_setting :external_css, :default => []

    def settings
      @settings ||= {}
    end
  end
end
