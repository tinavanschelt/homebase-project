require "capybara/rspec"
require "selenium/webdriver"

if ENV["GOOGLE_CHROME_SHIM"].present?
  Selenium::WebDriver::Chrome.path = ENV["GOOGLE_CHROME_SHIM"]
end

options = Selenium::WebDriver::Chrome::Options.new
options.add_preference(
  :download,
  prompt_for_download: false,
  default_directory: Rails.root.join("tmp", "downloads")
)
options.add_preference(
  :browser,
  set_download_behavior: { behavior: "allow" }
)

Capybara.register_driver(:chrome) do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    loggingPrefs: {
      browser: "ALL"
    }
  )
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    desired_capabilities: capabilities
  )
end

Capybara.register_driver(:headless_chrome) do |app|
  options.add_argument("--headless")
  options.add_argument("--window-size=1024,768")
  options.add_argument("--disable-gpu")
  options.add_argument("--disable-dev-shm-usage")

  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    loggingPrefs: {
      browser: "ALL"
    },
    chromeOptions: {
      w3c: false
    }
  )

  driver = Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    desired_capabilities: capabilities
  )

  ### Allow file downloads in Google Chrome when headless!!!
  ### https://bugs.chromium.org/p/chromium/issues/detail?id=696481#c89
  bridge = driver.browser.send(:bridge)

  path = "/session/:session_id/chromium/send_command"
  path[":session_id"] = bridge.session_id

  bridge.http.call(
    :post,
    path,
    cmd: "Page.setDownloadBehavior",
    params: {
      behavior: "allow",
      downloadPath: Rails.root.join("tmp", "downloads")
    }
  )
  ###

  driver
end

Capybara.javascript_driver = ENV["HEAD"].present? ? :chrome : :headless_chrome
Capybara.default_driver = Capybara.javascript_driver

Capybara.default_host = "http://localhost:#{ENV['PORT'] || 3000}"
Capybara.asset_host = "http://localhost:#{ENV['PORT'] || 3000}"
Capybara.default_max_wait_time = 2
