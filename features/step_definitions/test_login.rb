require 'selenium-webdriver'
driver = Selenium::WebDriver.for :chrome
driver.manage.window.maximize
wait = Selenium::WebDriver::Wait.new(:timeout => 15)
driver.navigate.to "http://automationpractice.com/"
uname = 'user email'   #put valid email here
pwd = 'user password'  #put valid password here


#This function for login with valid credential
Given (/^I open login page/) do
  driver.find_element(:xpath,'//*[@id="header"]/div[2]/div/div/nav/div[1]/a').click
  sleep(3)
end

When(/^I put validated account/) do
  input = wait.until {
    element = driver.find_element(name:"email")
    element if element.displayed?
}
input.send_keys (uname)

  input = wait.until {
    element = driver.find_element(name:"passwd")
    element if element.displayed?
}
input.send_keys (pwd)
end

And (/^I submit/) do
    driver.find_element(:id,'SubmitLogin').click
end

Then(/^I can logout/) do
  if element = driver.find_element(:class=>"logout")
    element.displayed?
    element.click
  else
    screenshot_file = "_#{Time.now.strftime('%Y-%m-%d %H-%M-%S')}.png"
    driver.save_screenshot ('E:\QA\screenshots\failed'+ screenshot_file +'')
  end
end


#This function for login with invalid credential
When(/^I put (.*) into email field/) do |username|
  input = wait.until {
    element = driver.find_element(name:"email")
    element if element.displayed?
}
  input.clear
  input.send_keys (username)
end

And (/^I put (.*) into password field/) do |password|
  input = wait.until {
    element = driver.find_element(name:"passwd")
    element if element.displayed?
}
  input.clear
  input.send_keys (password)
end

Then (/^I see alert/) do
  input = wait.until {
    element = driver.find_element(:xpath,'//*[@id="center_column"]/div[1]/p')
      if element
        puts "success"
      else
        puts "failed"
      end
    element if element.displayed?
}
        puts "Test passed"
end

After do |scenario|
  if scenario.failed?
    screenshot_file = "_#{Time.now.strftime('%Y-%m-%d %H-%M-%S')}.png"
    driver.save_screenshot ('E:\QA\screenshots\failed'+ screenshot_file +'')
  end
end
