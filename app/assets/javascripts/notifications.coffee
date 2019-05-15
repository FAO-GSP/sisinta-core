# Prepare and trigger notifications and alerts.

# Namespaced exports.
Notifications = {}
Sisinta.notifications = Notifications

# Preconfigured function to display notifications.
Notifications.notify = (notification) ->
  $.notify({
    icon: 'fa fa-exclamation'
    title: notification.title
    message: notification.message
  },{
    type: notification.type
    placement: {
      from: 'bottom'
      align: 'right'
    },
    width: '20rem'
    delay: 5000
    url_target: '_blank',
    mouse_over: 'pause',
    animate: {
      enter: 'animated fadeInUp',
      exit: 'animated fadeOutDown'
    },
    template: '' +
      '<div data-notify="container" class="alert alert-{0}" role="alert">' +
        '<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
        '<span data-notify="icon"></span> ' +
        '<span data-notify="title">{1}</span> ' +
        '<span data-notify="message" class="ml-1 w-100">{2}</span>' +
        '<div class="progress" data-notify="progressbar">' +
          '<div class="progress-bar progress-bar-{0}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>' +
        '</div>' +
        '<a href="{3}" target="{4}" data-notify="url"></a>' +
      '</div>'
  })

# On load, search prerendered notifications and display them.
$(document).on 'turbolinks:load', ->
  notifications = JSON.parse $('#notifications').html()

  Notifications.notify n for n in notifications
