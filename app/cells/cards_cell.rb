class CardsCell < Cell::Rails

  def wall(opts)
    @cards = opts[:cards]
    @brief = opts[:brief] || :brief

    render
  end

  def card(opts)
    @card  = opts[:card]
    @brief = opts[:brief] || :brief

    render
  end

end
