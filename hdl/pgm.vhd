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

    subtype coordinate is natural;
    subtype pixel is integer range 0 to 255;
    type pixel_vector is array (integer range <>) of pixel;
    type pixel_vector_ptr is access pixel_vector;
    type image is record  -- storage for all the relevant info
        width, height : coordinate;
        pixels        : pixel_vector_ptr;
    end record image;
    impure function pgm_read (
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

use std.textio.all;
use work.libv.all;
package body pgm is

    impure function pgm_read (
        filename : string)
        return image is
        variable result : image;
        file pgmfile    : text;
        variable l      : line;
        variable s      : string(1 to 2);
        variable ints   : integer_vector(1 to 3);
        variable count  : integer := ints'low;
        variable good   : boolean;
        constant empty_image : pixel_vector := (0,0);
    begin  -- function pgm_read
        -- setup some defaults
        result.width := 0;
        result.height := 0;
        --result.pixels := new pixel_vector'(empty_image);
        file_open(pgmfile, filename, read_mode);
        readline(pgmfile, l);
        read(l, s(1));
        read(l, s(2), good);
        if not good or s /= "P5" then
            report "PGM file not P5 type" severity warning;
            file_close(pgmfile);
            return result;
        end if;
        loop                                -- read until we have 3 integers (width, height and colour depth).  
            loop
                readline(pgmfile, l);
                report "a" & l.all;
                exit when l.all(1) = '#';  -- skip comments;
                report "b";
                if l'length = 0 then
                    report "EOF reached in pgmfile before opening integers found" severity warning;
                    file_close(pgmfile);
                    return result;
                end if;
                report "c";
                loop
                    report "d" & l.all;
                    read(l, ints(count), good);
                    count := count + 1;
                    exit when not good;
                end loop;
            end loop;
            exit when count > ints'high;
        end loop;
        -- Now we have our header sorted. store it
        result.width  := ints(1);
        result.height := ints(2);
        return result;
    end function pgm_read;
    procedure pgm_write (
        filename : in    string;
        i        : inout image) is
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
    test1 : process is
        variable i : image;
        constant testdata : pixel_vector := (
            000, 001, 002, 003, 005, 006, 007,
            000, 000, 000, 000, 000, 000, 000,
            255, 255, 255, 255, 255, 255, 255,
            100, 100, 100, 100, 100, 000, 000
        );
    begin  -- process test1
        -- test on a proper image
        i := pgm_read("testimage.pgm");
        assert_equal("PGM Width", i.width, 8);
        assert_equal("PGM Height", i.height, 4);
        assert i.pixels /= null report "pixels are null" severity error;
        assert_equal("PGM data", integer_vector(i.pixels.all), integer_vector(testdata));

        -- make sure we return a non-image for the ASCII style PGM file
        i := pgm_read("testimage_ascii.pgm");
        assert_equal("ASCII PGM Width", i.width, 0);
        assert_equal("ASCII PGM Height", i.height, 0);
        assert i.pixels = null report "ASCII pixels should be null" severity error;
        
        report "End of tests" severity note;
        wait;
    end process test1;

end architecture test;
