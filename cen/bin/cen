#!/usr/bin/env ruby
# cen.rb - information on students

require "net/http"

# This wonderful code taken from http://github.com/michaeldv/awesome_print.
class String
    [:gray, :red, :green, :yellow, :blue, :purple, :cyan, :white].each_with_index do |color, i|
        define_method color          do "\033[1;#{30+i}m#{self}\033[0m" end
        define_method :"#{color}ish" do "\033[0;#{30+i}m#{self}\033[0m" end
    end
end

class Person    
    def initialize(mat_number)
        if mat_number[0].chr != "s"
            mat_number = "s" + mat_number
        end
        
        @data = {:matric => mat_number}
        
        myed = myed_search(mat_number)
        finger = finger_search(mat_number)
        ldap = ldap_search(mat_number)
        
        # If we find anything then jobs a gudun'.
        if (myed or finger or ldap)
            @valid = true
        else
            @valid = false
        end
    end
    
    def valid?
        @valid
    end
    
    def myed_search(mat_number)
        page = 'http://www.ed.ac.uk/search/student-results?name=' + mat_number
        url = URI.parse(page)

        Net::HTTP.start(url.host, url.port) do |http|
        	req = http.get '/search/student-results?name=' + mat_number 
        	@body = req.body
        end

        re = /mailto:(([^@]*)@[^\"]*).*<TD> (.*) <\/TD>/mi
        
        unless re.match(@body)
            return false
        end
        
        matches = re.match(@body)
        @data[:name] = matches[2].split("-").first
        @data[:email] = matches[1]
        
        # Make strange characters that appear in course names appear nice and
        # pretty when printed.
        course_year = matches[3].gsub(/&amp;/, " & ").gsub(/\//, " / ").split
        @data[:year] = course_year.pop        
        @data[:course] = course_year.map { |w| w.capitalize }.join " "
        
        return true
    end
    
    def finger_search(mat_number)
        output = `finger #{mat_number} 2>&1`
        re = { :matric => /Login: (s\d*)/,
               :name => /Name: ([\w -]*)/ }
        error = /no such user/
        
        if error.match(output)
            return false
        end
        
        re.each do |name, regex|
            @data[name] = regex.match(output)[1]
        end
        
        return true
    end
    
    def ldap_search(mat_number)
        output = `ldapsearch -Q "uid=#{mat_number}"`
        re = { :email => /mail: (\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b)/,
               :shell => /loginShell: (\S*)/,
               #:year => /year-[\w]*(\d)/,
               :name => /cn: ([\w -]+)/ }
        success = /numEntries:/
        
        unless success.match(output)
            return false
        end
        
        re.each do |name, regex|
            @data[name] = regex.match(output)[1]
        end
        
        return true
    end
    
    def to_s
        output = ""
        output << "==" << @data[:matric].cyan << "=" * (18-@data[:matric].length) << "\n"
        
        # Make 'Name' always appear at the top
        output << "Name: ".yellow << @data[:name].blue << "\n"
        @data.delete :name

        @data.each do |name, value|
            output << name.to_s.capitalize.yellowish << ": ".green << value.blueish << "\n"
        end
        
        output << "=" * 20 << "\n"
        return output
    end
end

if __FILE__ == $0
    # Display help
    if ARGV.length == 0 or ARGV[0] == '-h' or ARGV[0] == '--help'
        puts 'usage: cen [-h | --help] <MATRIC LIST>'
        exit
    end

    ARGV.each do |matric|
        # Wildcard search
        if matric.include? '*'
            (0..9).each do |i|
                new_matric = matric.sub(/\*/, i.to_s)
                search = Person.new(new_matric)

                if search.valid?
                    puts search.to_s
                else
                    puts "No information found for " + new_matric.cyan + "."
                end
            end
        else
            search = Person.new(matric)
        
            if search.valid?
                puts search.to_s
            else
                puts "No information found for " + matric.cyan + "."
            end
        end
    end
end
