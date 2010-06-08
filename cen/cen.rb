#!/usr/bin/env ruby

class Person
    attr_accessor :name, :mat_number :email, :year, :course, :location
    
    def initialize(mat_number)
        @mat_number = mat_number
        
        @myed_search mat_number
        @finger_search mat_number
    end
    
    
    def myed_search(mat_number)
        page = 'http://www.ed.ac.uk/search/student-results?name=' + mat_number
        url = URI.parse(page)

        Net::HTTP.start(url.host, url.port) do |http|
        	req = http.get '/search/student-results?name=' + mat_number 
        	$body = req.body
        end

        re = /mailto:([\w\._%-]+)@[\w\.-]+\.[a-zA-Z]{2,4}">[\w\._%-]+@[\w\.-]+\.[a-zA-Z]{2,4}.*(s\d{7})@sms <\/TD><TD> ([\w\s]*)</mi
        
    end
    
end

require 'net/http'

mat_number = ARGV[0]

page = 'http://www.ed.ac.uk/search/student-results?name=' + mat_number
url = URI.parse(page)

Net::HTTP.start(url.host, url.port) do |http|
	req = http.get '/search/student-results?name=' + mat_number 
	$body = req.body
end

re = /mailto:([\w\._%-]+)@[\w\.-]+\.[a-zA-Z]{2,4}">[\w\._%-]+@[\w\.-]+\.[a-zA-Z]{2,4}.*(s\d{7})@sms <\/TD><TD> ([\w\s]*)</mi

name = re.match($body)[1].split('-').first
email = mat_number + '@sms.ed.ac.uk'
year = re.match($body)[3].split.last
course = re.match($body)[3].split
course.pop
course = course.join ' '

puts 'Name: ' + name
puts 'Email: ' + email
puts 'Year: ' + year
puts 'Course: ' + course.capitalize
