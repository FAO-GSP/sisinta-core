# Sisinta global exports. See
# https://robots.thoughtbot.com/module-pattern-in-javascript-and-coffeescript
window.Sisinta = {}

# Initialize bootstrap plugin for file-inputs.
$(document).on 'turbolinks:load', ->
  bsCustomFileInput.init()
