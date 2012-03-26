require 'irb/completion'
IRB.conf[:AUTO_INDENT]=true

# Taken from https://gist.github.com/917284
require 'rubygems'

@irb_extensions = []

def require_for_irb_with_fallback_for_bundler_constraints(gem_name, load_file = nil)
  load_file ||= gem_name
  begin
    begin
      require load_file
    rescue LoadError => e
      gem_paths = []
      Gem.path.each do |sys_gem_path|
        Dir[sys_gem_path + '/gems/*'].each do |gem_path|
          gem_paths << gem_path if %r{#{gem_name}} =~ gem_path
        end
      end

      if gem_paths.empty?
        error = LoadError.new("It seems like #{gem_name} is not installed.")
        class << error; def skip_backtrace?; true; end; end
        raise error
      end

      load_path = gem_paths.sort_by(&:to_s).last + "/lib/#{load_file}.rb"

      load load_path
    end

    yield if block_given?

    @irb_extensions << gem_name
  rescue Exception => err
    msg = "Couldn't load #{gem_name}: #{err}"
    msg << "\n#{err.backtrace[0..10].join("\n")}" unless err.respond_to?(:skip_backtrace?) && err.skip_backtrace?
    warn msg
  end
end

require_for_irb_with_fallback_for_bundler_constraints 'awesome_print', 'ap' do
  
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
end