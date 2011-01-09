-- Copyright 2010 Martin Thompson (martin@parallelpoints.com). All
-- rights reserved.
-- 
-- Redistribution and use in source, binary and physical forms, with
-- or without modification, are permitted provided that the following
-- conditions are met:
-- 
--    1. Redistributions of source code must retain the above
--       copyright notice, this list of conditions and the following
--       disclaimer.
-- 
--    2. Redistributions in binary or physical form must reproduce the
--       above copyright notice, this list of conditions and the
--       following disclaimer in the documentation and/or other
--       materials provided with the distribution.
-- 
-- THE FILES ARE PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-- NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
-- CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
-- WITH THE FILES OR THE USE OR OTHER DEALINGS IN THE FILES

package libv is

    -- Function: number of bits
    -- returns number of bits required to represent 'value'
    function number_of_bits (value : positive) return positive;

    type integer_vector is array (integer range <>) of integer;

    procedure assert_equal (prefix : string; got, expected : integer; level: severity_level := error);
    procedure assert_equal (prefix        : string; got, expected : integer_vector; level : severity_level := error);
end package libv;

package body libv is

    function number_of_bits (
        value : positive)
        return positive is
        variable bits : positive := 1;
    begin  -- function number_of_bits
        while 2**bits < value loop
            bits := bits + 1;
        end loop;
        return bits;
    end function number_of_bits;

    procedure assert_equal (
        prefix        : string;
        got, expected : integer;
        level : severity_level := error) is
    begin  -- procedure assert_equal
        assert got = expected
            report prefix & " wrong.  Got " & integer'image(got) & " expected " & integer'image(expected) & "(difference=" & integer'image(got-expected) &")"
            severity level;
    end procedure assert_equal;

    procedure assert_equal (
        prefix        : string;
        got, expected : integer_vector;
        level : severity_level := error) is 
        variable g,e : integer;
        constant top : integer := got'length-1;
    begin  -- procedure assert_equal
        assert got'length = expected'length
            report prefix & " length wrong.  Got " & integer'image(got'length)
            & " expected " & integer'image(expected'length)
            & "(difference=" & integer'image(got'length-expected'length) &")"
            severity level;
        for i in 0 to top loop
            g := got(got'low+i);
            e := expected(expected'low+i);
            assert g = e
                report prefix
                & "       got(" & integer'image(got'low+i) & ") = " & integer'image(g) & CR
                & "  expected(" & integer'image(expected'low+i) & ") = " & integer'image(e)
                severity level;
        end loop;  -- i
    end procedure assert_equal;
end package body libv;
