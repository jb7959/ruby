require "test/unit"
begin
  require "Win32API"
rescue LoadError
end

class TestWin32API < Test::Unit::TestCase
  def test_params_string
    m2w = Win32API.new("kernel32", "MultiByteToWideChar", "ilpipi", "i")
    str = "utf-8 string".encode("utf-8")
    buf = "\0" * (str.size * 2)
    assert_equal str.size, m2w.call(65001, 0, str, str.bytesize, buf, str.size)
    assert_equal str.encode("utf-16le"), buf.force_encoding("utf-16le")
  end

  def test_params_array
    m2w = Win32API.new("kernel32", "MultiByteToWideChar", ["i", "l", "p", "i", "p", "i"], "i")
    str = "utf-8 string".encode("utf-8")
    buf = "\0" * (str.size * 2)
    assert_equal str.size, m2w.call(65001, 0, str, str.bytesize, buf, str.size)
    assert_equal str.encode("utf-16le"), buf.force_encoding("utf-16le")
  end
end if defined?(Win32API)
