module MoviesHelper
  def total_gross(movie)
    movie.flop? ? "Flop!" : "R$ " + number_to_human(movie.total_gross)
  end

  def year_of(movie)
    movie.released_on.year
  end
end
