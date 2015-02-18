##
# Object extension to allow numbered LP variables to be initialised dynamically using the following
# syntax.
#
# [Capitalized_varname][lp var type suffix]
#
# Where lp var type suffix is either _b for binary, _i for integer, or _f for float.
# I.e
#
# Rating_i is the equivalent of Rating (type integer)
# Is_happy_b is the equivalent of Is_happy (type binary/boolean)
##
class << Object
  def const_missing(value)
    method_name = "#{value}" rescue ""
    if (("A".."Z").include?(method_name[0]))
      if(method_name.end_with?("b"))
        BV.send(method_name[0..(method_name[-2] == "_" ? -3 : -2)])
      elsif(method_name.end_with?("i"))
        IV.send(method_name[0..(method_name[-2] == "_" ? -3 : -2)])
      elsif(method_name.end_with?("f"))
        LV.send(method_name[0..(method_name[-2] == "_" ? -3 : -2)])
      end
    end
  end
end
