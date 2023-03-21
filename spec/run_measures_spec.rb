require "open3"
require "json"
require "openstudio"
require "parallel"
require "fileutils"

def get_clean_env
  new_env = {}
  new_env["BUNDLER_ORIG_MANPATH"] = nil
  new_env["BUNDLER_ORIG_PATH"] = nil
  new_env["BUNDLER_VERSION"] = nil
  new_env["BUNDLE_BIN_PATH"] = nil
  new_env["RUBYLIB"] = nil
  new_env["RUBYOPT"] = nil
  new_env["GEM_PATH"] = nil
  new_env["GEM_HOME"] = nil
  new_env["BUNDLE_GEMFILE"] = nil
  new_env["BUNDLE_PATH"] = nil
  new_env["BUNDLE_WITHOUT"] = nil

  return new_env
end

RSpec.describe OSC do

  all_measures = Dir.glob("./measures/*/measure.rb")

  it "can test all the measures" do
    if !all_measures.empty?
      command = "#{OpenStudio.getOpenStudioCLI} measure -r ./measures"
      #puts command
      out, err, ps = Open3.capture3(get_clean_env, command)
      if !ps.success?
        puts "#{command} failed:\n\t#{out}\n\t#{err}\n"
      end
      expect(ps.success?).to eq(true)
    end
  end

end

