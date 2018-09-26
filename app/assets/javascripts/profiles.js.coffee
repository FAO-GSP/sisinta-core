Profiles =
  tabHeight: 0
Sisinta.profiles = Profiles

$(document).on 'turbolinks:load', ->
  # Calculate max height of tabs in profile-show
  $('#profile-show .tab-content .tab-pane').each ->
    # Activate the tab so it has a defined height
    $(this).addClass('active')

    height = $(this).height()
    Profiles.tabHeight = if height > Profiles.tabHeight then height else Profiles.tabHeight

    # Deactivate the tab
    $(this).removeClass('active')

  # Activate the first tab and set height to max
  $('#profile-show .tab-content .tab-pane:first').addClass('active')
  $('#profile-show').height(Profiles.tabHeight)

# Recalculate size of map when showing it's tab
$(document).on 'shown.bs.tab', '#profile-show a.nav-link', (e) ->
  if e.target.id == 'map-tab'
    $('#map').height(Profiles.tabHeight)
    Sisinta.map.instance.invalidateSize(false)
