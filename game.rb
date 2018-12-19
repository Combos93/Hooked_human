class Game
  attr_reader :status, :errors, :letters,
              :good_letters, :bad_letters

  def initialize(slovo)
    @letters = get_letters(slovo)

    @errors = 0
    @status = 0

    @good_letters = []
    @bad_letters = []
  end

  def get_letters(slovo)
    if [nil, ''].include?(slovo)
      return []
    else
      UnicodeUtils.upcase(slovo).split('')
    end
  end

  def next_step(bukva)
    bukva = UnicodeUtils.upcase(bukva)

    if @status == -1 ||
       @status == 1
      return
    end

    if @good_letters.include?(bukva) ||
       @bad_letters.include?(bukva)
      return
    end

    if @letters.include?(bukva) ||
       (bukva == 'Ё' && @letters.include?('Е')) ||
       (bukva == 'И' && @letters.include?('Й')) ||
       (bukva == 'Й' && @letters.include?('И')) ||
       (bukva == 'Е' && @letters.include?('Ё'))

      @good_letters << bukva

      if bukva == 'Е' || bukva == 'Ё'
        @good_letters.push('Е', 'Ё')

      elsif bukva == 'И' || bukva == 'Й'
        @good_letters.push('И', 'Й')

      elsif (letters - good_letters).empty?
        @status = 1
      end
    else

      @bad_letters << bukva

      @errors += 1

      if @errors >= 7
        @status = -1
      end
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"
    bukva = ''
    while bukva == '' do
      bukva = STDIN.gets.chomp
    end
    next_step(bukva)
  end
end