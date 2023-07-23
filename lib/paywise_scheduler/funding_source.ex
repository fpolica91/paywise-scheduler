defmodule PaywiseScheduler.FundingSource do

  def get_funding_souce(customer_id) do
    url = "https://api-sandbox.dwolla.com/customers/#{{customer_id}}/funding-sources"
    HTTPoison.post(url)
  end


end