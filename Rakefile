require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = '--exclude-pattern \'spec/**/*suite_spec.rb\''
end

task default: :spec

desc "Update Measures"
task :update_measures do
  puts "Updating Measures"

  require "openstudio"
  require "open3"

  cli = OpenStudio.getOpenStudioCLI
  command = "#{cli} measure -t './measures'"
  puts command
  out, err, ps = Open3.capture3({"BUNDLE_GEMFILE"=>nil}, command)
  raise "Failed to update measures\n\n#{out}\n\n#{err}" unless ps.success?
end

desc "Update Models"
task :update_models do
  puts "Updating Models"

  measure_src_dirs = ["./measures/"]
  $LOAD_PATH.each do |load_path|
    if load_path.include?("openstudio-common-measures")
      measure_src_dirs << File.join(load_path, "measures/")
    elsif load_path.include?("openstudio-model-articulation")
      measure_src_dirs << File.join(load_path, "measures/")
    end
  end

  Dir.glob("./models/*/measures/*").each do |measure_path|
    measure_dir_name = File.basename(measure_path)
    measure_src_dirs.each do |src_dir|
      src_path = File.join(src_dir, measure_dir_name)
      if File.directory?(src_path)
        puts "Updating #{measure_path} with #{src_path}"
        FileUtils.rm_rf(measure_path)
        FileUtils.cp_r(src_path, measure_path)
        next
      end
    end
  end

end
task :update_models => [:update_measures]

# default spec test depends on updating measure and library files
task :spec => [:update_models]
