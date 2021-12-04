"""

Librairie contenant des fonctions utiles qui sont utilisées dans le calepin principal

"""
function score_set(threshold::Real, dataset::DataFrame, M::StatsModels.TableRegressionModel)
    predictions = predict(M, dataset)
    y_hat = zeros(Int64, length(dataset.HeartDisease))
    y_hat[predictions .> threshold] .= 1
    score = round(correctrate(dataset.HeartDisease, y_hat), digits=3)
    return score
end

function find_best_threshold(dataset::DataFrame, M::StatsModels.TableRegressionModel)
    best_threshold = -1
    best_score = -1
    for threshold in 0:0.001:1
        score = score_set(threshold, dataset, M)
        if score > best_score
            best_score = score
            best_threshold = threshold
        end
    end
    return best_threshold
end

function age_to_string(ages::Vector{Int64})
    
    ages_string = String[]
    for age in ages
        if age < 35
            push!(ages_string, "1")
        elseif age < 45
            push!(ages_string, "2")
        elseif age < 50
            push!(ages_string, "3")
        elseif age < 55
            push!(ages_string, "4")
        elseif age < 60
            push!(ages_string, "5")
        elseif age < 65
            push!(ages_string, "6")
        elseif age < 70
            push!(ages_string, "7")
        else
            push!(ages_string, "8")
        end
    end
    return ages_string
end