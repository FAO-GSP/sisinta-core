# Default pagination bar related helpers
module PaginationHelper
  # Returns buttons for choosing page size
  def page_size_selector(sizes = %w{10 20 50})
    # A button for each size
    sizes.collect do |size|
      # Should know if it's active
      content_tag(:li, class: class_for(size, sizes)) do
        link_to size, url_for(page_size: size),
          class: 'page-link'
      end
    end.join.html_safe
  end

  private

  # Returns css classes for active page-items
  def class_for(size, sizes)
    classes = %w{page-item}

    # Restrict to known sizes, 20 by default
    active_filter = sizes.include?(params[:page_size]) ? params[:page_size] : '20'
    classes.push 'active' if size == active_filter

    classes.join ' '
  end
end
