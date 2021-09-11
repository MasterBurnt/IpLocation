#!/usr/bin/ruby 
#
# @name   : IpLocation
# @url    : http://github.com/MasterBurnt
# @author : MasterBurnt 


#Library 
require 'httparty'

#color 
class String
def red;            "\e[31m#{self}\e[0m" end
def green;          "\e[32m#{self}\e[0m" end
def yellow;          "\e[33m#{self}\e[0m" end
def blue;           "\e[34m#{self}\e[0m" end
def magenta;        "\e[35m#{self}\e[0m" end
def cyan;           "\e[36m#{self}\e[0m" end
end

#banner
def bannner
    system('clear')
    puts """
        _ ___  _    ____ ____ ____ ___ _ ____ _  _ 
        | |__] |    |  | |    |__|  |  | |  | |\\ | 
        | |    |___ |__| |___ |  |  |  | |__| | \\|
    """.magenta
end

#api
apilist =['http://ip-api.com/json/',
'http://ip-api.com/xml/',
'http://ip-api.com/line/',
'http://ip-api.com/csv/',
'http://ip-api.com/php/'
         ]

#Status
stat = true

#Options
while stat
    bannner()
    puts """
        name   : IpLocation
        url    : http://github.com/MasterBurnt
        author : MasterBurnt

"""
   puts "[+] Please enter the target IP <enter for yourself> :".yellow
    ip = gets.chomp
    puts """
[1] Save information as json
[2] Save information as xml
[3] Save information as Newline 
[4] Save information as csv 
[5] Save information as php
[0] Exit!
""".green

puts "[?] Select the desired option :".yellow
    api = gets.chomp
    if api == "1"
        api = apilist[0]+ip
        suffix = ".json"
        stat = false
    elsif api == "2"
        api = apilist[1]+ip
        suffix = ".xml"
        stat = false
    elsif api == "3"
        api = apilist[2]+ip
        suffix = ".txt"
        stat = false
    elsif api == "4"
        api = apilist[3]+ip
        suffix = ".csv"
        stat = false
    elsif api == "5"
        api = apilist[4]+ip
        suffix = ".php"
        stat = false
        
    elsif api == "0"
        puts "$Good luck =)".cyan
        exit 0
    else
        puts "[!] Option out of range".red
        sleep(3)
    end 
end 

#request
begin
    response = HTTParty.get(api,timeout: 5)
rescue
    system('clear')
    puts "[!] Please check your internet connection!".red
    exit 1
end
ok = response.body if response.code == 200
 
#saved
begin
    Dir.mkdir('History')
    Dir.chdir('History')
rescue 
    Dir.chdir('History')
end 

puts "[?] Please choose a name for storage : ".yellow
filename = gets.chomp+suffix
f = File.open(filename,"wt")
f.write ok
f.close
puts """
 +The file was saved as #{filename} in History folder+""".blue
