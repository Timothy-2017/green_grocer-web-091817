require "pry"

def consolidate_cart(cart)
  with_count = {}
  cart.each do |item_hash|
		item_hash.each do |item_key, details_hash|
			if !with_count.has_key?(item_key)
				details_hash[:count] = 1
				with_count[item_key] = details_hash
			else
				with_count[item_key][:count] += 1
			end
		end
  end
	with_count
end

def apply_coupons(cart, coupons)
  # code here
coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {count: 1, price: coupon[:cost], clearance: cart[name][:clearance]}
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
	cart.each do |item_key, details_hash|
		if details_hash[:clearance] == true
			details_hash[:price] = (details_hash[:price] * 0.8).round(2)
		end
	end
  cart
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each do |item_key, details_hash|
    total += details_hash[:price] * details_hash[:count]
  end
  if total > 100
    total *= 0.9
  end
  total
end
