"""

Librairie contenant des fonctions utiles qui sont utilisées dans le calepin principal

"""

using CSV, DataFrames, Gadfly, GLM, Statistics

function geomFigMaker(data::DataFrame, quantitative::String, qualitative::String)
    data_without_missing = dropmissing(data)
    hommes, femmes = groupby(data_without_missing, :Sex)
    f1 = plot(x=data_without_missing.HeartDisease, y=data_without_missing[:, quantitative], Geom.boxplot, Guide.title("Diagramme a moustache pour " * quantitative))
    f2 = plot(x=hommes.HeartDisease, y=data_without_missing[:, quantitative], Geom.boxplot, Guide.title("Hommes: Diagramme pour " * quantitative))
    f3 = plot(x=femmes.HeartDisease, y=data_without_missing[:, quantitative], Geom.boxplot, Guide.title("Femmes: Diagramme pour " * quantitative))
    figures = [f1, f2, f3]
    groupes = groupby(data_without_missing, data_without_missing[:, qualitative])
    groupes_hommes = groupby(hommes, hommes[:, qualitative])
    groupes_femmes = groupby(femmes, femmes[:, qualitative])
    for i in 1:length(groupes)
        f_men_women = plot(x=groupes[i].HeartDisease, y=groupes[i][:, qualitative], Geom.boxplot)
        f_men = plot(x=groupes_hommes[i].HeartDisease, y=groupes_hommes[i][:, qualitative], Geom.boxplot)
        f_women = plot(x=groupes_femmes[i].HeartDisease, y=groupes_femmes[i][:, qualitative], Geom.boxplot)
        push!(figures, f_men_women)
        push!(figures, f_men)
        push!(figures, f_women)
    end
    return figures
end
    

    


    



