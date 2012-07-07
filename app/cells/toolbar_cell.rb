class ToolbarCell < Cell::Rails

  def display(opts)
    @buttons = opts[:buttons]

    render
  end

end
