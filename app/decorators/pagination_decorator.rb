# Decorator used to paginate models with kaminari.

class PaginationDecorator < Draper::CollectionDecorator
  # Delegate every kaminari method used in views.
  delegate :current_page, :total_pages, :limit_value, :entry_name,
    :total_count, :offset_value, :last_page?
end
