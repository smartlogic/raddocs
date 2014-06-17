module Raddocs
  class Configuration
    # Configures a new setting, creates two methods
    #
    # @param name [Symbol] name of the setting
    # @param opts [Hash]
    # @option opts [Object] default default value of setting
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

    # @!attribute docs_dir
    # @return [String] defaults to 'doc/api'
    add_setting :docs_dir, :default => "doc/api"

    # @!attribute docs_mime_type
    # @return [Regexp] defaults to Regexp.new("text/docs\+plain")
    add_setting :docs_mime_type, :default => /text\/docs\+plain/

    # @!attribute api_name
    # @return [String] defaults to "Api Documentation"
    add_setting :api_name, :default => "Api Documentation"

    # @!attribute include_bootstrap
    # @return [Boolean] defaults to true
    add_setting :include_bootstrap, :default => true

    # @!attribute external_css
    # @return [Array] array of Strings, defaults to []
    add_setting :external_css, :default => []

    # @!attribute url_prefix
    # @return [String] defaults to nil
    add_setting :url_prefix, :default => nil

    private

    def settings
      @settings ||= {}
    end
  end
end
