require 'test_helper'

class LetterMailTest < ActionMailer::TestCase
  test "letter" do
    @expected.subject = 'LetterMail#letter'
    @expected.body    = read_fixture('letter')
    @expected.date    = Time.now

    assert_equal @expected.encoded, LetterMail.create_letter(@expected.date).encoded
  end

end
