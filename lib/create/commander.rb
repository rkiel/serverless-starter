require 'optparse'
require 'ostruct'
require 'json'


module Create

  class Commander

    attr_accessor :options

    def initialize (argv)
      @options = OpenStruct.new
      options.debug = false
      options.template = "aws-nodejs"

      @option_parser = OptionParser.new do |op|
        op.banner = "Usage: create options"

        op.on('-p','--projects PROJECTS_DIR') do |argument|
          options.projects = argument
        end

        op.on('-n','--name PROJECT_NAME') do |argument|
          options.name = argument
        end

        op.on('-t','--template TEMPLATE') do |argument|
          options.template = argument
        end

        op.on_tail('-h','--help') do |argument|
          puts op
          exit
        end
      end

      @option_parser.parse!(argv)
      options.terms = argv # must be after parse!
    end

    def valid?
      result = false
      if options.projects and options.name
        if Dir.exist? options.projects
          file_path = File.join(options.projects,options.name)
          if Dir.exist?(file_path) or File.exist?(file_path)
            log "ERROR: #{file_path} already exists"
          else
            result = true
          end
        else
          log "ERROR: #{options.projects} is not a directory"
        end
      end
      result
    end

    def help
      log
      puts @option_parser
      exit
    end

    def execute
      run_command "npm install"

      file_path = File.join(options.projects,options.name)
      run_command "mdir -p #{file_path}"
      run_command "rm -rf #{File.join('.', options.name)}"
      run_command "npm run serverless -- create --template #{options.template} --path #{options.name} "
      run_command "mv #{options.name} #{options.projects}"
      Dir.chdir(file_path) do
        run_command "npm init -y"
        run_command "npm install --save serverless"

        json = JSON.parse(File.read("package.json"))
        json['scripts']['serverless'] = 'serverless'
        json['scripts']['sls'] = 'sls'
        File.write("package.json", JSON.pretty_generate(json))
        
        run_command "git init"
        run_command "git add ."
        run_command "git commit -m 'Initial commit'"
      end
    end

  private

    def log (msg = "")
      puts msg.gsub(Regexp.new(ENV['HOME']), '~')
    end

    def run_command (cmd)
      log cmd
      system cmd
    end

  end # class

  end # module
