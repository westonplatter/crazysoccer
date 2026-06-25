require "minitest/autorun"

# Standalone test for JIRA SCRUM-1: "Create an md file with a hello message in it".
# Runs without booting Rails: `ruby test/standalone/hello_md_test.rb` from the repo root.
class HelloMdTest < Minitest::Test
  HELLO_PATH = File.expand_path("../../HELLO.md", __dir__)

  def test_hello_md_exists
    assert File.exist?(HELLO_PATH),
           "Expected HELLO.md to exist at the repository root (#{HELLO_PATH})"
  end

  def test_hello_md_contains_a_hello_greeting
    contents = File.read(HELLO_PATH)
    assert_match(/hello/i, contents,
                 "Expected HELLO.md to contain a hello greeting (case-insensitive 'hello')")
  end

  def test_hello_md_is_not_empty
    contents = File.read(HELLO_PATH)
    refute_empty contents.strip, "Expected HELLO.md to have content"
  end
end
