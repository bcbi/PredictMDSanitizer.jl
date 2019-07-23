# ModelSanitizer

<p>
<a
href="https://doi.org/10.5281/zenodo.1291209">
<img
src="https://zenodo.org/badge/109460252.svg"/>
</a>
</p>

<p>
<a
href="https://app.bors.tech/repositories/18923">
<img
src="https://bors.tech/images/badge_small.svg"
alt="Bors enabled">
</a>
<a
href="https://travis-ci.com/bcbi/ModelSanitizer.jl/branches">
<img
src="https://travis-ci.com/bcbi/ModelSanitizer.jl.svg?branch=master">
</a>
<a
href="https://codecov.io/gh/bcbi/ModelSanitizer.jl">
<img
src="https://codecov.io/gh/bcbi/ModelSanitizer.jl/branch/master/graph/badge.svg">
</a>
</p>

## Usage

ModelSanitizer exports the `sanitize!` function and the `Model` and `Data`
structs. If your model is stored in `m` and your data are stored in `x1`,
`x2`, `x3`, etc. then you can sanitize your model with:
```julia
sanitize!(Model(M), Data(x1), Data(x2), Data(x3), ...)
```

## Example

```julia
using ModelSanitizer
using Statistics
using Test

mutable struct LinearModel{T}
    X::Matrix{T}
    y::Vector{T}
    beta::Vector{T}
    function LinearModel{T}()::LinearModel{T} where T
        m::LinearModel{T} = new()
        return m
    end
end

function fit!(m::LinearModel{T}, X::Matrix{T}, y::Vector{T})::LinearModel{T} where T
    m.X = deepcopy(X)
    m.y = deepcopy(y)
    m.beta = beta = (m.X'm.X)\(m.X'm.y)
    return m
end

function predict(m::LinearModel{T}, X::Matrix{T})::Vector{T} where T
    y_hat::Vector{T} = X * m.beta
    return y_hat
end

function mse(y::Vector{T}, y_hat::Vector{T})::T where T
    _mse::T = mean((y .- y_hat).^2)
    return _mse
end

function mse(m::LinearModel{T}, X::Matrix{T}, y::Vector{T})::T where T
    y_hat::Vector{T} = predict(m, X)
    _mse::T = mse(y, y_hat)
    return _mse
end

function mse(m::LinearModel{T})::T where T
    X::Matrix{T} = m.X
    y::Vector{T} = m.y
    _mse::T = mse(m, X, y)
    return _mse
end

rmse(varargs...) = sqrt(mse(varargs...))

function r2(y::Vector{T}, y_hat::Vector{T})::T where T
    y_bar::T = mean(y)
    SS_tot::T = sum((y .- y_bar).^2)
    SS_res::T = sum((y .- y_hat).^2)
    _r2::T = 1 - SS_res/SS_tot
    return _r2
end

function r2(m::LinearModel{T}, X::Matrix{T}, y::Vector{T})::T where T
    y_hat::Vector{T} = predict(m, X)
    _r2::T = r2(y, y_hat)
    return _r2
end

function r2(m::LinearModel{T})::T where T
    X::Matrix{T} = m.X
    y::Vector{T} = m.y
    _r2::T = r2(m, X, y)
    return _r2
end

X = randn(Float64, 100_000, 14)
y = X * randn(Float64, 14) + randn(100_000)
m = LinearModel{Float64}()
testing_rows = 1:2:100_000
training_rows = setdiff(1:100_000, testing_rows)
fit!(m, X[training_rows, :], y[training_rows])

@show mse(m)
@show rmse(m)
@show r2(m)

@show mse(m, X[testing_rows, :], y[testing_rows])
@show rmse(m, X[testing_rows, :], y[testing_rows])
@show r2(m, X[testing_rows, :], y[testing_rows])

Test.@test m.X == X[training_rows, :]
Test.@test m.y == y[training_rows]
Test.@test all(m.X .== X[training_rows, :])
Test.@test all(m.y .== y[training_rows])
Test.@test !all(m.X .== 0)
Test.@test !all(m.y .== 0)

sanitize!(Model(m), Data(X), Data(y)) # sanitize the model with ModelSanitizer

Test.@test m.X != X[training_rows, :]
Test.@test m.y != y[training_rows]
Test.@test !all(m.X .== X[training_rows, :])
Test.@test !all(m.y .== y[training_rows])
Test.@test all(m.X .== 0)
Test.@test all(m.y .== 0)
```

### Output of example
```julia
```
