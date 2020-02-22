using Pkg
Pkg.activate("../")
using Econometrics, DelimitedFiles, Statistics
θtrue = [0.95, 0.5, 1.0]
bias = zeros(3,1)
rmse = zeros(3,1)
ci99 = zeros(3,1)
ci95 = zeros(3,1)
ci90 = zeros(3,1)
files = [
    "raw_statistic"]

for j = 1:1
    d = readdlm(files[j])
    error = d[:,1:3] .- θtrue'
    b = mean(error, dims=1) ./θtrue'
    r = sqrt.(mean(error.^2.0, dims=1)) ./θtrue'
    c99 = mean(d[:,10:12], dims=1)
    c95 = mean(d[:,13:15], dims=1)
    c90 = mean(d[:,16:18], dims=1)
    bias[:,j] = b
    rmse[:,j] = r
    ci99[:,j] = c99
    ci95[:,j] = c95
    ci90[:,j] = c90
end    
prettyprint(bias)
prettyprint(rmse)
prettyprint(ci99)
prettyprint(ci95)
prettyprint(ci90)
