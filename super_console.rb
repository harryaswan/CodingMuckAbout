require 'io/console'

class SuperConsole

    def initialize()
        @current_command = ''
        @command_log = []
        @curr_log_idx = 0
        @running = true
    end

    def start()
        # x, y = $stdout.winsize()
        # puts "Window Size: #{x} by #{y}"

        while @running
            current_command()
            c = read_char()
            check_char(c)
            current_command()
        end
    end

    def read_char()
      STDIN.echo = false
      STDIN.raw!
      input = STDIN.getc.chr
      if input == "\e" then
        input << STDIN.read_nonblock(3) rescue nil
        input << STDIN.read_nonblock(2) rescue nil
      end
    ensure
      STDIN.echo = true
      STDIN.cooked!
      return input
    end

    def check_char(c)
        case c
        when "\r"
            run_command()
        when "\e[A"
            @current_command = view_log()
        when "\e[B"
            @current_command = view_log(false)
        when "\177"
            @current_command = @current_command[0...-1]
        when "\u0003"
            cmd_exit_app()
        when /^.$/
          @current_command << c
        else
          puts "SOMETHING ELSE: #{c.inspect}"
        end
    end

    def current_command()
        print ">" + " "*20 + "\r"
        $stdout.flush
        print "> " + @current_command + "\r"
        $stdout.flush
    end

    def view_log(prev=true)
        prev ? @curr_log_idx -= 1 : @curr_log_idx += 1
        @curr_log_idx = 0 if @curr_log_idx < 0
        if @curr_log_idx >= @command_log.length
            @curr_log_idx = @command_log.length - 1
            return ""
        end
        return "#{@command_log[@curr_log_idx]}"
    end

    def log_command()
        @command_log << @current_command if @current_command != ""
        @current_command = ""
        @curr_log_idx = @command_log.length
    end

    def run_command()
        print "\n"
        case(@current_command)
        when "help"
            cmd_print_help()
        when "exit"
            cmd_exit_app()
        when "other stuff"
            cmd_other_stuff()
        else
            puts "'#{@current_command}' is not recognised command..."
            cmd_print_help()
        end
        log_command()
    end

    def cmd_print_help()
        puts "Helping time"
        puts "help          : prints this menu"
        puts "exit          : closes the program"
        puts "other stuff   : does other stuff"
    end

    def cmd_exit_app()
        @running = false;
    end

    def cmd_other_stuff()
        10.times {puts "Look other stuff"; sleep 0.1}
    end

end

sc = SuperConsole.new()
sc.start()




# when " "
#   puts "SPACE"
# when "\t"
#   puts "TAB"
# when "\n"
#     puts "LINE FEED"
# when "\e"
#     puts "ESCAPE"
# when "\e[C"
#     puts "RIGHT ARROW"
# when "\e[D"
#     puts "LEFT ARROW"
# when "\004"
#     puts "DELETE"
# when "\e[3~"
#     puts "ALTERNATE DELETE"
