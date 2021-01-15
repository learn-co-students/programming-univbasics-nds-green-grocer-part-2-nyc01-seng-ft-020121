require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  cart.each do |item|
    coupons.each do |coupon|
      if item[:item] == coupon[:item] && item[:count] >= coupon[:num]
        if item[:count] % coupon[:num] == 0
          couponed_item = {}
          couponed_item[:item] = "#{item[:item]} W/COUPON"
          couponed_item[:count] = coupon[:num]
          couponed_item[:price] = (coupon[:cost] / coupon[:num])
          couponed_item[:clearance] = item[:clearance]
          item[:count] -= coupon[:num]
          cart << couponed_item
        elsif item[:count] % coupon[:num] != 0 
          couponed_item = {}
          couponed_item[:item] = "#{item[:item]} W/COUPON"
          couponed_item[:count] = item[:count] - item[:count] % coupon[:num]
          couponed_item[:price] = coupon[:cost] / coupon[:num]
          couponed_item[:clearance] = item[:clearance]
          item[:count] -= couponed_item[:count]
          cart << couponed_item
        end 
      end
    end 
  end 
  cart 
end

def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance]
      item[:price] -= item[:price] / 5
    end
  end
  cart
end

def checkout(cart, coupons)
  sorted_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(sorted_cart, coupons)
  discounted_cart = apply_clearance(couponed_cart)
  total = 0
  discounted_cart.each do |item|
    total += item[:price] * item[:count]
  end 
  if total > 100 
    total -= total / 10 
  end
  total
end
