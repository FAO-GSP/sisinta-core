# Profile View helpers.

module ProfilesHelper
  # Wraps the yielded content (usually a short identifier) with a tooltip
  # explaining or expanding said identifier.
  def tag_with_tooltip(tooltip, tag_name = :th)
    content_tag tag_name, scope: 'col', data: { toggle: 'tooltip', placement: 'right' }, title: tooltip do
      yield
    end
  end

  # Concatenates metadata (in parentheses) if any.
  def concat_metadata(text, metadata)
    acc = [text]

    acc << "(#{metadata})" if metadata.present?

    acc.join(' ')
  end

  # Generates a tooltip text with metadata for Layer attributes.
  def layer_tooltip(profile, field)
    concat_metadata Layer.human_attribute_name(field), profile.metadata_for(field)
  end
end
