# Appends a notification with the current number of selected profiles.
notification = '<%= notification_hash(:notice, t('.selected_profiles', count: selected_profiles.size)).to_json.html_safe %>'

Sisinta.notifications.notify JSON.parse(notification)
