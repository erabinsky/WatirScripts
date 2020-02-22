require 'watir'
require 'json'

#Write as function



def sendMessage()

    puts "Who are you trying to connect with?(first name):"
    connect_first_name = gets.chomp!

    puts "Last name?"
    connect_last_name = gets.chomp!

    puts "If they have a nickname, please enter it-- otherwise, just hit enter!"
    connect_nickname = gets.chomp

    $browser = Watir::Browser.new
    $browser.goto('linkedin.com')
    file = File.read("/Users/ezrarabinsky/Code/LinkedIn/login.json")
    user_hash = JSON.parse(file)
    $username = user_hash["username"]
    $password = user_hash["password"]


    #Signing In
    
    $browser.text_field(name: "session_key").send_keys("#{$username}")
    $browser.text_field(name: "session_password").send_keys("#{$password}")
    $browser.button(aria_label: "i18n_sign-in").click

    #Search
    $browser.text_field(aria_label: "Search").send_keys("#{connect_first_name} #{connect_nickname} #{connect_last_name}")
    $browser.button(data_control_name: "nav.search_button").click

    #Select First Search Result
    $browser.a(class: "search-result__result-link", index: 0).click
    #Open New Message
    $browser.a(class: "message-anywhere-button", index: 0).click

    #Write Subject and Message Body
    $browser.text_field(name: "subject").send_keys("Coding Challenge A C C E P T E D")
    $browser.div(class: "msg-form__contenteditable", index: 0).send_keys("Hi, #{connect_nickname === "" ? connect_first_name : connect_nickname }! If you're reading this, odds are my script worked! I'd love to hear your feedback as well as maybe collaborate on some future projects together. Hit me up on Calendly and let's find a time to catch up!\n(https://calendly.com/ezra-rabinsky/code-challenge-follow-up)")

    
    gets
    #Send
    #$browser.button(data_control_name: "send").click
end
sendMessage()







