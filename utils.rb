def finish(msg)
  puts msg
  exit 1
end

class Runner
  def initialize(dir, files)
    @dir   = dir
    @files = files
  end

  def run_part(part)
    file_name = "part_#{part}.rb"
    path = File.join(@dir, file_name)

    return puts "No file #{path}" unless @files.include? file_name

    run_with_input(path, 'Test', 'test_input')
    run_with_input(path, 'Real', 'input')
  end

  def run_with_input(path, title, file_name)
    print "- #{title} data result: "

    if @files.include? file_name
      input = File.join('.', @dir, file_name)
      output = `ruby #{path} #{input}`
      puts output
    else
      puts "No '#{file_name}' file"
    end
  end
end
