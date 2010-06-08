#!/usr/bin/env ruby

class Printer
    attr_accessor :name, :floor, :colour 
    
    def initialize(name, floor)
       @name = name
       @floor = floor
       @colour = (not (name =~ /c$/).nil?)
    end
    
  public  
    def print(filename, copies = 1)
        if copies == 1
            copies_str = ""
            copies_arg = ""
        elsif copies > 1
            copies_str = " " + copies.to_s + " times"
            copies_arg = " -#  #{copies} "
        else
            puts "You can't print " + filename + " " + copies.to_s.red + " times."
            exit
        end
        
        puts "Printing " + filename.red + copies_str.yellow + " to " + @name.blue + " (Level " + @floor.to_s.green+ ")."
        # output = `lpr -P #{@name} #{copies_arg} #{filename}`.chomp
        
        # return output.empty?
    end
    
    def to_s
        return @name + "[Level " + @floor.to_s + "] (" + @jobs + " jobs)"
    end
    
    def jobs
        status, header, *raw_jobs = `lpq -P #{@name}`.chomp.split "\n"
        
        job_re = /^(\w+)\s*(\w+)\s*(\d+)\s*([\S]+)\s*(\d+)/
        @jobs = []
        
        raw_jobs.each do |job|
            @jobs << { :place    => job_re.match(job)[1],
                      :owner    => job_re.match(job)[2],
                      :id       => job_re.match(job)[3],
                      :filename => job_re.match(job)[4],
                      :size     => job_re.match(job)[5] }
        end
        
        return @jobs
    end

    def score(user_floor)
        floor_diff = (user_floor - @floor).abs
        floor_diff_score = 9 - floor_diff
        
        # 5 jobs = worth moving a floor
        return floor_diff_score - (0.2 * jobs.length)
    end
end

class PrinterManager
    attr_accessor :printers, :needs_colour
    
    def initialize
        @needs_colour = false
        @printers = { 'at3'   => Printer.new('at3', 5),
                      'at14'  => Printer.new('at14', 5),
                      'at13c' => Printer.new('at13c', 5) }
    end
    
    def print(printer, filename, number, user)
        @printers[printer].print(filename, number)
        user.write_job(printer, filename)
    end
    
    def scores(user_floor)
        scores = {}
        printers = {}
        @printers.each_pair do |name, printer|
            if printer.colour == @needs_colour
                printers[name] = printer
            end
        end
        
        printers.each_pair do |name, printer|
            scores[name] = printer.score(user_floor)
        end
        return scores
    end
    
    def abort_last_job(user)
        printer, filename = user.get_last_job
        users_jobs = @printers[printer].jobs.find_all { |job| job[:owner] == user.username.chomp }
        
        if users_jobs.length.zero?
            puts "No job found. It could have already printed. :("
            exit
        end
        
        id = users_jobs.last[:id]
        # output = `lprm -P #{printer} #{id}`
        # return output.empty?
    end
end