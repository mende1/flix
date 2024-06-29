module MoviesHelper
  def total_gross(movie)
    movie.flop? ? "Flop!" : "R$ " + number_to_human(movie.total_gross)
  end

  def year_of(movie)
    movie.released_on.year
  end

  def format_stars(average_stars)
    if average_stars
      render "shared/stars", percent: (average_stars / 5.0) * 100.0
    else
      content_tag(:strong, "No reviews")
    end
  end
end
