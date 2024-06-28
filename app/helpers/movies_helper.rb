module MoviesHelper
  def total_gross(movie)
    movie.flop? ? "Flop!" : "R$ " + number_to_human(movie.total_gross)
  end

  def year_of(movie)
    movie.released_on.year
  end

  def average_stars(movie)
    if movie.average_stars.zero?
      content_tag(:strong, "No reviews")
    else
      render "shared/stars", percent: movie.percent_stars
    end
  end
end
