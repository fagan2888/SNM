using Statistics
function auxstat(θ)
    n = 1000
    μ_1, μ_2, σ_1, σ_2, prob = θ
    d1=randn(n).*σ_1 .+ μ_1
    d2=randn(n).*σ_2 .+ μ_2
    ps=rand(n).<prob
    data=zeros(n)
    data[ps].=d1[ps]
    data[.!ps].=d2[.!ps]
    r=0:0.1:1
    sqrt(Float64(n)).* quantile.(Ref(data),r)
end    

function TrueParameters()
    [1.0, 0.0, 0.2, 2.0, 0.4]
end    

function PriorSupport()
    lb = [0.0, -2.0, 0.0, 0.0, 0.0]
    ub = [3.0, 2.0, 1.0, 4.0, 1.0]
    lb,ub
end    

function PriorMean()
    lb,ub = PriorSupport()
    (ub - lb) ./ 2.0
end

function Prior(θ)
    lb,ub = PriorSupport()
    a = 0.0
    if (all(θ .>= lb) & all(θ .<= ub))
        a = 1.0
    end
    return a
end


