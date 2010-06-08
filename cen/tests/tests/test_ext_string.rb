require '../cen'
require 'test/unit'

class TestString < Test::Unit::TestCase
    def test_colours
        assert_equal("test".gray,   "\033[1;#{30}mtest\033[0m")
        assert_equal("test".red,    "\033[1;#{31}mtest\033[0m")
        assert_equal("test".green,  "\033[1;#{32}mtest\033[0m")
        assert_equal("test".yellow, "\033[1;#{33}mtest\033[0m")
        assert_equal("test".blue,   "\033[1;#{34}mtest\033[0m")
        assert_equal("test".purple, "\033[1;#{35}mtest\033[0m")
        assert_equal("test".cyan,   "\033[1;#{36}mtest\033[0m")
        assert_equal("test".white,  "\033[1;#{37}mtest\033[0m")
    end
    
    def test_ish_colours
        assert_equal("test".grayish,   "\033[0;#{30}mtest\033[0m")
        assert_equal("test".redish,    "\033[0;#{31}mtest\033[0m")
        assert_equal("test".greenish,  "\033[0;#{32}mtest\033[0m")
        assert_equal("test".yellowish, "\033[0;#{33}mtest\033[0m")
        assert_equal("test".blueish,   "\033[0;#{34}mtest\033[0m")
        assert_equal("test".purpleish, "\033[0;#{35}mtest\033[0m")
        assert_equal("test".cyanish,   "\033[0;#{36}mtest\033[0m")
        assert_equal("test".whiteish,  "\033[0;#{37}mtest\033[0m")
    end
end
