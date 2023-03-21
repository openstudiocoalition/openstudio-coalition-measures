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

  # number of processors to use
  nproc = [1, Parallel.processor_count - 2].max

  osws = Dir.glob("./models/*/workflow.osw")

  it "can run all the examples" do
    all_pass = true
    Parallel.each(osws, in_threads: nproc) do |osw|
      osw = File.realpath(osw)
      command = "#{OpenStudio::getOpenStudioCLI} run -w #{osw}"
      #puts command
      out, err, ps = Open3.capture3(get_clean_env, command)
      if !ps.success?
        all_pass = false
        puts "#{command} failed:\n\t#{out}\n\t#{err}\n"
      end
    end
    expect(all_pass).to eq(true)
  end

end
