require 'paystack/objects/base.rb'


class PaystackPaymentPages < PaystackBaseObject

  def create(data={})
    return PaystackPaymentPages.create(@paystack, data)
  end

  def list(page=1)
    return PaystackPaymentPages.list(@paystack, page)
  end

  def get(payment_page_id)
		return PaystackPaymentPages.get(@paystack, payment_page_id)
	end

  def update(payment_page_id, data={})
		return PaystackPaymentPages.update(@paystack, payment_page_id,  data)
	end

  def add_products(payment_page_id, data={})
    return PaystackPaymentPages.add_products(@paystack, payment_page_id, data)
  end
  

  def PaystackPaymentPages.update(paystackObj, payment_page_id, data)
		initPutRequest(paystackObj,"#{API::PAYMENT_PAGE_PATH}/#{payment_page_id}",  data)
	end

  def PaystackPaymentPages.add_products(paystackObj, payment_page_id, data)
    initPostRequest(paystackObj,"#{API::PAYMENT_PAGE_PATH}/#{payment_page_id}/product", data)
  end

  def PaystackPaymentPages.get(paystackObj, payment_page_id)
    initGetRequest(paystackObj, "#{API::PAYMENT_PAGE_PATH}/#{payment_page_id}")
  end

  def PaystackPaymentPages.create(paystackObj, data={})
    initPostRequest(paystackObj, "#{API::PAYMENT_PAGE_PATH}", data, true)
  end

  def PaystackPaymentPages.list(paystackObj, page=1)
    initGetRequest(paystackObj, "#{API::PAYMENT_PAGE_PATH}/?page=#{page}")
  end
end