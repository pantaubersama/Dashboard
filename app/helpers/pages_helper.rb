module PagesHelper
  def show_count_table(page, total_row_per_page, total_data)
    from = page.present? && page.to_i != 1 ? ((page.to_i - 1) * Pagy::VARS[:items])+1 : 1
    to = page.present? && page.to_i != 1 ? ((page.to_i - 1) * Pagy::VARS[:items]) + total_row_per_page : total_row_per_page
    "Displaying Content #{from} - #{to} of #{total_data} in total"
  end
end
