module PCA9548

using PyCall

export MultiI2C

"""
```julia
MultiI2C(i2c)
```
Build an object to control an i2c multiplexer attached via the provided i2c bus.
Channels on this multiplexer can be accessed using `m[channel]` indexing syntax.
"""
struct MultiI2C
    multi
    function MultiI2C(i2c)
        lib = pyimport("adafruit_tca9548a")
        new(lib.TCA9548A(i2c))
    end
end

#PyCall is cute and tries to shift the index, but we want to index ports from 0 in julia.
#Therefore, the weird i+1
Base.getindex(m::MultiI2C,i::Int) = m.multi[i+1]
Base.firstindex(::MultiI2C) = 0
Base.lastindex(::MultiI2C) = 7

end # module PCA9548
