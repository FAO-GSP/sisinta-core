# Leaflet Infobox control with text and title.

L.Control.Info = L.Control.extend({
  options:
    position: 'topleft'

  onAdd: (map) ->
    wrapper = L.DomUtil.create('div', 'info')
    title = L.DomUtil.create('h6', 'col title', wrapper)
    text = L.DomUtil.create('p', 'col text', wrapper)

    title.innerHTML = this.options.title
    text.innerHTML = this.options.text

    return wrapper

  onRemove: (map) ->
    # Nothing to do on remove.
})

# Factory function named after the class of the control plugin to allow
# chaining.
L.control.info = (opts) ->
  return new L.Control.Info(opts)
