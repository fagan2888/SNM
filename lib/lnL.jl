# specialized likelihood for MCMC using net
function LL(θ, m, S, model, info, useJacobian=true)
    k = size(m,1)
    ms = zeros(S, k)
    Threads.@threads for s = 1:S
        @inbounds ms[s,:] = Float64.(model(transform(ILSNM_model(θ[:])', info)'))
    end
    mbar = mean(ms,dims=1)[:]
    Σ = cov(ms)
    x = (m .- mbar)[:]
    lnL = try
        if useJacobian
            lnL =-0.5*logdet(Σ) - 0.5*x'*inv(Σ)*x
        else
            lnL = -0.5*x'*inv(Σ)*x
        end    
    catch
        lnL = -Inf
    end    
    return lnL
end

# version without net
function LL(θ, m, S, useJacobian=true)
    k = size(m,1)
    ms = zeros(S, k)
    Threads.@threads for s = 1:S
        @inbounds ms[s,:] = ILSNM_model(θ[:])
    end
    mbar = mean(ms,dims=1)[:]
    Σ = cov(ms)
    x = (m .- mbar)[:]
    lnL = try
        if useJacobian
            lnL =-0.5*logdet(Σ) - 0.5*x'*inv(Σ)*x
        else
            lnL = -0.5*x'*inv(Σ)*x
        end    
    catch
        lnL = -Inf
    end    
    return lnL
end

