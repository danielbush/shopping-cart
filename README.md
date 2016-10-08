# Shopping Cart

## Synopsis

    rspec

For the 4 scenarios:

    rspec spec/acceptance_spec

## Some notes...

* `spec/acceptance_spec.rb` has the 4 scenarios
* `ShoppingCart` is passed a "factory" which determines which pricing
  rules manager to use (`PricingRulesFactory#pricing_rules`).  If we
  want to use a different one (eg a rule engine etc) we just have to
  change what this factory provides.
* `PricingRulesManager` is a rule manager that allows us to
  add code-based rules; we can add rules using blocks, although
  blocks are not quite like lambdas.
* `ShoppingCart` provides the rules manager with its items and
  the rules manager may return one or more (line) items to
  be added to teh cart.
* We make some assumptions about product objects - mainly
  that they quack like products.  Other than that, this library
  doesn't care.

And some issues...

* `ShoppingCart` has a concept of "line items" ie `ShoppingCart#items`.
  At the moment these are just hashes.
  But it might make sense to make these real objects like products.
* Not sure best way to handle numeric calculations - ended
  up just rounding the total.  Other options might be using cents
  instead of dollars, or using some sort of decimal implementation.
