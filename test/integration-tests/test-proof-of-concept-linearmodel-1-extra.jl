data = Data[Data(X), Data(y)]
elements = ModelSanitizer._elements(data)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

m = LinearModel{Float64}()
fit!(m, X[training_rows, :], y[training_rows])

Test.@test predict(m) isa AbstractVector
Test.@test predict(m, X[training_rows, :]) isa AbstractVector
Test.@test predict(m, X[testing_rows, :]) isa AbstractVector

Test.@test predict(m) == predict(m, X[training_rows, :])
Test.@test mse(m) == mse(m, X[training_rows, :], y[training_rows])
Test.@test rmse(m) == rmse(m, X[training_rows, :], y[training_rows])
Test.@test r2(m) == r2(m, X[training_rows, :], y[training_rows])

Test.@test r2(m) > 0.8
Test.@test r2(m, X[testing_rows, :], y[testing_rows]) > 0.8

Test.@test m.X == X[training_rows, :]
Test.@test m.y == y[training_rows]
Test.@test all(m.X .== X[training_rows, :])
Test.@test all(m.y .== y[training_rows])
Test.@test !all(m.X .== 0)
Test.@test !all(m.y .== 0)

sanitize!(Model(m), Data(X), Data(y))

Test.@test predict(m) isa AbstractVector
Test.@test predict(m, X[training_rows, :]) isa AbstractVector
Test.@test predict(m, X[testing_rows, :]) isa AbstractVector

Test.@test predict(m) == predict(m, X[training_rows, :])
Test.@test mse(m) == mse(m, X[training_rows, :], y[training_rows])
Test.@test rmse(m) == rmse(m, X[training_rows, :], y[training_rows])
Test.@test r2(m) == r2(m, X[training_rows, :], y[training_rows])

Test.@test r2(m) > 0.8
Test.@test r2(m, X[testing_rows, :], y[testing_rows]) > 0.8

Test.@test m.X != X[training_rows, :]
Test.@test m.y != y[training_rows]
Test.@test !all(m.X .== X[training_rows, :])
Test.@test !all(m.y .== y[training_rows])
Test.@test all(m.X .== 0)
Test.@test all(m.y .== 0)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

m = LinearModel{Float64}()
fit!(m, X[training_rows, :], y[training_rows])

Test.@test m.X == X[training_rows, :]
Test.@test m.y == y[training_rows]
Test.@test all(m.X .== X[training_rows, :])
Test.@test all(m.y .== y[training_rows])
Test.@test !all(m.X .== 0)
Test.@test !all(m.y .== 0)

sanitize!(ForceSanitize(m.X))

Test.@test m.y == y[training_rows]
Test.@test all(m.y .== y[training_rows])
Test.@test !all(m.y .== 0)

Test.@test m.X != X[training_rows, :]
Test.@test !all(m.X .== X[training_rows, :])
Test.@test all(m.X .== 0)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

m = LinearModel{Float64}()
fit!(m, X[training_rows, :], y[training_rows])

Test.@test m.X == X[training_rows, :]
Test.@test m.y == y[training_rows]
Test.@test all(m.X .== X[training_rows, :])
Test.@test all(m.y .== y[training_rows])
Test.@test !all(m.X .== 0)
Test.@test !all(m.y .== 0)

sanitize!(ForceSanitize(m.X), ForceSanitize(m.y))

Test.@test m.X != X[training_rows, :]
Test.@test m.y != y[training_rows]
Test.@test !all(m.X .== X[training_rows, :])
Test.@test !all(m.y .== y[training_rows])
Test.@test all(m.X .== 0)
Test.@test all(m.y .== 0)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

m = LinearModel{Float64}()
fit!(m, X[training_rows, :], y[training_rows])

Test.@test m.X == X[training_rows, :]
Test.@test m.y == y[training_rows]
Test.@test all(m.X .== X[training_rows, :])
Test.@test all(m.y .== y[training_rows])
Test.@test !all(m.X .== 0)
Test.@test !all(m.y .== 0)

sanitize!(Model(m))

Test.@test m.X == X[training_rows, :]
Test.@test m.y == y[training_rows]
Test.@test all(m.X .== X[training_rows, :])
Test.@test all(m.y .== y[training_rows])
Test.@test !all(m.X .== 0)
Test.@test !all(m.y .== 0)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

m = LinearModel{Float64}()
fit!(m, X[training_rows, :], y[training_rows])

Test.@test m.X == X[training_rows, :]
Test.@test m.y == y[training_rows]
Test.@test all(m.X .== X[training_rows, :])
Test.@test all(m.y .== y[training_rows])
Test.@test !all(m.X .== 0)
Test.@test !all(m.y .== 0)

sanitize!(Model(m), Data(X))

Test.@test m.y == y[training_rows]
Test.@test all(m.y .== y[training_rows])
Test.@test !all(m.y .== 0)

Test.@test m.X != X[training_rows, :]
Test.@test !all(m.X .== X[training_rows, :])
Test.@test all(m.X .== 0)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

m = LinearModel{Float64}()
fit!(m, X[training_rows, :], y[training_rows])

Test.@test m.X == X[training_rows, :]
Test.@test m.y == y[training_rows]
Test.@test all(m.X .== X[training_rows, :])
Test.@test all(m.y .== y[training_rows])
Test.@test !all(m.X .== 0)
Test.@test !all(m.y .== 0)

sanitize!(Model(m), Data(X), Data(y))

Test.@test m.X != X[training_rows, :]
Test.@test m.y != y[training_rows]
Test.@test !all(m.X .== X[training_rows, :])
Test.@test !all(m.y .== y[training_rows])
Test.@test all(m.X .== 0)
Test.@test all(m.y .== 0)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

m = LinearModel{Float64}()
fit!(m, X[training_rows, :], y[training_rows])

Test.@test m.X == X[training_rows, :]
Test.@test m.y == y[training_rows]
Test.@test all(m.X .== X[training_rows, :])
Test.@test all(m.y .== y[training_rows])
Test.@test !all(m.X .== 0)
Test.@test !all(m.y .== 0)

sanitize!(Model(m), Data[Data(X), Data(y)])

Test.@test m.X != X[training_rows, :]
Test.@test m.y != y[training_rows]
Test.@test !all(m.X .== X[training_rows, :])
Test.@test !all(m.y .== y[training_rows])
Test.@test all(m.X .== 0)
Test.@test all(m.y .== 0)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

m = LinearModel{Float64}()
fit!(m, X[training_rows, :], y[training_rows])

Test.@test m.X == X[training_rows, :]
Test.@test m.y == y[training_rows]
Test.@test all(m.X .== X[training_rows, :])
Test.@test all(m.y .== y[training_rows])
Test.@test !all(m.X .== 0)
Test.@test !all(m.y .== 0)

sanitize!(Model(m), Data([[[[[[], [[[[X], [y]]]], []]]]]]))

Test.@test m.X != X[training_rows, :]
Test.@test m.y != y[training_rows]
Test.@test !all(m.X .== X[training_rows, :])
Test.@test !all(m.y .== y[training_rows])
Test.@test all(m.X .== 0)
Test.@test all(m.y .== 0)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

m = LinearModel{Float64}()
fit!(m, X[training_rows, :], y[training_rows])

Test.@test m.X == X[training_rows, :]
Test.@test m.y == y[training_rows]
Test.@test all(m.X .== X[training_rows, :])
Test.@test all(m.y .== y[training_rows])
Test.@test !all(m.X .== 0)
Test.@test !all(m.y .== 0)

sanitize!(Model(m), Data([[[[[[], [[[[[X, y]]]]], []]]]]]))

Test.@test m.X != X[training_rows, :]
Test.@test m.y != y[training_rows]
Test.@test !all(m.X .== X[training_rows, :])
Test.@test !all(m.y .== y[training_rows])
Test.@test all(m.X .== 0)
Test.@test all(m.y .== 0)

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

m = LinearModel{Float64}()
fit!(m, X[training_rows, :], y[training_rows])

Test.@test m.X == X[training_rows, :]
Test.@test m.y == y[training_rows]
Test.@test all(m.X .== X[training_rows, :])
Test.@test all(m.y .== y[training_rows])
Test.@test !all(m.X .== 0)
Test.@test !all(m.y .== 0)

sanitize!(Model(m), Data[Data(X[1:20]), Data(y[1:20])])

Test.@test m.X != X[training_rows, :]
Test.@test m.y != y[training_rows]
Test.@test !all(m.X .== X[training_rows, :])
Test.@test !all(m.y .== y[training_rows])
Test.@test all(m.X .== 0)
Test.@test all(m.y .== 0)
