# typed: true
require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutSandwichCode < Neo::Koan

  def count_lines(file_name)
    # Используем File.open для явной работы с файлом
    count = 0
    File.open(file_name, 'r') do |file|
      while file.gets
        count += 1
      end
    end
    count
  end

  def test_counting_lines
    assert_equal 4, count_lines("example_file.txt")
  end

  # ------------------------------------------------------------------

  def find_line(file_name)
    # Используем File.open для явной работы с файлом
    File.open(file_name, 'r') do |file|
      while (line = file.gets)
        return line if line.match(/e/)
      end
    end
    nil # Если строки не найдены, возвращаем nil
  end

  def test_finding_lines
    assert_equal "test\n", find_line("example_file.txt")
  end

  # ------------------------------------------------------------------

  def file_sandwich(file_name)
    # Используем File.open для работы с файлом
    File.open(file_name, 'r') do |file|
      yield(file)
    end
  end

  # Используем file_sandwich для абстракции открытия и закрытия файла
  def count_lines2(file_name)
    file_sandwich(file_name) do |file|
      count = 0
      while file.gets
        count += 1
      end
      count
    end
  end

  def test_counting_lines2
    assert_equal 4, count_lines2("example_file.txt")
  end

  # ------------------------------------------------------------------

  def find_line2(file_name)
    file_sandwich(file_name) do |file|
      result = ""
      while (line = file.gets)
        result = line if line.match(/e/)
      end
      result
    end
  end

  def test_finding_lines2
    assert_equal "test\n", find_line2("example_file.txt")
  end

  # ------------------------------------------------------------------

  def count_lines3(file_name)
    # Используем блок для автоматического открытия и закрытия файла
    count = 0
    File.open(file_name, 'r') do |file|
      while file.gets
        count += 1
      end
    end
    count
  end

  def test_open_handles_the_file_sandwich_when_given_a_block
    assert_equal 4, count_lines3("example_file.txt")
  end

end
