class WordReader

  def read_from_file(file_name)
    unless File.exist?(file_name)
      return nil
    end

    f = File.new(file_name, 'r:UTF-8')

    lines = f.readlines
    lines.shuffle!

    f.close

    lines.sample.chomp
  end
end