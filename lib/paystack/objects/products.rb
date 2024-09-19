require 'paystack/objects/base.rb'


class PaystackProducts < PaystackBaseObject

  def create(data={})
    return PaystackProducts.create(@paystack, data)
  end

  def list(page=1)
    return PaystackProducts.list(@paystack, page)
  end

  def get(product_id)
		return PaystackProducts.get(@paystack, product_id)
	end

  def update(product_id, data={})
		return PaystackProducts.update(@paystack, product_id,  data)
	end


  def PaystackProducts.update(paystackObj, product_id, data)
		initPutRequest(paystackObj,"#{API::PRODUCT_PATH}/#{product_id}",  data)
	end


  def PaystackProducts.create(paystackObj, data={})
    initPostRequest(paystackObj, "#{API::PRODUCT_PATH}", data, true)
  end

  def PaystackProducts.list(paystackObj, page=1)
    initGetRequest(paystackObj, "#{API::PRODUCT_PATH}/?page=#{page}")
  end
end