# Profile View helpers.

module ProfilesHelper
  # Wraps the yielded th content (usually a short identifier) with a tooltip
  # explaining or expanding said identifier.
  def th_with_tooltip(tooltip)
    content_tag :th, scope: 'col', data: { toggle: 'tooltip', placement: 'right' }, title: tooltip do
      yield
    end
  end
end
