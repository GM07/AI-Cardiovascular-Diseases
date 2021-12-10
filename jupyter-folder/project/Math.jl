"""

Librairie contenant des fonctions utiles qui sont utilisées dans le calepin principal

"""

"""
    score_set(threshold::Real, dataset::DataFrame, M::StatsModels.TableRegressionModel)
    Retourne le nombre de bonnes prédictions d'un modèle sur un dataset précis à un seuil précis
"""
function score_set(threshold::Real, dataset::DataFrame, M::StatsModels.TableRegressionModel)
    predictions = predict(M, dataset)
    y_hat = zeros(Int64, length(dataset.HeartDisease))
    y_hat[predictions .> threshold] .= 1
    score = round(correctrate(dataset.HeartDisease, y_hat), digits=3)
    return score
end

"""
    find_best_threshold(dataset::DataFrame, M::StatsModels.TableRegressionModel)
    Retourne le meilleur seuil d'un modèle sur un dataset pour avoir la meilleure précision
"""
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

"""
    rocplot(gt::Array{<:Real},scores::Array{<:Real})
    Affiche la courbe ROC 
"""
function rocplot(gt::Array{<:Real},scores::Array{<:Real})

    # Compute the ROC curve for 100 equally spaced thresholds - see `roc()`
    r = roc(gt, scores, 0:.01:1)

    # Compute the true positive rate and false positive rate
    tpr = true_positive_rate.(r)
    fpr = false_positive_rate.(r)

    return plot(x=fpr, y=tpr, Geom.line, Geom.abline(color="red", style=:dash),
        Guide.xlabel("False Positive Rate"), Guide.ylabel("True Positive Rate"))

end

"""
    convert_categorical_params(data::DataFrame, param::Symbol)
    Convertit les données catégorielles en variables indicatrices (avec des 1 et des 0)
"""
function convert_categorical_params(data::DataFrame, param::Symbol)
    values = data[:, param]
    param_possible_values = unique(values)
    dict = StatsModels.ContrastsMatrix(StatsModels.DummyCoding(), param_possible_values).invindex
    dict[param_possible_values[1]] = 0
    
    final_matrix = zeros(length(values), length(keys(dict)))
        
    for i in 1:length(values)
        value = values[i]
        index = dict[value]
        if index > 0
            final_matrix[i, index] = 1
        end
    end

    transformed_data = data
    for col in eachcol(final_matrix)
        transformed_data = hcat(transformed_data, col, makeunique=true)
    end

    select!(transformed_data, Not(param))

    return transformed_data
end

"""
    convert_categorical_params(data::DataFrame, param::Symbol)
    Convertit les données catégorielles en variables indicatrices (avec des 1 et des 0) de plusieurs paramètres catégorielles
"""
function convert_categorical_params(data::DataFrame, params::Array{<:Symbol})
    t = data
    for param in params
        t = convert_categorical_params(t, param)
    end

    return t
end
