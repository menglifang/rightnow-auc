class HeaderCell < Cell::Rails

  def left(opts)
    @title, @description = opts[:title], opts[:description]

    render
  end

  def right(opts)
    @title, @out_link = opts[:title], opts[:out_link]

    render
  end

end
