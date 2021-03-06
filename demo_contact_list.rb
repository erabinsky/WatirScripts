require 'watir'
require 'json'
require 'csv'

#Write as function



def sendMessage()

    browser = Watir::Browser.new
    browser.goto('linkedin.com')
    file = File.read("/Users/ezrarabinsky/Code/LinkedIn/login.json")
    user_hash = JSON.parse(file)
    username = user_hash["username"]
    password = user_hash["password"]
    table = CSV.parse(File.read("/Users/ezrarabinsky/Code/LinkedIn/rubydemolinkedin.csv", headers: true))


    #Signing In
    browser.text_field(name: "session_key").send_keys("#{username}")
    browser.text_field(name: "session_password").send_keys("#{password}")
    browser.button(aria_label: "i18n_sign-in").click

    CSV.foreach('../LinkedIn/rubydemolinkedin.csv', headers: true) do |row|
        
    
        # row[0]: Last Name, row[1]: First Name, row[2]: Middle Name, row[3]: Nickname
        
        #Search
        browser.text_field(aria_label: "Search").send_keys("#{row[1]} #{row[2] === nil ? nil : row[2]} #{row[3] === nil ? nil : row[3]} #{row[0]}")
        browser.button(data_control_name: "nav.search_button").click

        #Select First Search Result
        browser.a(class: "search-result__result-link", index: 0).click
        browser.button(class: "pv-s-profile-actions--message", index: 0).click

        #Write Subject and Message Body
        
        browser.div(aria_label: "Write a message…").send_keys("Hi, #{row[3] === nil ? row[1] : row[3] }! If you're reading this, odds are my script worked! Here's a link to the repo: https://github.com/erabinsky/WatirScripts\n\nI'd love to hear your feedback as well as maybe collaborate on some future projects together. Hit me up on Calendly and let's find a time to catch up!\n(https://calendly.com/ezra-rabinsky/code-challenge-follow-up)")
        
        
        #Send
        browser.button(data_control_name: "send").click

        browser.button(data_control_name: "overlay.close_conversation_window").click

    end
    
    
end
sendMessage()