from contextlib import contextmanager
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support.expected_conditions import staleness_of

@contextmanager
def wait_for_page_load(timeout=30):
  print("Loading New Page")
  old_page = driver.find_element_by_tag_name('html')
  yield WebDriverWait(driver, timeout).until(
    staleness_of(old_page)
  )

driver = webdriver.Chrome()
driver.get("https://www.google.com/")
elem = driver.find_element_by_name("q")
elem.send_keys("helloworld")

with wait_for_page_load(timeout=10):
  driver.find_element_by_link_text('History')


driver = webdriver.Chrome()
driver.get("https://internet-banking.dbs.com.sg/IB/Welcome")

assert "iBanking" in driver.title
elem = driver.find_element_by_name("UID")
elem.clear()
elem.send_keys("xxroboticxx123")
elem.send_keys(Keys.TAB)

with wait_for_page_load(timeout=10):
  driver.find_element_by_link_text('page')


driver.close()
>>>

https://backend.safeentry-qr.gov.sg/api/v1/nearbyvenues,https://backend.safeentry-qr.gov.sg/api/v1/entry,12,https://backend.safeentry-qr.gov.sg/api/v1/buildingtenants", InboxMessage.SAFE_ENTRY_SENDER, ResourceHubItemObject.API_TYPE_NORMAL, ResourceHubItemObject.RESPONSE_TYPE_CHECKIN_CHECKOUT, C8736i.m34733W(C11355d.f26217a), null);