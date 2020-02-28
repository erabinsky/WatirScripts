require 'watir'
require 'json'

#Write as function



def sendMessage()

    puts "Please type in the full name of the person who you are looking to message, then press ENTER:"
    full_name = gets.chomp!

    puts "\n\nWould you like to address this person by a name other than their first (e.g. nickname. formal address)? If yes, please type it here then press ENTER\nOtherwise, just hit ENTER!"
    nickname = gets.chomp!


    # Single or Hyphenated First Names
    first_name = full_name.match(/([\w](\-\w+)?)+\b/)


    browser = Watir::Browser.new
    browser.goto('linkedin.com')
    file = File.read("/Users/ezrarabinsky/Code/LinkedIn/login.json")
    user_hash = JSON.parse(file)
    username = user_hash["username"]
    password = user_hash["password"]


    #Signing In
    
    browser.text_field(name: "session_key").send_keys("#{username}")
    browser.text_field(name: "session_password").send_keys("#{password}")
    browser.button(aria_label: "i18n_sign-in").click

    #Search
    browser.text_field(aria_label: "Search").send_keys("#{full_name}") 
    browser.button(data_control_name: "nav.search_button").click

    #Select First Search Result
    browser.a(class: "search-result__result-link", index: 0).click
    #Open New Message
    browser.button(class: "pv-s-profile-actions--message", index: 0).click

    #Write Subject and Message Body

    browser.div(aria_label: "Write a message…").send_keys("Hi, #{nickname === "" ? first_name : nickname}! I'm glad we were able to connect. If you're reading this, odds are my script worked! Here's a link to the repo: https://github.com/erabinsky/WatirScripts\n\nI'd love to hear your feedback as well as maybe collaborate on some future projects together. Hit me up on Calendly and let's find a time to catch up!\n(https://calendly.com/ezra-rabinsky/code-challenge-follow-up)") 

    

    # Send
    browser.button(data_control_name: "send").click
end
sendMessage()








