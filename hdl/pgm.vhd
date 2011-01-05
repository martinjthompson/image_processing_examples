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

package pgm is

    subtype pixel is integer range 0 to 255;
    type pixel_vector is array (integer range <>) of pixel;
    type pixel_vector_ptr is access pixel_vector;
    type image is record  -- storage for all the relevant info
        width, height : positive;
        pixels        : pixel_vector_ptr;
    end record image;
    subtype coordinate is positive;
    
    function pgm_read (
         filename : string)
        return image;
    procedure pgm_write (
        filename : in    string;
        i        : inout image);

    procedure get_pixel (
        i    : inout image;
        x, y : in    coordinate;
        val  : out   pixel);
    procedure set_pixel (
        i    : inout image;
        x, y : in    coordinate;
        val  : in    pixel);
end package pgm;

package body pgm is

    function pgm_read (
        filename : string)
        return image is
    begin  -- function pgm_read
        return image'(width => 1, height => 1, pixels => new pixel_vector(0 to 1));
    end function pgm_read;
    procedure pgm_write (
        filename : in    string;
        i         : inout image) is
    begin  -- procedure pgm_write
        
    end procedure pgm_write;
    procedure get_pixel (
        i    : inout image;
        x, y : in    coordinate;
        val  : out   pixel) is
    begin  -- procedure get_pixel
        
    end procedure get_pixel;
    procedure set_pixel (
        i    : inout image;
        x, y : in    coordinate;
        val  : in    pixel) is
    begin  -- procedure set_pixel
        
    end procedure set_pixel;
end package body pgm;
----------------------------------------------------------------------------------------------------------------------------------

entity tb_pgm is
end entity tb_pgm;

use work.libv.all;
use work.pgm.all;
architecture test of tb_pgm is
begin  -- architecture test
    test1: process is
        variable i : image;
        constant testdata : pixel_vector := (
            000,001,002,003,005,006,007,
            000,000,000,000,000,000,000,
            255,255,255,255,255,255,255,
            100,100,100,100,100,000,000
        );
    begin  -- process test1
        i := pgm_read("test.pgm");
        assert_equal("PGM Width", i.width, 8);
        assert_equal("PGM Height", i.width, 4);
        assert_equal("PGM data", integer_vector(i.pixels.all), integer_vector(testdata));
        wait;
    end process test1;

end architecture test;
