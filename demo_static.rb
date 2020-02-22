require 'watir'
require 'json'

#Write as function



def sendMessage()

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
    browser.text_field(aria_label: "Search").send_keys("Michael 'Fritz' Fritzius")
    browser.button(data_control_name: "nav.search_button").click

    #Select First Search Result
    browser.a(class: "search-result__result-link", index: 0).click
    #Open New Message
    browser.a(class: "message-anywhere-button", index: 0).click

    #Write Subject and Message Body
    browser.text_field(name: "subject").send_keys("Coding Challenge A C C E P T E D")
    browser.div(class: "msg-form__contenteditable", index: 0).send_keys("Hi, Fritz! If you're reading this, odds are my script worked! Here's a link to the repo: https://github.com/erabinsky/WatirScripts\n\nI'd love to hear your feedback as well as maybe collaborate on some future projects together. Hit me up on Calendly and let's find a time to catch up!\n(https://calendly.com/ezra-rabinsky/code-challenge-follow-up)")

    

    #Send
    browser.button(data_control_name: "send").click
end
sendMessage()