# Before sending the query, replace xhr data with current checkbox and checked
# status.
$(document).on 'ajax:beforeSend', 'input[type=checkbox][data-remote=true]', (e) ->
  options = e.detail[1]

  remove = !e.target.checked

  # Replace any existing params.
  options.data = $.param(selections: { profile_ids: [e.target.value], remove: remove })
