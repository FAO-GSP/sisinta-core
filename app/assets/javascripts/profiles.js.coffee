Profiles =
  tabHeight: 0
Sisinta.profiles = Profiles

$(document).on 'turbolinks:load', ->
  $('#profile-show .tab-pane').each ->
    # Activate the tab so it has a defined height
    $(this).addClass('active')

    height = $(this).height()
    Profiles.tabHeight = if height > Profiles.tabHeight then height else Profiles.tabHeight

    # Deactivate the tab
    $(this).removeClass('active')

  # Activate the first tab and set common height
  $('#profile-show .tab-pane:first').addClass('active')
  $('#profile-show').height(Profiles.tabHeight)

$(document).on 'shown.bs.tab', 'a.nav-link', (e) ->
  $('#map').height(Profiles.tabHeight)
  Sisinta.map.instance.invalidateSize(false)
