require 'minitest/autorun'
require 'minitest/rg'

# NOTE
# I made my method in the Array class in order to plug in to the provide array of objects.
# The method takes one input or array, as provide on test 4.

class Array

  def where(inPUT)
    key = inPUT.keys.first.to_s #GRABS KEY
    symKey = key.to_sym           #SETS KEY TO A SYMBOL
    key2 = inPUT.keys[1].to_s
    symKey2 = key2.to_sym
    @sVal
    @iVal
    @returnArr = [] # ARRAY FOR FINAL HASH

    # LOOPS AND PULLS OUT VALUES
    inPUT.each do |i|
        if i[1].to_s =~ /[[a-z]]/i
            @sVal = i[1]     #IF VALUE EQUAL TO A STRING
         else
            @iVal = i[1]      #IF VALUE EQUAL TO A INTEGER
        end
    end

    # CONDITIANAL STATEMENT TO PUSH CORRECT HASHES
    if @iVal != nil && @sVal != nil # IF TWO VALUES ARE PRESENT
        self.map do |prop|
            if ( prop[symKey] == @iVal && @sVal.match(prop[symKey2]) )
                @returnArr.push(prop)
            end
        end

    elsif @iVal == @iVal.to_i  # IF ON VALUE IS PRESENT AND EQUAL AN INTEGER
        self.map do |prop|
            if ( prop[symKey] == @iVal )
                @returnArr.push(prop)
            end
        end

    elsif @sVal.to_s =~ /[[a-z]]/i  # IF ON VALUE IS PRESENT AND EQUAL AN STRING
        self.map do |prop|
            if ( prop[symKey] == @sVal )
                    @returnArr.push(prop)
            elsif ( @sVal.match(prop[symKey]) )
                    @returnArr.push(prop)
            end
        end
    end

    return @returnArr

  end

end #END OF CLASS ARRAY

#########################
# TEST FOR WHERE METHOD #
#          BELOW        #
#########################


class WhereTest < MiniTest::Unit::TestCase

  def setup
    @boris   = {:name => 'Boris The Blade', :quote => "Heavy is good. Heavy is reliable. If it doesn't work you can always hit them.", :title => 'Snatch', :rank => 4}
    @charles = {:name => 'Charles De Mar', :quote => 'Go that way, really fast. If something gets in your way, turn.', :title => 'Better Off Dead', :rank => 3}
    @wolf    = {:name => 'The Wolf', :quote => 'I think fast, I talk fast and I need you guys to act fast if you wanna get out of this', :title => 'Pulp Fiction', :rank => 4}
    @glen    = {:name => 'Glengarry Glen Ross', :quote => "Put. That coffee. Down. Coffee is for closers only.",  :title => "Blake", :rank => 5}

    @fixtures = [@boris, @charles, @wolf, @glen]
  end

  def test_where_with_exact_match
    assert_equal( [@wolf], @fixtures.where(:name => 'The Wolf') )
  end

  def test_where_with_partial_match
    assert_equal( [@charles, @glen], @fixtures.where(:title => /^B.*/) )
  end

  def test_where_with_mutliple_exact_results
    assert_equal( [@boris, @wolf], @fixtures.where(:rank => 4) )
  end

  def test_with_with_multiple_criteria
    assert_equal( [@wolf], @fixtures.where(:rank => 4, :quote => /get/) )
  end

  def test_with_chain_calls
    assert_equal( [@charles], @fixtures.where(:quote => /if/i).where(:rank => 3) )
  end
end
