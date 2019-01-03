using NLPModels, Unicode

include(joinpath(path, "consistency.jl"))

function test_consistency()
  for problem in [:brownden, :hs5, :hs6, :hs10, :hs11, :hs14]
    problem_s = string(problem)
    @printf("Checking problem %-20s", problem_s)
    problem_f = eval(problem)
    nlp_autodiff = eval(Meta.parse("$(problem)_autodiff"))()
    nlp_mpb = MathProgNLPModel(problem_f())
    nlp_manual = eval(Meta.parse(uppercase(problem_s)))()
    nlps = [nlp_autodiff; nlp_mpb; nlp_manual]

    consistent_nlps(nlps)
  end
end

test_consistency()
