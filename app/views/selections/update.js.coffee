# Appends a notification with the current number of selected profiles.
$('#notifications')
  .html('<%= render_notification(:notice, t('.selected_profiles', count: selected_profiles.size)) %>')
