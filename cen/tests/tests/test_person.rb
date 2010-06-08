require '../cen'
require 'test/unit'

class TestString < Test::Unit::TestCase    
    def test_valid
        good_search = Person.new('s0824586')
        bad_search = Person.new('maybethiswillbetrueoneday')
        
        assert(good_search.valid?)
        assert_not_equal(bad_search.valid?, true)
    end
end
